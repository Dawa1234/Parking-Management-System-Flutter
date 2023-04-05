import 'package:epark/measure/measure.dart';
import 'package:flutter/material.dart';

//------------ User in RegisterScreen ------------
SizedBox responsiveForHeight(BuildContext context) {
  return phoneHeight(context) > 800 ? gap50 : gap30;
}

SizedBox responsiveForHeight1(BuildContext context) {
  return phoneHeight(context) > 800 ? gap20 : gap10;
}

EdgeInsetsGeometry responsiveForWidth(BuildContext context) {
  return phoneWidth(context) > 1000
      ? const EdgeInsets.symmetric(horizontal: 200)
      : phoneWidth(context) > 800
          ? const EdgeInsets.symmetric(horizontal: 100)
          : const EdgeInsets.symmetric(horizontal: 12);
}
