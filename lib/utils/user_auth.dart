import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:libphonenumber/libphonenumber.dart';

class UserAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<String> sendVerificationCode(phoneNumber) async {
    bool isVerified = await verifyPhoneNumber(phoneNumber);

    try {
      phoneNumber = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: phoneNumber,
        isoCode: 'US',
      );
      phoneNumber = phoneNumber.substring(0, 2) +
          " " +
          phoneNumber.substring(2, 5) +
          " " +
          phoneNumber.substring(5, 8) +
          " " +
          phoneNumber.substring(8, 12);
    } catch (e) {
      print(e);
    }

    if (!isVerified) {
      throw Exception('Phone number is incorrect.');
    }

    String _verificationId = '';
    phoneNumber = '+1 405 555 7665';

    auth.setSettings(appVerificationDisabledForTesting: true);
    auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseException e) {
          print(e.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
        },
        codeAutoRetrievalTimeout: (String verificationId) {});

    return _verificationId;
  }

  Future<User?> signInWithPhoneNumber(verificationId, smsCode) async {
    UserCredential result = await auth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      ),
    );
    return result.user;
  }

  Future<User> handleSignInEmail(email, password) async {
    UserCredential result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    final User user = result.user!;

    return user;
  }

  Future<User?> handleSignUp(email, password) async {
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

verifyPhoneNumber(phoneNumber) {
  if (phoneNumber == '(405) 555-7665') {
    return true;
  }
  return false;
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
