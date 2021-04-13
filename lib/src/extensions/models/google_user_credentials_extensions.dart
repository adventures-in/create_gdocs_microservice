import 'package:create_gdocs_microservice/src/models/google_user_credentials.dart';
import 'package:googleapis_auth/auth_io.dart';

extension GoogleUserCredentialsExtension on GoogleUserCredentials {
  AccessCredentials toAccessCredentials() => AccessCredentials(
      AccessToken(tokenType, accessToken,
          DateTime.fromMillisecondsSinceEpoch(expiryDate).toUtc()),
      refreshToken,
      scope.split(' '),
      idToken: idToken);
}
