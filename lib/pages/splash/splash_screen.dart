import 'package:flutter/material.dart';
import 'package:patient_inform/pages/auth/accountless_form.dart';
import 'package:patient_inform/pages/splash/button.dart';

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
                alignment: Alignment.bottomLeft,
                child: MostlyRoundedButton(
                  buttonText: 'Scan',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const AccountlessAuth();
                    }));
                  },
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: MostlyRoundedButton(
                  buttonText: 'Next',
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return const TrackErScreen();
                    }));
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
