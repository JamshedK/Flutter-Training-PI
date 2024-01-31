import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/splash/button.dart';

class TrackErScreen extends StatelessWidget {
  const TrackErScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: MostlyRoundedButton(buttonText: 'Next'),
    );
  }
}
