// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

// Future<User?> signInWithFacebook() async {
//   try {
//     final LoginResult result = await FacebookAuth.instance.login();

//     switch (result.status) {
//       case LoginStatus.success:
//         final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
//         return (await FirebaseAuth.instance.signInWithCredential(credential)).user;
//       case LoginStatus.cancelled:
//         print('Facebook login cancelled by user.');
//         break;
//       case LoginStatus.failed:
//         print('Facebook login failed: ${result.message}');
//         break;
//       default:
//         print('Unknown Facebook login status: ${result.status}');
//         break;
//     }
//   } catch (e) {
//     print('Error during Facebook login: $e');
//   }
//   return null;
// }
