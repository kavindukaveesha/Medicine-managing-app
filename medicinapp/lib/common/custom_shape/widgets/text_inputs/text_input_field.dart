import 'package:flutter/material.dart';
import 'package:medicinapp/utils/constants/colors.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key? key,
    required this.labelText,
    this.controller,
    this.validator,
    this.keyboardtype,
    this.maxLength,
    this.maxLines,
    this.onTapDate,
    this.suffixIconButton,
    this.prefixIcon,
    this.borderEnabled = true, // Add this line with a default value
  }) : super(key: key);

  final String labelText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardtype;
  final int? maxLength;
  final int? maxLines;
  final VoidCallback? onTapDate;
  final IconButton? suffixIconButton;
  final IconData? prefixIcon;
  final bool borderEnabled; // Add this line

  @override
  Widget build(BuildContext context) {
    final mediaQueryWidth = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: mediaQueryWidth * 0.85,
      child: TextFormField(
        
        maxLines: maxLines,
        maxLength: maxLength,
        keyboardType: keyboardtype,
        validator: validator,
        controller: controller,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon),
          labelText: labelText,
          border: borderEnabled
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
          enabledBorder: borderEnabled
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.grey))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
          focusedBorder: borderEnabled
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: TColors.appPrimaryColor))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: TColors.appPrimaryColor),
                ),
          errorBorder: borderEnabled
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
          focusedErrorBorder: borderEnabled
              ? OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(color: Colors.red))
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.red),
                ),
          suffixIcon: suffixIconButton,
        ),
      ),
    );
  }
}
