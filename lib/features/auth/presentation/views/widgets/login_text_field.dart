import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';
class CustomLoginTextField extends StatelessWidget {
  const CustomLoginTextField(
      {super.key,
        required this.hint,
        required this.icon,
        this.obscureText,

        this.textInputType,
        required this.validatorWord,
        this.color,
        this.fill,  this.controller, this.validator});
  final String hint;
  final TextEditingController? controller;
  final Icon icon;
  final bool? obscureText;
  final TextInputType? textInputType;
  final String validatorWord;
  final Color? color;
  final bool? fill;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return SizedBox(

      //  height: 60.h,
      width: double.infinity,
      child: TextFormField(

        controller: controller,
        obscureText: obscureText ?? false,
        validator: (value) => value!.isEmpty ? '  $validatorWord  is required' : null,
        keyboardType: textInputType ?? TextInputType.text,
        decoration: InputDecoration(
            fillColor: color ?? Colors.white,
            filled: fill ?? false,
            border: OutlineInputBorder(

              borderRadius: BorderRadius.circular(12.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(
                color: Colors.black,

              ),
            ),
            prefixIcon: icon,
            hintText: hint,
            hintStyle: Styles.textStyle15.copyWith(color: Colors.black)),
      ),
    );
  }
}