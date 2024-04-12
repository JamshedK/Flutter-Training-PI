import 'dart:math';

String formatPhoneNumber(String phoneNumber) {
  // Strip all non-digits
  String digitsOnly = phoneNumber.replaceAll(RegExp(r'[^\d]'), '');

  // Build the formatted phone number
  String formattedNumber = '';
  if (digitsOnly.length >= 1) {
    formattedNumber = '(' + digitsOnly.substring(0, min(3, digitsOnly.length));
  }
  if (digitsOnly.length >= 4) {
    formattedNumber +=
        ') ' + digitsOnly.substring(3, min(6, digitsOnly.length));
  }
  if (digitsOnly.length >= 7) {
    formattedNumber += '-' + digitsOnly.substring(6);
  }

  return formattedNumber;
}
