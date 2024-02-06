import 'package:flutter/material.dart';
import 'package:tutorial/splash/button.dart';
import 'package:tutorial/splash/having_trouble_screen.dart';

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
            children: [
              const Spacer(flex: 5),
              Image.asset('assets/logo.png'),
              const Spacer(flex: 2),
              Align(
                alignment: Alignment.bottomRight,
                child: MostlyRoundedButton(
                  buttonText: 'Next',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const TrackErScreen()), //Change to track er later
                    );
                  },
                ),
              ),
              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
