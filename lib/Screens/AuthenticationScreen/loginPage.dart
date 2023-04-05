// ignore_for_file: use_build_context_synchronously, file_names

import 'dart:math';

import 'package:epark/measure/measure.dart';
import 'package:epark/measure/registerPage_responsive.dart';
import 'package:epark/providers/userProvider.dart';
import 'package:epark/screens/authenticationScreen/registerPage.dart';
import 'package:epark/screens/dashboard/dashboard.dart';
import 'package:epark/services/services.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:epark/theme/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPageScreen extends ConsumerStatefulWidget {
  const LoginPageScreen({Key? key}) : super(key: key);
  static const route = "/loginScreen";

  @override
  ConsumerState<LoginPageScreen> createState() => _LoginPageScreenState();
}

class _LoginPageScreenState extends ConsumerState<LoginPageScreen> {
  final TextEditingController _userNameController =
      TextEditingController(text: "user1");
  final TextEditingController _passwordController =
      TextEditingController(text: "123123123");
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  final TextEditingController _forgetPasswordController =
      TextEditingController();
  bool _loading = false;

// login function
  _loginUser(String username, String password, String forgetpassword) {
    // logInUser(username, password, forgetpassword).then((value) {
    //   if (value != null) {
    //     API_URL.userData = value;
    //     Navigator.pushReplacementNamed(context, DashboardScreen.route);
    //   }
    // });
    ref
        .read(UserProvider.userProvider.notifier)
        .setUser(username, password, forgetpassword)
        .then((value) {
      // Credintial matched
      if (value != null) {
        successBar(context, "Logged In");
        Navigator.pushReplacementNamed(context, DashboardScreen.route,
            arguments: value);
        // Notiication
        String body =
            'You have been logged in by a new user. \n ${DateTime.now().toString().split(' ')[0]}';
        Random random = Random();
        int id = random.nextInt(10000);
        showNotification(title: "New Device Login", body: body, id: id);
        _loading = false;
      } else {
        // Credintial unmatched
        invalidBar(context, "Invalid Username or Password");
        setState(() {
          _loading = false;
        });
      }
    });
  }

  Future<bool> _biometrics() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString("bio_username") ?? "";
    final password = prefs.getString("bio_password") ?? "";
    if (username == "" || password == "") {
      invalidBar(context, "Please login atleast once to set your bio!");
      return false;
    }
    bool authenticated = await LocalAuth.authenticate();
    if (authenticated) {
      _loginUser(username, password, "");
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
// ------------------------- Scaffold -----------------------------------
    return Scaffold(
// ------------------------- Body Section -----------------------------------
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: phoneHeight(context),
          width: phoneWidth(context),
          padding: responsiveForWidth(context),
          color: DARK_YELLOW_COLOR,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  phoneHeight(context) > 700 ? gap200 : gap80,
// ------------------------- Logo -----------------------------------
                  const CircleAvatar(
                    radius: 90,
                    backgroundColor: Colors.red,
                    backgroundImage: AssetImage("assets/images/logo.png"),
                  ),
                  phoneHeight(context) > 800 ? gap100 : gap50,
// ------------------------- Username Field -----------------------------------
                  textFormField(context, "Username", const Icon(Icons.person),
                      validator: nameValidator,
                      controller: _userNameController,
                      testKey: "txtUsername"),
                  gap10,

// ------------------------- Password Field -----------------------------------
                  textFormField(context, "Password", const Icon(Icons.password),
                      validator: passwordValidator,
                      controller: _passwordController,
                      testKey: "txtPassword",
                      obscureText: true),
                  gap40,

// ------------------------- Login Button -----------------------------------
                  SizedBox(
                    width: phoneWidth(context),
                    height: 45,
                    child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(DARK_GREY_COLOR)),
                        key: const ValueKey('btnLogin'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // setState(() {
                            //   _loading = true;
                            // });
                            // Log in check
                            _loginUser(_userNameController.text,
                                _passwordController.text, "");
                          }
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "LOGIN",
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // Loading bar
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
                        )),
                  ),
                  gap20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
// ------------------------- Forgot Password -----------------------------------
                      InkWell(
                        onTap: () {
                          // Diaglog box
                          showDialog(
                              useSafeArea: true,
                              context: context,
                              builder: (context) {
                                return GestureDetector(
                                  onTap: () => FocusScope.of(context).unfocus(),
                                  child: AlertDialog(
                                    icon: const Icon(
                                      Icons.info,
                                      color: DARK_YELLOW_COLOR,
                                    ),
                                    title: const Text(
                                      "Enter the generated password provided to you.",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                    backgroundColor:
                                        const Color.fromARGB(255, 49, 49, 49),
                                    // Content size
                                    content: SizedBox(
                                      height: 220,
                                      child: Form(
                                        key: _formKey1,
                                        child: Column(
                                          children: [
                                            textFormField(context, "Username",
                                                const Icon(Icons.person),
                                                validator: nameValidator,
                                                controller: _userNameController,
                                                testKey: "txtUsername"),
                                            gap10,
                                            textFormField(
                                                obscureText: true,
                                                context,
                                                "Password",
                                                const Icon(Icons.password),
                                                validator: passwordValidator,
                                                controller:
                                                    _forgetPasswordController,
                                                testKey: "txtForgetPassword"),
                                            gap10,
                                            SizedBox(
                                              width: phoneWidth(context),
                                              height: 45,
                                              child: ElevatedButton(
                                                  style: const ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStatePropertyAll(
                                                              DARK_YELLOW_COLOR)),
                                                  key: const ValueKey(
                                                      'btnLogin'),
                                                  onPressed: () {
                                                    if (_formKey1.currentState!
                                                        .validate()) {
                                                      setState(() {
                                                        _loading = true;
                                                      });
                                                      // Log in check
                                                      _loginUser(
                                                          _userNameController
                                                              .text,
                                                          "",
                                                          _forgetPasswordController
                                                              .text);
                                                    }
                                                  },
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Text(
                                                        "LOGIN",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      const SizedBox(
                                                        width: 10,
                                                      ),
                                                      // Loading bar
                                                      _loading == true
                                                          ? const SizedBox(
                                                              height: 20,
                                                              width: 20,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color: Colors
                                                                    .white,
                                                                strokeWidth: 2,
                                                              ),
                                                            )
                                                          : const Text("")
                                                    ],
                                                  )),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              });
                        },
                        child: Text(
                          "Forget Password?",
                          style: linkStyle,
                        ),
                      ),
// ------------------------- Sign Up -----------------------------------
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, RegsiterScreen.route);
                        },
                        child: Text(
                          "Sign Up",
                          style: linkStyle,
                        ),
                      ),
                    ],
                  ),
                  gap20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
// ------------------------- Forgot Password -----------------------------------
                      InkWell(
                        onTap: () async {
                          final prefs = await SharedPreferences.getInstance();
                          setState(() {
                            _loading = true;
                          });
                          await _biometrics();
                          setState(() {
                            _loading = false;
                          });
                        },
                        child: const CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage("assets/images/bio.png"),
                        ),
                      ),
                    ],
                  ),
                  gap20,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
