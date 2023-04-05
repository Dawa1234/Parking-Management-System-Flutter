import 'package:epark/measure/measure.dart';
import 'package:flutter/material.dart';

// ---------------------------- Home Box Decoration ----------------------------
BoxDecoration homeBoxDecoration =
    const BoxDecoration(color: Colors.white, boxShadow: [
  BoxShadow(
      color: DARK_GREY_COLOR,
      blurRadius: 7,
      spreadRadius: 1,
      offset: Offset.zero)
]);

// ---------------------------- Form Field ----------------------------
Widget textFormField(BuildContext context, String text, Widget icon,
    {Color labelTextColor = DARK_GREY_COLOR,
    String testKey = "",
    String hintText = "",
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    TextEditingController? controller,
    String? Function(String?)? validator}) {
  return TextFormField(
    key: ValueKey(testKey),
    controller: controller,
    obscureText: obscureText,
    keyboardType: keyboardType,
    validator: validator,
    decoration:
        textFormFiledDecraotion(context, hintText, text, icon, labelTextColor),
  );
}

InputDecoration textFormFiledDecraotion(
  BuildContext context,
  String hintText,
  String text,
  Widget icon,
  Color colors,
) {
  return InputDecoration(
    hintText: hintText,
    contentPadding: phoneHeight(context) > 850
        ? const EdgeInsets.all(20)
        : const EdgeInsets.all(0),
    filled: true,
    fillColor: Colors.white,
    labelText: text,
    labelStyle: TextStyle(color: colors),
    prefixIcon: icon,
    errorStyle: const TextStyle(fontSize: 12),
    enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 0, color: Colors.white)),
    focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: DARK_GREY_COLOR)),
    errorBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.red)),
    focusedErrorBorder: const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.red)),
  );
}

// ---------------------------- Link Color ----------------------------
TextStyle linkStyle = const TextStyle(
    fontFamily: "Signika",
    fontSize: 18,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.underline);

// -------------------- Button Style ----------------
ButtonStyle style = const ButtonStyle(
    backgroundColor: MaterialStatePropertyAll(DARK_GREY_COLOR));

// ---------------------------- Dark Grey Theme ----------------------------
const Color DARK_GREY_COLOR = Color.fromRGBO(57, 57, 57, 1);
const Color DARK_YELLOW_COLOR = Color.fromRGBO(255, 207, 0, 1);

// ---------------------------- Main theme ----------------------------
ThemeData themeData(bool isLightMode) {
  return ThemeData(
      primarySwatch: isLightMode
          ? Colors.orange
          : MaterialColor(0xFF424242, <int, Color>{
              50: Colors.grey,
              100: Colors.grey[100]!,
              200: Colors.grey[200]!,
              300: Colors.grey[300]!,
              400: Colors.grey[400]!,
              500: Colors.grey[500]!,
              600: Colors.grey[600]!,
              700: Colors.grey[700]!,
              800: Colors.grey[800]!,
              900: Colors.grey[900]!,
            }),
      drawerTheme: DrawerThemeData(
          backgroundColor: isLightMode ? DARK_YELLOW_COLOR : DARK_GREY_COLOR),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
              textStyle: MaterialStatePropertyAll(TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: isLightMode ? Colors.white : DARK_GREY_COLOR)),
              backgroundColor: isLightMode
                  ? const MaterialStatePropertyAll(DARK_YELLOW_COLOR)
                  : const MaterialStatePropertyAll(DARK_GREY_COLOR))),
      appBarTheme: AppBarTheme(
          backgroundColor: isLightMode ? DARK_YELLOW_COLOR : DARK_GREY_COLOR,
          titleTextStyle:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      fontFamily: "Signika",
      primaryIconTheme: IconThemeData(
          size: 5, color: isLightMode ? DARK_YELLOW_COLOR : DARK_GREY_COLOR),
      iconTheme: IconThemeData(
          color: isLightMode ? DARK_YELLOW_COLOR : DARK_GREY_COLOR));
}
