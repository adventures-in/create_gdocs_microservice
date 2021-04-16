import 'package:freezed_annotation/freezed_annotation.dart';

part 'firebase_id_token.freezed.dart';
part 'firebase_id_token.g.dart';

@freezed
class FirebaseIdToken with _$FirebaseIdToken {
  factory FirebaseIdToken({required String token}) = _FirebaseIdToken;

  factory FirebaseIdToken.fromJson(Map<String, dynamic> json) =>
      _$FirebaseIdTokenFromJson(json);
}
