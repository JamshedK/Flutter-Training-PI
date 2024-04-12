import 'package:flutter/material.dart';
import 'package:patient_inform/pages/auth/login_form.dart';
import 'package:patient_inform/pages/auth/signup_form.dart';
import 'package:patient_inform/utils/constants.dart';
import 'package:patient_inform/pages/auth/Scan_MRN.dart';

import 'track_er_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.8,
          heightFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 5),
              Image.asset('assets/logo.png'),
              const SizedBox(height: 12),
              const Text('Track Your ER Progress',
                  style: TextStyle(color: primaryTextColor, fontSize: 16)),
              const Spacer(flex: 2),
              Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _loginButton,
                      ])),
              _dontHaveAccountText,
              const SizedBox(height: 12),
              Padding(
                  padding: const EdgeInsets.fromLTRB(60, 0, 60, 0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _separatorRow,
                        const SizedBox(height: 24),
                        _scanMRNButton,
                      ])),
              const Spacer(flex: 4),
              _whatIsPI,
            ],
          ),
        ),
      ),
    );
  }

  Widget get _loginButton => TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const LoginForm();
          }));
        },
        style: ButtonStyle(
          backgroundColor: const MaterialStatePropertyAll(primaryColor),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Text('Login',
              style: TextStyle(color: Colors.white, fontSize: 16)),
        ),
      );

  Widget get _dontHaveAccountText => TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const SignUpForm();
          }));
        },
        child: const Text(
          'Don\'t have an account? Sign up',
          style: TextStyle(color: primaryTextColor, fontSize: 14),
        ),
      );

  Widget get _separatorRow => const Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Divider(
              color: secondaryTextColor,
              height: 1.5,
              endIndent: 4,
            ),
          ),
          Text('or', style: TextStyle(color: primaryTextColor, fontSize: 16)),
          Expanded(
            child: Divider(
              color: secondaryTextColor,
              height: 1.5,
              indent: 4,
            ),
          ),
        ],
      );

  Widget get _scanMRNButton => OutlinedButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const ScanMRN();
          }));
        },
        style: ButtonStyle(
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: Colors.grey),
          ),
          foregroundColor: MaterialStateProperty.all<Color>(primaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Icon(Icons.qr_code_scanner_rounded, size: 40),
              SizedBox(height: 8.0),
              Text('Scan for fast entry'),
            ],
          ),
        ),
      );

  Widget get _whatIsPI => TextButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) {
            return const TrackErScreen();
          }));
        },
        child: const Text(
          'What is Patient Inform?',
          style: TextStyle(color: primaryColor, fontSize: 16),
        ),
      );
}
