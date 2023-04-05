// ignore_for_file: use_build_context_synchronously, file_names
import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:epark/providers/userProvider.dart';
import 'package:epark/screens/wear_os/wear_dashboard.dart';
import 'package:epark/measure/measure.dart';
import 'package:epark/measure/registerPage_responsive.dart';
import 'package:epark/services/services.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:epark/theme/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wear/wear.dart';

class WearLoginPageScreen extends ConsumerStatefulWidget {
  const WearLoginPageScreen({Key? key}) : super(key: key);
  static const route = "/wearOsloginScreen";

  @override
  ConsumerState<WearLoginPageScreen> createState() =>
      _WearLoginPageScreenState();
}

class _WearLoginPageScreenState extends ConsumerState<WearLoginPageScreen> {
  final TextEditingController _userNameController =
      TextEditingController(text: "user1");
  final TextEditingController _passwordController =
      TextEditingController(text: "123123123");
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  _showNotification() async {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'important_channel',
          title: 'New device Login!',
          body:
              'You have been logged in by a new user. \n ${DateTime.now().toString().split(' ')[0]}',
          backgroundColor: const Color.fromARGB(255, 53, 53, 53)),
    );
  }

  _loginUser(String username, String password) {
    ref
        .read(UserProvider.userProvider.notifier)
        .setUser(username, password, "")
        .then((value) {
      // Credintial matched
      if (value != null) {
        successBar(context, "Logged In");
        Navigator.pushReplacementNamed(context, WearOsDashboardScreen.route,
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

  @override
  Widget build(BuildContext context) {
// ------------------------- Scaffold -----------------------------------
    return Scaffold(
// ------------------------- Body Section -----------------------------------
      body: WatchShape(builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).unfocus(),
              child: Container(
                height: phoneHeight(context),
                width: phoneWidth(context),
                padding: responsiveForWidth(context),
                color: DARK_YELLOW_COLOR,
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        gap10,
// ------------------------- Username Field -----------------------------------
                        textFormField(
                            context, "Username", const Icon(Icons.person),
                            validator: nameValidator,
                            controller: _userNameController,
                            testKey: "txtLogin"),
                        gap10,

// ------------------------- Password Field -----------------------------------
                        textFormField(
                            context, "Password", const Icon(Icons.password),
                            controller: _passwordController,
                            obscureText: true,
                            testKey: "txtPassword"),
                        gap40,

// ------------------------- Login Button -----------------------------------
                        SizedBox(
                          width: phoneWidth(context),
                          height: 45,
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  setState(() {
                                    _loading = true;
                                  });
                                  _loginUser(_userNameController.text,
                                      _passwordController.text);
                                }
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    "LOGIN",
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  // Loading bar....
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
                        gap20,
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
