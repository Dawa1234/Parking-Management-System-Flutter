import 'dart:math';

import 'package:epark/measure/measure.dart';
import 'package:epark/measure/registerPage_responsive.dart';
import 'package:epark/models/user.dart';
import 'package:epark/screens/authenticationScreen/loginPage.dart';
import 'package:epark/services/services.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:epark/theme/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegsiterScreen extends ConsumerStatefulWidget {
  const RegsiterScreen({Key? key}) : super(key: key);

  static const route = "/registerScreen";

  @override
  ConsumerState<RegsiterScreen> createState() => _RegsiterScreenState();
}

class _RegsiterScreenState extends ConsumerState<RegsiterScreen> {
  bool _loading = false;

  final TextEditingController _fullNameController =
      TextEditingController(text: "David");
  final TextEditingController _emailController =
      TextEditingController(text: "david@gmail.com");
  final TextEditingController _phoneNumberController =
      TextEditingController(text: "9893829342");
  final TextEditingController _usernameController =
      TextEditingController(text: "david123");
  final TextEditingController _passwordController =
      TextEditingController(text: "123123123");
  final TextEditingController _confirmPassowrdController =
      TextEditingController(text: "123123123");
  // Form validation
  final _formKey = GlobalKey<FormState>();

  // Registration Check
  _checkStatus(int status, String message) {
    if (status > 0) {
      _fullNameController.clear();
      _emailController.clear();
      _phoneNumberController.clear();
      _usernameController.clear();
      _passwordController.clear();
      _confirmPassowrdController.clear();

      Navigator.pushReplacementNamed(context, LoginPageScreen.route);
      successBar(context, "Registered Successfully!");
      _loading = false;
    } else {
      setState(() {
        _loading = false;
      });
      invalidBar(context, message);
    }
  }

  _registerUser() {
    int forgetPassword = Random().nextInt(99999999) + 11111111;
    // Make new user
    User user = User(
        fullname: _fullNameController.text,
        email: _emailController.text,
        contact: _phoneNumberController.text,
        username: _usernameController.text,
        password: _passwordController.text,
        forgetPassword: forgetPassword.toString());

    // Pass to register function.
    registerUser(user).then((Map<int, String> status) {
      //
      _checkStatus(status.keys.first, status[0].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: DARK_YELLOW_COLOR,
          height: phoneHeight(context),
          width: phoneWidth(context),
          padding: responsiveForWidth(context),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  responsiveForHeight(context),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundColor: DARK_GREY_COLOR,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                  responsiveForHeight(context),
// ------------------------ Full name ------------------------------------------
                  textFormField(context, "Full Name", const Icon(Icons.person),
                      controller: _fullNameController,
                      validator: nameValidator,
                      testKey: "fullNameKey"),
                  responsiveForHeight1(context),
// ------------------------ Email ------------------------------------------
                  textFormField(
                      context, "Email (Optional)", const Icon(Icons.email),
                      controller: _emailController,
                      validator: emailValidator,
                      testKey: "emailKey"),
                  responsiveForHeight1(context),
// ------------------------ Phone ------------------------------------------
                  textFormField(
                      context,
                      "(+977) Contact",
                      const Icon(
                        Icons.phone,
                      ),
                      keyboardType: TextInputType.number,
                      controller: _phoneNumberController,
                      validator: phoneNumberValidator,
                      testKey: "contactKey"),
                  responsiveForHeight1(context),
// ------------------------ Username ------------------------------------------
                  textFormField(context, "Username", const Icon(Icons.person),
                      controller: _usernameController,
                      validator: nameValidator,
                      testKey: "usernameKey"),
                  responsiveForHeight1(context),
// ------------------------ Passowrd ------------------------------------------
                  textFormField(context, "Password", const Icon(Icons.password),
                      obscureText: true,
                      controller: _passwordController,
                      validator: _passwordController.text ==
                              _confirmPassowrdController.text
                          ? passwordValidator
                          : unEqualValidator,
                      testKey: "passwordKey"),
                  responsiveForHeight1(context),
// ------------------------ Confirm Password ------------------------------------------
                  textFormField(
                      context, "Confirm Password", const Icon(Icons.password),
                      obscureText: true,
                      controller: _confirmPassowrdController,
                      validator: _passwordController.text ==
                              _confirmPassowrdController.text
                          ? passwordValidator
                          : unEqualValidator,
                      testKey: "confirmPasswordKey"),
                  gap30,
// ------------------------ Register ------------------------------------------
                  SizedBox(
                    width: phoneWidth(context),
                    height: 45,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(DARK_GREY_COLOR)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          _registerUser();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "REGISTER",
                            style: TextStyle(color: Colors.white),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          _loading == true
                              ? const SizedBox(
                                  height: 20,
                                  width: 20,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text("")
                        ],
                      ),
                    ),
                  ),
                  responsiveForHeight1(context),
                  // Already have an account?
                  InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, "/loginScreen");
                      },
                      child:
                          Text("Already have an account?", style: linkStyle)),
                  gap10
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
