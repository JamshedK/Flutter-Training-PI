import 'package:flutter/material.dart';
import '../constants.dart';
import 'button.dart';
import 'package:tutorial/splash/having_trouble_screen.dart';

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
            mainAxisSize: MainAxisSize.min,
            children: [
            //TODO: Change Spacers into Sized Boxes, then add SingleChildScrollView
              const Spacer(flex: 2),
              Image.asset('assets/ER_Group.png'),
              const Spacer(flex: 1),
              _textFields,
              const Spacer(flex: 2),
              _buttonRow(context),
              const Spacer(flex: 4),
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
              return const HavingTroubleScreen();
            }));
          },
        ),
      ]);

  Widget get _textFields => const Column(
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Text("Track ER Progress",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600))),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Welcome to our cutting edge platform where you can effortlessly be "
              "informed about you or your loved ones care in the Emergency Department."
              "We provide real time updates to your care so you can be at ease knowing"
              " the clinical staff are here to take great care of you.",
              style: TextStyle(
                  color: Color(0xFF9B9B9B),
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          ),
        ],
      );
}
