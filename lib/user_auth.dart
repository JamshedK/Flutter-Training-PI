import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleSignInEmail(email, password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<User?> handleSignUp(email, password) async {
    // UserCredential result = await auth.createUserWithEmailAndPassword(
    //     email: email, password: password);
    // final User user = result.user!;
    late final User? user;
    try {
      final UserCredential result =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = result.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }
}

Future<User?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '997688084433-qiahs2fdcekq042vg9k7dl7mebo58v7d.apps.googleusercontent.com',
  );

  googleSignIn.disconnect();

  // Attempt to sign in the user with Google
  final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
  if (googleUser == null) {
    return null;
  }
  print('sign in with google');

  // Obtain the authentication tokens from the Google sign-in process
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  if (googleAuth.accessToken == null && googleAuth.idToken == null) {
    return null;
  }

  // Create a new credential for signing in with Firebase
  final OAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Sign in with Firebase using the Google credential
  final UserCredential result =
      await FirebaseAuth.instance.signInWithCredential(credential);
  final User? user = result.user;

  // Return the signed-in Firebase user
  return user;
}
