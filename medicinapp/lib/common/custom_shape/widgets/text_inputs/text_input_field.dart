import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.keyboardtype,
    this.maxLength,
    this.maxLines,
  }) : super(key: key);
  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardtype;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      width: mediaQueryWidth * 0.8, // Adjusted .9 to 0.9
      child: TextFormField(
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardtype, // Set keyboard type to number
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
