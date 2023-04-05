import 'dart:math';

import 'package:epark/measure/measure.dart';
import 'package:epark/measure/registerPage_responsive.dart';
import 'package:epark/models/user.dart';
import 'package:epark/providers/userProvider.dart';
import 'package:epark/repository/userRepo.dart';
import 'package:epark/services/services.dart';
import 'package:epark/theme/themeData.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  static const route = "/updatePasswordScreen";

  @override
  ConsumerState<UpdatePasswordScreen> createState() =>
      _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends ConsumerState<UpdatePasswordScreen> {
  bool _loading = false;

  User user = User();

  // icon statuc
  bool _oldPassword = true;

  bool _newPassword = true;

  bool _confirmPassword = true;

  final TextEditingController _oldPasswordController = TextEditingController();

  final TextEditingController _newPasswordController = TextEditingController();

  final TextEditingController _confirmPassowrdController =
      TextEditingController();

  // Form validation
  final _formKey = GlobalKey<FormState>();

  void _updatePassword() async {
    user = ref.watch(UserProvider.userProvider);
    Map<String, String> data = {
      "oldPassword": _oldPasswordController.text,
      "newPassword": _newPasswordController.text,
    };
    int status = await UserRepositoryImpl().updatePassword(user.user_id!, data);
    _checkStatus(status);
  }

  _checkStatus(int status) {
    if (status > 0) {
      successBar(context, "Password Updated");
      Random random = Random();
      int id = random.nextInt(10000);
      showNotification(
          title: "Password Updated",
          body: "Your password has been updated",
          id: id);
      setState(() {
        _loading = false;
      });
      return;
    }
    setState(() {
      _loading = false;
    });
    invalidBar(context, "Incorrect old password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Password"), centerTitle: true),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          color: DARK_GREY_COLOR,
          height: phoneHeight(context),
          width: phoneWidth(context),
          padding: responsiveForWidth(context),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  responsiveForHeight(context),
// ------------------------ Old Passowrd ------------------------------------------
                  TextFormField(
                    validator: passwordValidator,
                    controller: _oldPasswordController,
                    obscureText: _oldPassword,
                    decoration: InputDecoration(
                      contentPadding: phoneHeight(context) > 850
                          ? const EdgeInsets.all(20)
                          : const EdgeInsets.all(0),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Old Password",
                      labelStyle: const TextStyle(color: DARK_YELLOW_COLOR),
                      suffix: _oldPassword == true
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _oldPassword = !_oldPassword;
                                  });
                                },
                                child: const Icon(
                                  Icons.lock,
                                  size: 20,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _oldPassword = !_oldPassword;
                                  });
                                },
                                child: const Icon(
                                  Icons.lock_open_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                      prefixIcon: const Icon(Icons.password),
                      errorStyle: const TextStyle(fontSize: 12),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.white)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: DARK_GREY_COLOR)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                    ),
                  ),
                  responsiveForHeight1(context),
// ------------------------ New Passowrd ------------------------------------------
                  TextFormField(
                    validator: _newPasswordController.text ==
                            _confirmPassowrdController.text
                        ? passwordValidator
                        : unEqualValidator,
                    controller: _newPasswordController,
                    obscureText: _newPassword,
                    decoration: InputDecoration(
                      contentPadding: phoneHeight(context) > 850
                          ? const EdgeInsets.all(20)
                          : const EdgeInsets.all(0),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "New Password",
                      labelStyle: const TextStyle(color: DARK_YELLOW_COLOR),
                      suffix: _newPassword == true
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _newPassword = !_newPassword;
                                  });
                                },
                                child: const Icon(
                                  Icons.lock,
                                  size: 20,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _newPassword = !_newPassword;
                                  });
                                },
                                child: const Icon(
                                  Icons.lock_open_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                      prefixIcon: const Icon(Icons.password),
                      errorStyle: const TextStyle(fontSize: 12),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.white)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: DARK_GREY_COLOR)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                    ),
                  ),
                  responsiveForHeight1(context),
// ------------------------ Confirm Password ------------------------------------------
                  TextFormField(
                    validator: _newPasswordController.text ==
                            _confirmPassowrdController.text
                        ? passwordValidator
                        : unEqualValidator,
                    controller: _confirmPassowrdController,
                    obscureText: _confirmPassword,
                    decoration: InputDecoration(
                      contentPadding: phoneHeight(context) > 850
                          ? const EdgeInsets.all(20)
                          : const EdgeInsets.all(0),
                      filled: true,
                      fillColor: Colors.white,
                      labelText: "Confirm Password",
                      labelStyle: const TextStyle(color: DARK_YELLOW_COLOR),
                      suffix: _confirmPassword == true
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _confirmPassword = !_confirmPassword;
                                  });
                                },
                                child: const Icon(
                                  Icons.lock,
                                  size: 20,
                                ),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 15.0, 0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _confirmPassword = !_confirmPassword;
                                  });
                                },
                                child: const Icon(
                                  Icons.lock_open_outlined,
                                  size: 20,
                                ),
                              ),
                            ),
                      prefixIcon: const Icon(Icons.password),
                      errorStyle: const TextStyle(fontSize: 12),
                      enabledBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0, color: Colors.white)),
                      focusedBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 1, color: DARK_GREY_COLOR)),
                      errorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                      focusedErrorBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.red)),
                    ),
                  ),
                  gap30,
// ------------------------ Update Password ------------------------------------------
                  SizedBox(
                    width: phoneWidth(context),
                    height: 45,
                    child: ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(DARK_YELLOW_COLOR)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            _loading = true;
                          });
                          _updatePassword();
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "UPDATE",
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
