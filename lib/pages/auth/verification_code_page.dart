import 'dart:math';

import 'package:flutter/material.dart';
import 'package:patient_inform/utils/constants.dart';
import 'package:patient_inform/widgets/form_box.dart';
import 'package:patient_inform/pages/auth/signup_form.dart';
import 'package:patient_inform/widgets/form_helpers.dart';
import 'package:patient_inform/pages/homepage.dart';
import 'package:patient_inform/utils/user_auth.dart';
import 'package:provider/provider.dart';

class VerficationCodePage extends StatefulWidget {
  const VerficationCodePage({super.key});

  @override
  State<VerficationCodePage> createState() => _VerficationCodePageState();
}

class _VerficationCodePageState extends State<VerficationCodePage> {
  @override
  void initState() {
    super.initState();

    _codeController = TextEditingController();
  }

  @override
  void dispose() {
    _codeController.dispose();

    super.dispose();
  }

  late final TextEditingController _codeController;

  String _codeError = '';

  late final authHandler = Provider.of<UserPhoneAuth>(context);
  var authHandler2 = UserAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(left: 32, right: 32, top: 20, bottom: 32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (authHandler.isSendingSMS) ...[
                const Column(children: [
                  Text(
                    'Sending SMS Code ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  CircularProgressIndicator.adaptive(
                      valueColor: AlwaysStoppedAnimation(primaryColor)),
                ]),
                const SizedBox(height: 16),
              ],
              if (!authHandler.isSendingSMS) ...[
                const Text(
                  'Code Sent!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    height: 1.5,
                  ),
                )
              ],
              Image.asset('assets/logo.png'),
              const Text(
                'Verification Code',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const Text(
                'Enter the verification code sent to your phone number.',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              const SizedBox(height: 24),
              FormBox(
                icon: Icons.numbers,
                hintText: '000000',
                controller: _codeController,
                obscureText: false,
                keyboardType: TextInputType.number,
              ),
              ...FormHelpers.checkError(_codeError),
              const SizedBox(height: 24),

              //TODO: Add Empty Password Error
              _createLoginButton,
              const SizedBox(height: 24),
              const Text(
                'Or Continue With',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 14, color: primaryColor, height: 1.5),
              ),
              const SizedBox(height: 24),
              _createWithSocialRow,
              const SizedBox(height: 12),
              _dontHaveAccountRow,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _createLoginButton => TextButton(
        onPressed: () async {
          if (_codeController.text.isEmpty) {
            setState(() {
              _codeError = 'Field cannot be empty';
            });
            return;
          }
          setState(() {
            _codeError = '';
          });
          try {
            final user = await authHandler.signInWithPhoneNumber(
                authHandler.verificationId, _codeController.text);
            if (!mounted) {
              return;
            }
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (context) => const Homepage(),
              ),
            );
          } catch (e) {
            print(e);
            setState(() {
              _codeError = 'Invalid verification code. Please try again.';
            });
          }
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(primaryColor),
          foregroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'Continue',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      );

  Widget get _createWithSocialRow => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              try {
                final user = await authHandler2.signInWithGoogle();
                if (!mounted) {
                  return;
                }
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute<void>(
                      builder: (context) => const Homepage()),
                  (Route<dynamic> route) => false,
                );
              } catch (e) {
                print(e);
              }
            },
            iconSize: 78,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0x33000000))),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(24),
              child: Image.asset('assets/google_logo.png', height: 30),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: () => print('facebook'),
            iconSize: 78,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(const EdgeInsets.all(0)),
              side: MaterialStateProperty.all(
                  const BorderSide(color: Color(0x33000000))),
              shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            icon: Padding(
              padding: const EdgeInsets.all(24),
              child: Image.asset('assets/facebook_logo.png', height: 30),
            ),
          ),
        ],
      );

  Widget get _dontHaveAccountRow => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Don\'t have an account?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: () {
              print('sign up');
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const SignUpForm();
              }));
            },
            style: ButtonStyle(
              foregroundColor:
                  MaterialStateProperty.all(const Color(0xFF0E0E0E)),
              textStyle: MaterialStateProperty.all(
                const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            child: const Text('Sign up'),
          ),
        ],
      );
}
