import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/form_box.dart';
import 'package:tutorial/form_login.dart';
import 'package:tutorial/form_personal_details.dart';
import 'package:tutorial/splash/splash_screen.dart';
//import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:tutorial/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();

    super.dispose();
  }

  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _confirmPasswordController;

  String _emailError = '';
  var authHandler = UserAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset('assets/logo.png'),
              const Text(
                'Create Account',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const Text(
                'Fill in the information below to sign up',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              const SizedBox(height: 32),
              FormBox(
                icon: Icons.email_outlined,
                hintText: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              if (_emailError.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  _emailError,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
              const SizedBox(height: 16),
              FormBox(
                icon: Icons.lock_outline_rounded,
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 16),
              FormBox(
                icon: Icons.lock_outline_rounded,
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _confirmPasswordController,
                keyboardType: TextInputType.visiblePassword,
              ),
              const SizedBox(height: 16),
              if (_passwordController.text !=
                  _confirmPasswordController.text) ...[
                const Text(
                  'Passwords do not match',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 16),
              ],
              _createSignUpButton(context, _emailController, _passwordController),
              const SizedBox(height: 32),
              const Text(
                'Or Continue With',
                textAlign: TextAlign.center,
                style:
                    TextStyle(fontSize: 14, color: primaryColor, height: 1.5),
              ),
              const SizedBox(height: 32),
              _createWithSocialRow,
              const SizedBox(height: 48),
              _alreadyHaveAccountRow,
            ],
          ),
        ),
      ),
    );
  }

  Widget _createSignUpButton(context, emailController, passwordController) =>
     TextButton(
        onPressed: () {
          if (_emailController.text.isEmpty) {
            setState(() {
              _emailError = 'Email cannot be empty';
            });
          } else {
            setState(() {
              _emailError = '';
            });
          }
          print(
              'sign up with password: "${_passwordController.text}"/"${_confirmPasswordController.text}"');
          Navigator.push(context, MaterialPageRoute(builder: (_) {
//!!!!!!!!!!!! Use this button for testing different screens (default: PersonalForm)
              return const PersonalForm();
              //return const ResetPasswordForm();
          }));

//           authHandler.handleSignInEmail(emailController.text, passwordController.text)
//             .then<void>((User user) {
//               Navigator.pushAndRemoveUntil(
//                 context,
//                 MaterialPageRoute<void>(builder: (context) => const PersonalForm()),
//                 (Route<dynamic> route) => false,
//               );
//             }).catchError((e) => print(e));
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
            'Sign Up',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      );

  Widget get _createWithSocialRow => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () => print('google'),
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

  Widget get _alreadyHaveAccountRow => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          TextButton(
            onPressed: () {
              print('sign in');
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const LoginForm();
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
            child: const Text('Sign in'),
          ),
        ],
      );
}
