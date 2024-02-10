import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';
import 'package:tutorial/splash/button.dart';
import 'package:google_fonts/google_fonts.dart';

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
          heightFactor: 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Spacer(flex: 5),
              Image.asset('assets/havingtrouble.png'),
              const Spacer(flex: 22),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text('Having trouble with the app',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600))),
                  ),
              const Spacer(flex: 2),
              Align(
                alignment: Alignment.centerLeft,
                  child: Text('We want to know about it. Please send an email to support@patientinform.com and we will be in contact shortly.',
                  style: GoogleFonts.poppins(
                    textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, color: Color(0xff9B9B9B))), )
                  ),
              const Spacer(flex: 10),
              Align(
                alignment: Alignment.bottomRight,
                child: MostlyRoundedButton(
                  buttonText: 'Next',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HavingTroubleScreen()), //Change to track er later
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
