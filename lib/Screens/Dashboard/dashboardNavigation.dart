import 'package:epark/screens/authenticationScreen/loginPage.dart';
import 'package:epark/screens/google_map.dart';
import 'package:epark/screens/profileScreen/profile.dart';
import 'package:epark/screens/security.dart';
import 'package:epark/services/services.dart';
import 'package:epark/settings.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:flutter/material.dart';

class DashboardNavigationScreen extends StatelessWidget {
  String path;
  // User userData;

  Icon person = const Icon(
    Icons.person,
    color: Colors.white,
  );
  Icon security = const Icon(
    Icons.security,
    color: Colors.white,
  );
  Icon about_us = const Icon(
    Icons.menu_book_rounded,
    color: Colors.white,
  );
  Icon settings = const Icon(
    Icons.settings,
    color: Colors.white,
  );
  Icon log_out = const Icon(
    Icons.logout,
    color: Colors.white,
  );
  Icon disabled_by_default = const Icon(
    Icons.disabled_by_default,
    color: Colors.white,
  );

  DashboardNavigationScreen(this.path, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        switch (path) {
          case "Profile":
            Navigator.pushNamed(context, ProfileScreen.route);
            break;
          case "Our Location":
            Navigator.pushNamed(context, GoogleMapScreen.route);
            break;
          case "Settings":
            Navigator.pushNamed(context, SettingScreen.route);
            break;
          case "Security":
            Navigator.pushNamed(context, SecurityScreen.route);
            break;
          case "Log out":
            logOut().whenComplete(() {
              Navigator.pushReplacementNamed(context, LoginPageScreen.route);
              successBar(context, "Logged Out");
            });
            break;
          default:
        }
      },
      leading: path == 'Profile'
          ? person // Person Icon
          : path == 'Security'
              ? security // Star Icon
              : path == 'Our Location'
                  ? about_us // Our location Icon
                  : path == 'Settings'
                      ? settings // Settings Icon
                      : path == 'Log out'
                          ? log_out // Settings Icon
                          : disabled_by_default, // Default Icon
      title: Text(path),
      textColor: Colors.white,
    );
  }
}
