import 'package:create_gdocs_microservice/src/extensions/googleapis/firestore_document_extensions.dart';
import 'package:create_gdocs_microservice/src/models/google_user_credentials.dart';
import 'package:googleapis/firestore/v1.dart';

class FirestoreService {
  final FirestoreApi _firestoreApi;

  FirestoreService(this._firestoreApi);

  /// Retrieves the user credentials from the Firestore and creates a
  /// [GoogleUserCredentials] for returning.
  Future<GoogleUserCredentials> getGoogleUserCredentials(String userId) async {
    final credentialsDocumentName =
        'projects/the-process-tool/databases/(default)/documents/credentials/$userId';
    final credentialsDoc = await _firestoreApi.projects.databases.documents
        .get(credentialsDocumentName);

    return credentialsDoc.toGoogleUserCredentials();
  }

  Future<Document> saveSection(Document doc) =>
      _firestoreApi.projects.databases.documents.createDocument(
          doc,
          'projects/the-process-tool/databases/(default)/documents',
          'sections');
}
