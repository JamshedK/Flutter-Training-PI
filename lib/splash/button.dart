import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';

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
              topRight: Radius.circular(64),
              bottomLeft: Radius.circular(64),
              bottomRight: Radius.circular(64),
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
