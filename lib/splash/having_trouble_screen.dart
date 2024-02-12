import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/form_example.dart';
import 'package:tutorial/splash/button.dart';

//TODO: Add email sending by making email address tappable

class HavingTroubleScreen extends StatelessWidget {
  const HavingTroubleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 0.9,
          child: Column(
            children: [
              const Spacer(flex: 2),
              Image.asset('assets/havingtrouble.png'),
              const Spacer(flex: 4),
              _textFields,
              const Spacer(flex: 6),
              _buttonRow(context),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonRow(BuildContext context) =>
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const SkipButton(),
        MostlyRoundedButton(
          buttonText: "Next",
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return const SignUpForm();
            }));
          },
        ),
      ]);

  Widget get _textFields => const Column(children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Having trouble with the app?",
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
          ),
        ),
        SizedBox(height: 16),
        Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'We want to know about it. Please send an email to support@patientinform.com and we will be in contact shortly.',
              style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff9B9B9B)),
            )),
      ]);
}
