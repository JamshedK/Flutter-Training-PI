import 'package:flutter/material.dart';

import 'constants.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
  });

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
  String _passwordError = '';

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
                textAlign: TextAlign.center,
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
              _FormBox(
                icon: Icons.email_outlined,
                hintText: 'Email',
                controller: _emailController,
              ),
              if (_emailError.isNotEmpty) ...[
                const SizedBox(height: 16),
                Text(
                  _emailError,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              ],
              const SizedBox(height: 16),
              _FormBox(
                icon: Icons.lock_outline_rounded,
                hintText: 'Password',
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 16),
              _FormBox(
                icon: Icons.lock_outline_rounded,
                hintText: 'Confirm Password',
                obscureText: true,
                controller: _confirmPasswordController,
              ),
              const SizedBox(height: 16),
              if (_passwordController.text != _confirmPasswordController.text) ...[
                const Text(
                  'Passwords do not match',
                  style: TextStyle(color: Colors.red, fontSize: 16),
                ),
                const SizedBox(height: 16),
              ],
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
                  print('sign up with password: "${_passwordController.text}"/"${_confirmPasswordController.text}"');
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
              ),
              Text('or continue with', textAlign: TextAlign.center),
              Text('social row'),
              Text('already have an account? sign in'),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormBox extends StatefulWidget {
  const _FormBox({
    required this.icon,
    required this.hintText,
    this.controller,
    this.obscureText = false,
  });

  final bool obscureText;
  final IconData icon;
  final String hintText;
  final TextEditingController? controller;

  @override
  State<_FormBox> createState() => _FormBoxState();
}

class _FormBoxState extends State<_FormBox> {
  bool _isCurrentlyObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0x33000000)),
      ),
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText && _isCurrentlyObscured,
        style: const TextStyle(
          color: primaryColor,
          fontSize: 16,
          height: 1.5,
        ),
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
            size: 30,
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFB7B7B7),
            fontSize: 16,
            height: 1.5,
          ),
          border: InputBorder.none,
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isCurrentlyObscured = !_isCurrentlyObscured;
                    });
                  },
                  icon: const Icon(
                    Icons.remove_red_eye_outlined,
                    color: primaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
