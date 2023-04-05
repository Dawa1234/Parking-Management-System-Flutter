import 'package:epark/providers/userProvider.dart';
import 'package:epark/screens/authenticationScreen/loginPage.dart';
import 'package:epark/screens/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const route = "/splashScreen";
  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  // Notification Permission
  _createNotificationEnabled() {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        AwesomeNotifications().requestPermissionToSendNotifications();
      }
    });
  }

  // Route to dashboard
  void dashboardRoute(String username, String password) {
    ref
        .read(UserProvider.userProvider.notifier)
        .setUser(username, password, "")
        .whenComplete(() {
      // Navigate to Dashboard when completed.
      Navigator.pushReplacementNamed(context, DashboardScreen.route);
      // Navigator.pushReplacementNamed(context, WearOsDashboardScreen.route);
    }).catchError((e) {
      print(e);
    });
  }

// Route to Login Page
  void loginScreenRoute() {
    // Login screen for wearOs watch.
    // Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() {
    //   Navigator.pushReplacementNamed(context, WearLoginPageScreen.route);
    // });
    // Login screen for phone
    Future.delayed(const Duration(milliseconds: 1500)).whenComplete(() {
      Navigator.pushReplacementNamed(context, LoginPageScreen.route);
    });
  }

// User already logged in previously?
  void loggedInCheck() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username') ?? "";
      String password = prefs.getString('password') ?? "";
      // If logged in...
      if (username != "" && password != "") {
        dashboardRoute(username, password); // Route to dashboard
        // If not...
      } else {
        loginScreenRoute(); // Route to login page
      }
    } catch (e) {
      print(e);
    }
  }

  // Current DarkMode

  @override
  void initState() {
    // TODO: implement initState
    loggedInCheck();
    _createNotificationEnabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CircleAvatar(
          radius: 60, backgroundImage: AssetImage("assets/images/logo.png")),
    ));

    // return WatchShape(
    //   builder: (context, shape, child) {
    //     return AmbientMode(
    //       builder: (context, mode, child) {
    //         return const Scaffold(
    //             body: Center(
    //           child: CircleAvatar(
    //               radius: 60,
    //               backgroundImage: AssetImage("assets/images/logo.png")),
    //         ));
    //       },
    //     );
    //   },
    // );
  }
}
