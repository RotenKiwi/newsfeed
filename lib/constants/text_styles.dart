import 'package:flutter/material.dart';
import 'package:pingolearn_task1/constants/colors.dart';

TextStyle boldText (Color color){
  return TextStyle(
      fontFamily: "Poppins",
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
      color: color);
}

const regularText = TextStyle(
    fontFamily: "Poppins",
    fontSize: 16.0,
    fontWeight: FontWeight.w300,
    color: Colors.black);

const smallText = TextStyle(
    fontFamily: "Poppins",
    fontSize: 14.0,
    fontWeight: FontWeight.w300,
    color: tertiary);

const bigText = TextStyle(
    fontFamily: "Poppins",
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    color: Colors.black);