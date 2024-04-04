import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User> handleFastAuth(identifier) async {
    //TODO Implement SSN/MRN verification
    bool isVerified = await verifySSN_MRN(identifier);
    final User user;
    if (!isVerified) {
      throw Exception('SSN/MRN not verified');
    } else {
      UserCredential result = await auth.signInAnonymously();
      user = result.user!;
    }

    return user;
  }

  Future<User> handleSignInEmail(email, password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }
}

// ignore: non_constant_identifier_names
verifySSN_MRN(identifier) {
  if (identifier == '123456') {
    return true;
  }

  return false;
}

Future<User?> signInWithGoogle() async {
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '997688084433-qiahs2fdcekq042vg9k7dl7mebo58v7d.apps.googleusercontent.com',
  );

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
