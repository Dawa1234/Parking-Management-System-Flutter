import 'package:epark/models/user.dart';
import 'package:epark/services/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserProvider extends StateNotifier<User> {
  UserProvider(super.state);

  // set user value to the state
  Future<User?> setUser(
      String username, String password, String forgetpassword) async {
    User? user = await logInUser(username, password, forgetpassword);
    if (user != null) {
      state = user;
      return state;
    }
    return null;
  }

  // initalzation of provider
  static final userProvider =
      StateNotifierProvider<UserProvider, User>((ref) => UserProvider(User()));
}
