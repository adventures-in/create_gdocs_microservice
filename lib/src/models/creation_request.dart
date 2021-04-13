import 'package:freezed_annotation/freezed_annotation.dart';

part 'creation_request.freezed.dart';
part 'creation_request.g.dart';

@freezed
class CreationRequest with _$CreationRequest {
  factory CreationRequest(
      {String? creatorId,
      required String parentFolderId,
      required String sectionName}) = _CreationRequest;

  factory CreationRequest.fromJson(Map<String, dynamic> json) =>
      _$CreationRequestFromJson(json);
}
