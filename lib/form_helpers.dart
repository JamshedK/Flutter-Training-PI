import 'package:flutter/material.dart';

/// FormHelpers contains mutliple methods to avoid code repition.
/// @author: Ameer Ghazal
class FormHelpers {
  /// Genric function that checks if the user has input any value into the respective box.
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
}
