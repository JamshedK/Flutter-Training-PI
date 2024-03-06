import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/form_box.dart';
import 'package:tutorial/form_helpers.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({super.key});

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  @override
  void initState() {
    super.initState();

    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();

    super.dispose();
  }

  late final TextEditingController _emailController;

  String _emailError = '';

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
              // Image.asset('assets/logo.png'),
              const Text(
                'Reset Password',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  height: 1.5,
                ),
              ),
              const Text(
                'Enter your email below so we can sent a code.',
                style: TextStyle(color: tertiaryColor, fontSize: 16),
              ),
              const SizedBox(height: 32),
              FormBox(
                icon: Icons.email_outlined,
                hintText: 'e.g jhondoe@gmail.com',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              ...FormHelpers.checkError(_emailError),
              const SizedBox(height: 16),
              _createSignUpButton,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _createSignUpButton => TextButton(
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
              'Sending email to: "${_emailController.text}"');
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
            'Send Email',
            style: TextStyle(fontSize: 16, height: 1.5),
          ),
        ),
      );
}