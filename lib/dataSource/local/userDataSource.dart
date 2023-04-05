import 'package:epark/models/user.dart';
import 'package:epark/objectBox/objectBox.dart';
import 'package:epark/objectBoxState/objectBoxState.dart';

class UserDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> registerUser(User user) async {
    try {
      return objectBoxInstance.registerUser(user);
    } catch (e) {
      return 0;
    }
  }

  Future<List<User>> getAllUser() async {
    try {
      return objectBoxInstance.getAllUser();
    } catch (e) {
      return [];
    }
  }

  Future<User?> loginUser(String username, String password) async {
    try {
      User? user = objectBoxInstance.loginStudent(username, password);
      return user;
    } catch (e) {
      return Future.value(null);
    }
  }
}
