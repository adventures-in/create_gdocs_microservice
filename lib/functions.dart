// Copyright 2021 Google LLC
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:create_gdocs_microservice/src/models/greeting_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:json_annotation/json_annotation.dart';

part 'functions.g.dart';

@JsonSerializable()
class GreetingRequest {
  final String? name;

  GreetingRequest({this.name});

  factory GreetingRequest.fromJson(Map<String, dynamic> json) =>
      _$GreetingRequestFromJson(json);

  Map<String, dynamic> toJson() => _$GreetingRequestToJson(this);

  @override
  bool operator ==(Object other) =>
      other is GreetingRequest && other.name == name;

  @override
  int get hashCode => name.hashCode;
}

// @JsonSerializable()
// class GreetingResponse {
//   final String salutation;
//   final String name;

//   GreetingResponse({required this.salutation, required this.name});

//   factory GreetingResponse.fromJson(Map<String, dynamic> json) =>
//       _$GreetingResponseFromJson(json);

//   Map<String, dynamic> toJson() => _$GreetingResponseToJson(this);

//   @override
//   bool operator ==(Object other) =>
//       other is GreetingResponse &&
//       other.salutation == salutation &&
//       other.name == name;

//   @override
//   int get hashCode => salutation.hashCode ^ name.hashCode;
// }

@CloudFunction()
Future<GreetingResponse> function(GreetingRequest request) {
  final name = request.name ?? 'World';
  final json = GreetingResponse(salutation: 'Hello', name: name);
  // final json = CreationResponse(resourceNames: []);
  return Future.value(json);
}


// import 'package:create_gdocs_microservice/src/extensions/string_extensions.dart';
// import 'package:create_gdocs_microservice/src/models/creation_request.dart';
// import 'package:create_gdocs_microservice/src/models/creation_response.dart';
// import 'package:create_gdocs_microservice/src/services/auth_service.dart';
// import 'package:create_gdocs_microservice/src/services/drive_service.dart';
// import 'package:create_gdocs_microservice/src/services/firestore_service.dart';
// import 'package:functions_framework/functions_framework.dart';
// import 'package:googleapis/docs/v1.dart' as docs;
// import 'package:googleapis/drive/v3.dart' as drive;
// import 'package:googleapis/firestore/v1.dart' as firestore;
// import 'package:googleapis/firestore/v1.dart';
// import 'package:googleapis/secretmanager/v1.dart';
// import 'package:googleapis_auth/auth_io.dart';

// @CloudFunction()
// Future<CreationResponse> function(CreationRequest request) async {
//   // User supplied config is in the json data
//   // The "creating user" refers to the user account that creates the docs

//   // TODO: get the userId from the auth header
//   final creatingUserId = request.creatorId ?? '';

//   // create a database entry object that will be added to and finally saved
//   final docFields = <String, Value>{};
//   try {
//     // Create services and a client that will authenticate as the given user.
//     final serviceClient =
//         await clientViaApplicationDefaultCredentials(scopes: []);
//     final firestoreService =
//         FirestoreService(firestore.FirestoreApi(serviceClient));
//     final authService = AuthService();
//     final userClient = await authService.getUserClient(
//       creatingUserId,
//       firestoreService,
//       SecretManagerApi(serviceClient),
//     );
//     final driveService =
//         DriveService(drive.DriveApi(userClient), docs.DocsApi(userClient));

//     // Add the id of the user creating the section to the firestore document.
//     docFields['createdBy'] = creatingUserId.asValue();

//     // Extract section name, update firestore doc and construct title strings
//     final sectionName = request.sectionName;
//     docFields['name'] = sectionName.asValue();
//     final folderTitle = '$sectionName: Sections Planning (CL)';
//     final docTitle = '0 - Use Cases < $sectionName (CL)';

//     // Use Drive API to create a folder for the section.
//     final folder = await driveService.createFolder(
//         name: folderTitle, parentId: request.parentFolderId);

//     // Add the folder id to the firestore document for saving to db.
//     docFields['folderId'] = folder.id!.asValue();

//     // Create our use cases doc and move inside the section folder.
//     final useCasesDriveDoc = await driveService.createDocInFolder(
//         parentId: folder.id!, docTitle: docTitle);

//     // Add the doc id to and save the firestore document.
//     docFields['useCasesDocId'] = useCasesDriveDoc.id!.asValue();
//     final savedSectionDataDoc = await firestoreService
//         .saveSection(firestore.Document()..fields = docFields);

//     // Return the resource names to the client
//     return CreationResponse(resourceNames: [savedSectionDataDoc.name]);
//   } catch (error, trace) {
//     // Log and return any errors.
//     print('\n\n$error\n\nSection doc fields: $docFields\n\n');
//     print(trace);
//     return CreationResponse(resourceNames: <String?>[]);
//     // Response.internalServerError(body: error);
//   }
// }
