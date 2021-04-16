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

  bool get isValid {
    final currentDate = DateTime.now();

    final expired = currentDate.isAfter(expirationTime);
    final fromTheFuture = currentDate.isBefore(issuedAtTime);

    if (expired || fromTheFuture) return false;

    return true;
  }

  String get projectId => aud;

  factory TokenPayload.fromJson(Map<String, dynamic> json) =>
      _$TokenPayloadFromJson(json);
}
