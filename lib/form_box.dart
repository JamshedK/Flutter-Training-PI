import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutorial/constants.dart';

class FormBox extends StatefulWidget {
  const FormBox({
    super.key,
    required this.icon,
    required this.hintText,
    this.controller,
    required this.keyboardType,
    // TODO add required this.inputFormatters,
    this.obscureText = false,
  });

  final bool obscureText;
  final IconData icon;
  final String hintText;
  final TextEditingController? controller;

  final TextInputType keyboardType;
  //final TextInputFormatter inputFormatters;

  final TextInputType keyboardType;
  //final TextInputFormatter inputFormatters;

  @override
  State<FormBox> createState() => FormBoxState();
}

class FormBoxState extends State<FormBox> {
  bool _isCurrentlyObscured = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0x33000000)),
      ),
      padding: const EdgeInsets.all(12),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType, //! DY: NEW
        obscureText: widget.obscureText && _isCurrentlyObscured,
        style: const TextStyle(
          color: primaryColor,
          fontSize: 16,
          height: 1.5,
        ),
        decoration: InputDecoration(
          icon: Icon(
            widget.icon,
            color: primaryColor,
            size: 30,
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Color(0xFFB7B7B7),
            fontSize: 16,
            height: 1.5,
          ),
          border: InputBorder.none,
          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      _isCurrentlyObscured = !_isCurrentlyObscured;
                    });
                  },
                  icon: Icon(
                    _isCurrentlyObscured
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: primaryColor,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
