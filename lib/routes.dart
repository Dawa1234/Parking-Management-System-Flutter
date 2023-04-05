import 'package:epark/screens/authenticationScreen/loginPage.dart';
import 'package:epark/screens/authenticationScreen/registerPage.dart';
import 'package:epark/screens/bookings/bookslots/slotScreen.dart';
import 'package:epark/screens/bookings/cancelslots/chooseCategory.dart';
import 'package:epark/screens/bookings/cancelslots/slots.dart';
import 'package:epark/screens/dashboard/dashboard.dart';
import 'package:epark/screens/SplashScreen.dart';
import 'package:epark/screens/floor/floorScreen.dart';
import 'package:epark/screens/google_map.dart';
import 'package:epark/screens/parkStatusScreen.dart';
import 'package:epark/screens/profileScreen/profile.dart';
import 'package:epark/screens/profileScreen/updatePassword.dart';
import 'package:epark/screens/security.dart';
import 'package:epark/screens/transactionHistory.dart';
import 'package:epark/screens/wear_os/wearOs_cancelslots/chooseCategory.dart';
import 'package:epark/screens/wear_os/wearOs_cancelslots/slots.dart';
import 'package:epark/screens/wear_os/wear_dashboard.dart';
import 'package:epark/screens/wear_os/wear_login.dart';
import 'package:epark/screens/wear_os/wear_profile.dart';
import 'package:epark/settings.dart';
import 'package:flutter/material.dart';

var getAppRoutes = <String, WidgetBuilder>{
  SplashScreen.route: (context) => const SplashScreen(),
  GoogleMapScreen.route: (context) => const GoogleMapScreen(),
  LoginPageScreen.route: (context) => const LoginPageScreen(),
  RegsiterScreen.route: (context) => const RegsiterScreen(),
  DashboardScreen.route: (context) => const DashboardScreen(),
  BookSlotScreen.route: (context) => BookSlotScreen(),
  CancelSlotScreen.route: (context) => const CancelSlotScreen(),
  FloorScreen.route: (context) => const FloorScreen(),
  ParkStatusScreen.route: (context) => const ParkStatusScreen(),
  ProfileScreen.route: (context) => const ProfileScreen(),
  SettingScreen.route: (context) => const SettingScreen(),
  SecurityScreen.route: (context) => const SecurityScreen(),
  UpdatePasswordScreen.route: (context) => const UpdatePasswordScreen(),
  TransactionHistory.route: (context) =>
      TransactionHistory(allTransactions: const []),
  VehicleCategoryScreen.route: (context) => const VehicleCategoryScreen(),
  // --------------------- Wear Os Routes ---------------------
  WearOsVehicleCategoryScreen.route: (context) =>
      const WearOsVehicleCategoryScreen(),
  WearOsCancelSlotScreen.route: (context) => const WearOsCancelSlotScreen(),
  WearLoginPageScreen.route: (context) => const WearLoginPageScreen(),
  WearOsDashboardScreen.route: (context) => const WearOsDashboardScreen(),
  WearOsUserProfile.route: (context) => const WearOsUserProfile(),
};
