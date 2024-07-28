import 'package:flutter/material.dart';
import 'package:pingolearn_task1/constants/text_styles.dart';

import '../constants/colors.dart';

class AppButton extends StatelessWidget {
  const AppButton({super.key, required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: primary,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Center(child: Text(text, style: boldText(Colors.white))),
      ),
    );
  }
}
