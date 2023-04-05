import 'dart:ui';

import 'package:epark/objectBox/objectBox.dart';
import 'package:epark/objectBoxState/objectBoxState.dart';
import 'package:epark/providers/darkMode_provider.dart';
import 'package:epark/routes.dart';
import 'package:epark/screens/SplashScreen.dart';
import 'package:epark/theme/themeData.dart';
import 'package:flutter/material.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:flutter/services.dart';
import 'package:workmanager/workmanager.dart';

// @pragma('vm:entry-point')
// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     // final prefs = await SharedPreferences.getInstance();
//     // List<String> slotIds = prefs.getStringList("bookedSlots") ?? [];
//     // for (var slotId in slotIds) {
//     //   Future.delayed(const Duration(seconds: 1)).whenComplete(() async {
//     //     await ParkingSlotRepoImpl().cancleSlots(slotId);
//     //   });
//     // }
//     // showNotification(
//     //     title: "Time up!", body: "Times up! Booked slots removed!", id: 1);
//     return Future.value(true);
//   });
// }

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) {
    AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 1,
          channelKey: 'important_channel',
          title: "ASld;aksjdl",
          body: "aslkdjaljsda",
          backgroundColor: const Color.fromARGB(255, 53, 53, 53)),
    );
    return Future.value(true);
  });
}

void main() async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  // await Workmanager().initialize(callbackDispatcher);
  AwesomeNotifications().initialize('resource://drawable/logo', [
    NotificationChannel(
        channelGroupKey: 'important_channel_key',
        channelKey: 'important_channel',
        channelName: 'Login Notification',
        channelDescription: 'Epark notificaiton',
        importance: NotificationImportance.Max,
        defaultColor: Colors.green,
        ledColor: Colors.red,
        channelShowBadge: true)
  ]);
  ObjectBoxState.objectBoxInstance = await ObjectBoxInstance.init();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(const ProviderScope(child: Home())),
  );
}

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(LightModeNotifier.isLightModeProvider.notifier).changeTheme();
    bool isLightMode = ref.watch(LightModeNotifier.isLightModeProvider);
    return KhaltiScope(
        publicKey: "test_public_key_20435233a21a47c6ab85b4fb6baf1121",
        builder: (context, navigatorKey) {
          return MaterialApp(
            navigatorKey: navigatorKey,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('ne', 'NP'),
            ],
            localizationsDelegates: const [
              KhaltiLocalizations.delegate,
            ],
            theme: themeData(isLightMode),
            debugShowCheckedModeBanner: false,
            // home: const FaceIdScreen(),
            // initialRoute: BookSlotScreen.route,
            initialRoute: SplashScreen.route,
            routes: getAppRoutes,
          );
        });
  }
}
