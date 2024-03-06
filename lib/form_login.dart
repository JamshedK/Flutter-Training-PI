import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/form_box.dart';
import 'package:tutorial/form_example.dart';
import 'package:tutorial/form_helpers.dart';
import 'package:tutorial/form_reset_password.dart';
import 'package:tutorial/homepage.dart';
import 'package:tutorial/user_auth.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;

  String _emailError = '';

  void _onLoginPressed() {
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
        'login with password: "${_passwordController.text}"/"${_confirmPasswordController.text}"');
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (_) {
          return const Homepage();
        },
      ),
      (Route<dynamic> route) => false,
    );
  }

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
                'Login to Account',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const Text(
                'Fill in the information below to login',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              const SizedBox(height: 32),
              FormBox(
                icon: Icons.email_outlined,
                hintText: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              ...FormHelpers.checkError(_emailError),
              const SizedBox(height: 16),
              FormBox(
                icon: Icons.lock_outline_rounded,
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
                keyboardType: TextInputType.visiblePassword,
              ),
              //TODO: Add Empty Password Error
              _forgotPasswordRow,
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
        onPressed: _onLoginPressed,
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
            'Login',
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
                final user = await signInWithGoogle();
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
            "Don't have an account?",
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

  Widget get _forgotPasswordRow => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
            onPressed: () {
              print('oopsie');
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return const ResetPasswordForm();
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
            child: const Text('Forgot your password?'),
          ),
        ],
      );
}
