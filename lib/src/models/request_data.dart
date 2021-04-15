import 'package:freezed_annotation/freezed_annotation.dart';

part 'request_data.freezed.dart';
part 'request_data.g.dart';

@freezed
class RequestData with _$RequestData {
  factory RequestData(
      {String? creatorId,
      required String parentFolderId,
      required String sectionName}) = _CreationRequest;

  factory RequestData.fromJson(Map<String, dynamic> json) =>
      _$RequestDataFromJson(json);
}
