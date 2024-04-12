import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:libphonenumber/libphonenumber.dart';

class UserPhoneAuth with ChangeNotifier {
  final FirebaseAuth auth = FirebaseAuth.instance;
// These facilitate the phone number verification process
  String _verificationId = '';
  bool _isSendingSMS = false;
  String? _errorMessage = '';

  // Getters
  String get verificationId => _verificationId;
  bool get isSendingSMS => _isSendingSMS;
  String? get errorMessage => _errorMessage;

  void sendVerificationCode(phoneNumber) async {
    bool isVerified = await verifyPhoneNumber(phoneNumber);
    _isSendingSMS = true;
    notifyListeners();

    try {
      phoneNumber = await PhoneNumberUtil.normalizePhoneNumber(
        phoneNumber: phoneNumber,
        isoCode: 'US',
      );
    } catch (e) {
      print(e);
    }

    if (!isVerified) {
      throw Exception('Phone number is incorrect.');
    }

    auth.setSettings(appVerificationDisabledForTesting: true);
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          await auth.signInWithCredential(credential);
        },
        verificationFailed: (FirebaseException e) {
          print(e.message);
          _isSendingSMS = false;
          notifyListeners();
        },
        codeSent: (String verificationId, int? resendToken) {
          _verificationId = verificationId;
          _isSendingSMS = false;
          notifyListeners();
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _isSendingSMS = false;
          notifyListeners();
        });
  }

  verifyPhoneNumber(phoneNumber) {
    if (phoneNumber == '(405) 555-7665') {
      return true;
    }
    return false;
  }

  Future<User?> signInWithPhoneNumber(verificationId, smsCode) async {
    print('verificationId: $verificationId, smsCode: $smsCode');
    UserCredential result = await auth.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      ),
    );
    return result.user;
  }
}

class UserAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;

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
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

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
}
