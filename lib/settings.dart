import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:epark/providers/darkMode_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends ConsumerStatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  static String route = "/settingScreen";

  @override
  ConsumerState<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends ConsumerState<SettingScreen> {
  void updateValue(BuildContext context, WidgetRef ref) {
    ref.read(LightModeNotifier.isLightModeProvider.notifier).changeTheme();
  }

  toggleMode(bool isLightMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lightMode', isLightMode);
  }

  double _proximityValue = 0;
  final List<StreamSubscription<dynamic>> _streamSubscription = [];
  @override
  void initState() {
    _streamSubscription.add(proximityEvents!.listen((event) {
      _proximityValue = event.proximity;
      if (_proximityValue < 5) {
        toggleMode(true);
        updateValue(context, ref);
      } else {
        toggleMode(false);
        updateValue(context, ref);
      }
    }));
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    for (var subscription in _streamSubscription) {
      subscription.cancel();
    }
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLightMode = ref.watch(LightModeNotifier.isLightModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Mode"),
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Toggle dark mode and light mode as you prefer for the application. Bottom images are some examples.",
              style: TextStyle(
                color: Color.fromARGB(255, 65, 65, 65),
                fontSize: 18,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: isLightMode
                            ? () {
                                toggleMode(false);
                                updateValue(context, ref);
                              }
                            : null,
                        child: const Text("Enable")),
                    Container(
                      height: 200,
                      width: 120,
                      decoration: BoxDecoration(
                          border: const Border.fromBorderSide(BorderSide(
                              color: Color.fromARGB(255, 78, 78, 78),
                              width: 10)),
                          image: const DecorationImage(
                              image: AssetImage("assets/images/dark.jpg")),
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ],
                ),
                Column(
                  children: [
                    ElevatedButton(
                        onPressed: isLightMode
                            ? null
                            : () {
                                toggleMode(true);
                                updateValue(context, ref);
                              },
                        child: const Text("Enable")),
                    Container(
                      decoration: BoxDecoration(
                          border: const Border.fromBorderSide(BorderSide(
                              color: Color.fromARGB(255, 71, 71, 71),
                              width: 10)),
                          color: Colors.black,
                          image: const DecorationImage(
                              image: AssetImage("assets/images/light.jpg")),
                          borderRadius: BorderRadius.circular(10)),
                      height: 200,
                      width: 120,
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
