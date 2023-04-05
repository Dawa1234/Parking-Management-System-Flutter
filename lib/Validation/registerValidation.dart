// First Name, Last Name and username validation [User in login ,register page]
// ignore_for_file: import_of_legacy_library_into_null_safe
import 'package:epark/theme/themeData.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

String? Function(String?)? nameValidator = (value) {
  if (value!.isEmpty) return "*Required*";
  if (value.length > 15) return "*Too long*";
  return null;
};
// Email validation
String? Function(String?)? emailValidator = (value) {
  if (value!.isNotEmpty) {
    if (!value.contains("@") || !value.contains(".com")) {
      return "*Bad email format*";
    }
    if (value.contains("..")) return "*Bad email format*";
    return null;
  }
  return null;
};
// Contact Number validation
String? Function(String?)? phoneNumberValidator = (value) {
  if (value!.isEmpty) return "*Required*";
  if (value.length != 10 || (!value.contains("97") && !value.contains("98"))) {
    return "*Invalid Number*";
  }
  return null;
};
// [User in login ,register page]
// Password validation
String? Function(String?)? passwordValidator = (value) {
  if (value!.isEmpty) return "*Required*";
  if (value.length < 8) return "*More than 8 charater is required*";
  if (value.length > 30) return "*Too long*";
  return null;
};
// Password not match
String? Function(String?)? unEqualValidator = (value) {
  return "*Password not matched*";
};

// On successfully log in.
successBar(BuildContext context, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: DARK_GREY_COLOR,
      textColor: Colors.white,
      fontSize: 16.0);
}

// On invalid log in.
invalidBar(BuildContext context, String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}
