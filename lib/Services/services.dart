import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:epark/models/user.dart';
import 'package:epark/objectBox/objectBox.dart';
import 'package:epark/objectBoxState/objectBoxState.dart';
import 'package:epark/repository/userRepo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

// Call object box
ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;
// -------------------- Register user ------------------------------
Future<Map<int, String>> registerUser(User user) async {
  // Response value
  Map<int, String> registerUserCheck =
      await UserRepositoryImpl().registerUser(user);
  return registerUserCheck;
}

// -------------------- Log in ------------------------------
Future<User?> logInUser(
    String username, String password, String forgetpassword) async {
  // User variable
  User? user;
  try {
    // Get the user from the data source.
    await UserRepositoryImpl()
        .loginUser(username, password, forgetpassword)
        .then((value) {
      // If data fetch is success.
      if (value != null) {
        saveData(username, password); // Store data in shared_preferences
        user = value; // Update user variable
        var data = objectBoxInstance
            .getAllUser()
            .where((element) => element.username == value.username)
            .toList();
        if (data.isEmpty) {
          value.password = password;
          objectBoxInstance.registerUser(value);
        }
        return user;
      }
      return null;
    });
  }
  // On error
  catch (e) {
    print(e);
    return null;
  }
  return user;
}

// Store data in shared_preferences
Future saveData(String username, String password) async {
  try {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString("username", username);
    await prefs.setString("password", password);
    // For fingerprint/faceId
    await prefs.setString("bio_username", username);
    await prefs.setString("bio_password", password);
  } catch (e) {
    print(e);
  }
}

// ------------------------ Log out --------------------------------
Future logOut() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('username'); // remove the data from shared_preferences
  await prefs.remove('password'); // remove the data from shared_preferences
}

Future showNotification(
    {required String title, required String body, required int id}) async {
  AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: id,
        channelKey: 'important_channel',
        title: title,
        body: body,
        backgroundColor: const Color.fromARGB(255, 53, 53, 53)),
  );
}

class LocalAuth {
  static final _auth = LocalAuthentication();

  // Is device supported
  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics || await _auth.isDeviceSupported();

  static Future<bool> authenticate() async {
    bool canAuthenticaiton = await _canAuthenticate();
    try {
      if (!canAuthenticaiton) return false;

      return await _auth.authenticate(
          authMessages: const [
            AndroidAuthMessages(
                signInTitle: 'Sign In', cancelButton: 'No thanks'),
            IOSAuthMessages(cancelButton: 'No thanks'),
          ],
          localizedReason: 'Use Face Id to Log In',
          options: const AuthenticationOptions(
            useErrorDialogs: true,
            stickyAuth: true,
          ));
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return false;
    }
  }
}
