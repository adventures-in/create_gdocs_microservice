import 'dart:convert';

import 'package:create_gdocs_microservice/src/models/request_data.dart';
import 'package:functions_framework/functions_framework.dart';
import 'package:googleapis/firestore/v1.dart';
import 'package:shelf/shelf.dart';

export 'package:create_gdocs_microservice/src/models/request_data.dart';

@CloudFunction()
Future<Response> function(Request request) async {
  final bodyString = await request.readAsString();
  if (bodyString != '') {
    final requestData = RequestData.fromJson(json.decode(bodyString));
  }

  // verify headers include firebase auth credentials
  await validateAuthHeader(request);

  // User supplied config is in the json data
  // The "creating user" refers to the user account that creates the docs

  // // get the userId from the json or the auth header
  // final creatingUserId = requestData.creatorId ?? '';

  // create a database entry object that will be added to and finally saved
  final docFields = <String, Value>{};
  try {
    //   // Create services and a client that will authenticate as the given user.
    //   final serviceClient =
    //       await clientViaApplicationDefaultCredentials(scopes: []);
    //   final firestoreService =
    //       FirestoreService(firestore.FirestoreApi(serviceClient));
    //   final authService = AuthService();
    //   final userClient = await authService.getUserClient(
    //     creatingUserId,
    //     firestoreService,
    //     SecretManagerApi(serviceClient),
    //   );
    //   final driveService =
    //       DriveService(drive.DriveApi(userClient), docs.DocsApi(userClient));

    //   // Add the id of the user creating the section to the firestore document.
    //   docFields['createdBy'] = creatingUserId.asValue();

    //   // Extract section name, update firestore doc and construct title strings
    //   final sectionName = requestData.sectionName;
    //   docFields['name'] = sectionName.asValue();
    //   final folderTitle = '$sectionName: Sections Planning (CL)';
    //   final docTitle = '0 - Use Cases < $sectionName (CL)';

    //   // Use Drive API to create a folder for the section.
    //   final folder = await driveService.createFolder(
    //       name: folderTitle, parentId: requestData.parentFolderId);

    //   // Add the folder id to the firestore document for saving to db.
    //   docFields['folderId'] = folder.id!.asValue();

    //   // Create our use cases doc and move inside the section folder.
    //   final useCasesDriveDoc = await driveService.createDocInFolder(
    //       parentId: folder.id!, docTitle: docTitle);

    //   // Add the doc id to and save the firestore document.
    //   docFields['useCasesDocId'] = useCasesDriveDoc.id!.asValue();
    //   final savedSectionDataDoc = await firestoreService
    //       .saveSection(firestore.Document()..fields = docFields);

    // Return the resource names to the client
    return Response.ok('OK!'); // savedSectionDataDoc.name
  } catch (error, trace) {
    // Log and return any errors.
    // print('\n\n$error\n\nSection doc fields: $docFields\n\n');
    print(trace);
    return Response.internalServerError(body: error);
  }
}
