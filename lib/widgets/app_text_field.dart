import 'package:flutter/material.dart';
import 'package:pingolearn_task1/constants/text_styles.dart';

import '../constants/colors.dart';

class AppTextField extends StatelessWidget {
  const AppTextField({
    super.key,
    required this.hintText,
    this.isPassword = false,
    required this.controller
  });
  final String hintText;
  final bool isPassword;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        style: regularText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
        ),
      ),
    );
  }
}
