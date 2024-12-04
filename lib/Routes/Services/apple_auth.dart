import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<User?> signInWithApple() async {
  final credential = await SignInWithApple.getAppleIDCredential(
    scopes: [
      AppleIDAuthorizationScopes.email,
      AppleIDAuthorizationScopes.fullName
    ],
  );

  final firebaseCredential = OAuthProvider("apple.com").credential(
    idToken: credential.identityToken,
    accessToken: credential.authorizationCode,
  );

  return (await FirebaseAuth.instance.signInWithCredential(firebaseCredential))
      .user;
}
