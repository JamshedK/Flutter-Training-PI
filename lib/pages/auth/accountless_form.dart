import 'package:flutter/material.dart';
import 'package:patient_inform/utils/constants.dart';
import 'package:patient_inform/widgets/form_box.dart';
import 'package:patient_inform/pages/auth/signup_form.dart';
import 'package:patient_inform/widgets/form_helpers.dart';
import 'package:patient_inform/pages/homepage.dart';
import 'package:patient_inform/utils/user_auth.dart';

class AccountlessAuth extends StatefulWidget {
  const AccountlessAuth({super.key});

  @override
  State<AccountlessAuth> createState() => _AccountlessAuthState();
}

class _AccountlessAuthState extends State<AccountlessAuth> {
  @override
  void initState() {
    super.initState();

    _idController = TextEditingController();
  }

  @override
  void dispose() {
    _idController.dispose();

    super.dispose();
  }

  late final TextEditingController _idController;

  String _idError = '';

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
                'Fast Authentication',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const Text(
                'Enter your MRN or last 4 digits of SSN.',
                style: TextStyle(color: primaryColor, fontSize: 16),
              ),
              const SizedBox(height: 32),
              FormBox(
                icon: Icons.person,
                hintText: 'MRN or SSN',
                controller: _idController,
                obscureText: true,
                keyboardType: TextInputType.number,
              ),
              ...FormHelpers.checkError(_idError),
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
          if (_idController.text.isEmpty) {
            setState(() {
              _idError = 'Field cannot be empty';
            });
            return;
          }
          setState(() {
            _idError = '';
          });
          try {
            final user = await authHandler.handleFastAuth(_idController.text);
            if (!mounted) {
              return;
            }
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute<void>(builder: (context) => const Homepage()),
              (Route<dynamic> route) => false,
            );
          } catch (e) {
            setState(() {
              _idError = 'Invalid MRN or SSN';
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
