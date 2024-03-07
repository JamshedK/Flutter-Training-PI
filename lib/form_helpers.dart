import 'package:flutter/material.dart';
import 'package:tutorial/constants.dart';

/// FormHelpers contains mutliple methods to avoid code repition.
/// @author: Ameer Ghazal
class FormHelpers {
  /// Generic function that checks if the user has input any value into the respective box.
  /// @return: returns a list of widgets to notify the user of requirment, if applicable.
  /// @author: Ameer (AG)
  static List<Widget> checkError(String field) {
    if (field.isNotEmpty) {
      return [
        const SizedBox(height: 16),
        Text(
          field,
          style: const TextStyle(color: Colors.red, fontSize: 16),
        ),
      ];
    }

    return [];
  }

  /// Generic function that creates the input box style across many pages.
  /// @param: takes in the controller for the specific field.
  /// @return: returns a widget of the input box.
  /// @author: Ameer (AG)
  static Widget inputBoxStyle(TextEditingController controller) {
    return SizedBox(
      height: 60,
      width: 380,
      child: Align(
        alignment: Alignment.center,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                color: Color(0x33000000),
                blurRadius: 5.0,
                spreadRadius: 0,
                offset: Offset(0, 0),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            ),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: primaryTextColor,
            ),
            textAlign: TextAlign.left,
            textAlignVertical: TextAlignVertical.center,
          ),
        ),
      ),
    );
  }
}
