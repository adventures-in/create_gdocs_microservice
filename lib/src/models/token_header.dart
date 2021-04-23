import 'dart:convert';

import 'package:create_gdocs_microservice/src/utils/token_utils.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'token_header.freezed.dart';
part 'token_header.g.dart';

@freezed
class TokenHeader with _$TokenHeader {
  TokenHeader._();

  factory TokenHeader({required String alg, required String kid}) =
      _TokenHeader;

  // Verify id token following rules in:
  // https://firebase.google.com/docs/auth/admin/verify-id-tokens#verify_id_tokens_using_a_third-party_jwt_library
  void validate() {
    // Algorithm "RS256"
    if (alg != 'RS256') throw 'Algorithm must be RS256';

    // checking the kid againt the public keys at https://www.googleapis.com/robot/v1/metadata/x509/securetoken@system.gserviceaccount.com
    // not sure if the keys could change so may need to retrieve the keys each time (or preferably cache them somewhere)
    final Map<String, dynamic> publicKeysMap = jsonDecode(publicKeysString);
    if (!publicKeysMap.keys.contains(kid)) throw 'KeyId not in allowed list';
  }

  factory TokenHeader.fromJson(Map<String, dynamic> json) =>
      _$TokenHeaderFromJson(json);
}
