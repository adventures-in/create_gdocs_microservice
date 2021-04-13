import 'package:freezed_annotation/freezed_annotation.dart';

part 'creation_response.freezed.dart';
part 'creation_response.g.dart';

@freezed
class CreationResponse with _$CreationResponse {
  factory CreationResponse({required List<String?> resourceNames}) =
      _CreationResponse;

  factory CreationResponse.fromJson(Map<String, dynamic> json) =>
      _$CreationResponseFromJson(json);
}
