import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '1023702618863-21ssomuoqdbnekj7c5q7hl3pcam73vgd.apps.googleusercontent.com',
    scopes: ['email'],
  );

  Future<GoogleSignInAccount?> signIn() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      return account;
    } catch (error) {
      print('Error signing in: $error');
      return null;
    }
  }

  Future<void> signOut() => _googleSignIn.signOut();
}
