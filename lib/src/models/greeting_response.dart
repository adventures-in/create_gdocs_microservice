import 'package:freezed_annotation/freezed_annotation.dart';

@freezed
class GreetingResponse with _$GreetingResponse {
  factory GreetingResponse({required String salutation, required String name}) =
      _GreetingResponse;

  factory GreetingResponse.fromJson(Map<String, dynamic> json) =>
      _$GreetingResponseFromJson(json);
}
