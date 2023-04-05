import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LightModeNotifier extends StateNotifier<bool> {
  LightModeNotifier(super.state);

  setData(bool islightMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('lightMode', islightMode);
  }

  Future<bool> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLightMode = prefs.getBool('lightMode') ?? false;
    return isLightMode;
  }

  void changeTheme() async {
    getData().then((value) {
      state = value;
    });
  }

  // initalzation of provider
  static final isLightModeProvider =
      StateNotifierProvider<LightModeNotifier, bool>(
          (ref) => LightModeNotifier(false));
}
