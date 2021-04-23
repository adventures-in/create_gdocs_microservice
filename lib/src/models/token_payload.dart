import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_payload.freezed.dart';
part 'token_payload.g.dart';

@freezed
class TokenPayload with _$TokenPayload {
  TokenPayload._();

  factory TokenPayload(
      {required int exp,
      required int iat,
      required String aud,
      required String iss,
      required String sub,
      required int auth_time}) = _TokenPayload;

  // cached values
  late final DateTime expirationTime =
      DateTime.fromMillisecondsSinceEpoch(exp * 1000);
  late final DateTime issuedAtTime =
      DateTime.fromMillisecondsSinceEpoch(iat * 1000);
  late final DateTime authenticationTime =
      DateTime.fromMillisecondsSinceEpoch(auth_time * 1000);
  late final Duration tokenLifetime = Duration(seconds: exp - iat);

  // Check token components and throws if anything is invalid.
  //  + 5 minutes for clock skew ?
  void validate(String projectId) {
    final currentDate = DateTime.now();

    // If the current date is after the expiration date, token is expired
    if (currentDate.isAfter(expirationTime)) throw 'Token is old.';
    // If the the Issued-at time is not in the past, token is invalid
    if (currentDate.isBefore(issuedAtTime)) throw 'Token is from the future.';

    // aud = Audience
    // Must be your Firebase project ID, the unique identifier for your Firebase project, which can be found in the URL of that project's console.
    if (aud != projectId) throw 'Token audience != projectId.';

    // iss = Issuer
    // Must be "https://securetoken.google.com/<projectId>", where <projectId> is the same project ID used for aud above.
    if (iss != 'https://securetoken.google.com/$aud') throw 'invalid Issuer';

    // sub = Subject
    // Must be a non-empty string and must be the uid of the user or device.
    // TODO: compare to the final uid

    // auth_time Authentication time
    // Must be in the past. The time when the user authenticated.
    if (currentDate.isBefore(authenticationTime)) {
      throw 'User authenticated in the future.';
    }
  }

  String get projectId => aud;

  factory TokenPayload.fromJson(Map<String, dynamic> json) =>
      _$TokenPayloadFromJson(json);
}
