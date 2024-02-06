import 'package:flutter/material.dart';
import '../constants.dart';
import '/splash/splash_screen.dart';


class SkipButton extends StatelessWidget{
  const SkipButton({
    super.key,
  });

  @override
  Widget build(BuildContext context){
    return TextButton(
      onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) {
          return const SplashScreen();
        }));
      },
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(primaryColor),
      ),
      child: const Text("Skip", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
    );
  }
}

class MostlyRoundedButton extends StatelessWidget {
  const MostlyRoundedButton({
    super.key, 
    required this.buttonText,
    this.onPressed,
  });

  final String buttonText;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(primaryColor),
        foregroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              topLeft: Radius.zero,
              topRight: Radius.circular(64.0),
              bottomLeft: Radius.circular(64.0),
              bottomRight: Radius.circular(64.0),
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 44, vertical: 19),
        child: Text(buttonText, style: const TextStyle(fontSize: 16)),
      ),
    );
  }
}