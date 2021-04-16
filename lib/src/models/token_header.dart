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

  bool get isValid {
    // Verify id token following rules in:
    // https://firebase.google.com/docs/auth/admin/verify-id-tokens#verify_id_tokens_using_a_third-party_jwt_library

    final Map<String, dynamic> publicKeysMap = jsonDecode(publicKeysString);
    if (alg != 'RS256' || !publicKeysMap.keys.contains(kid)) {
      return false;
    }

    return true;
  }

  factory TokenHeader.fromJson(Map<String, dynamic> json) =>
      _$TokenHeaderFromJson(json);
}
