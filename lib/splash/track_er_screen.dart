import 'package:flutter/material.dart';
import '../constants.dart';
import 'button.dart';
import 'having_trouble_screen.dart';

//TODO: Make Code more readable using functions, getters, arrow functions, etc.
//TODO: Deal with spacing and make uniform


class TrackErScreen extends StatelessWidget {
  const TrackErScreen({super.key});

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
              Image.asset('assets/ER_Group.png'),
              const Spacer(flex: 1),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Track ER Progress", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600))
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text("Welcome to our cutting edge platform where you can effortlessly be "
                            "informed about you or your loved ones care in the Emergency Department."
                            "We provide real time updates to your care so you can be at ease knowing"
                            " the clinical staff are here to take great care of you.", 
                  style: TextStyle(color: Color(0xFF9B9B9B), fontSize: 16, fontWeight: FontWeight.w400),
                ),
              ),
              const Spacer(flex: 1),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SkipButton(),
                  MostlyRoundedButton(
                    buttonText: "Next",
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const HavingTroubleScreen();
                      }));
                    },
                  ),
                ]
              ),
              const Spacer(flex: 4),
            ],
          ),
        ),
      ),
    );
  }
}