import 'dart:io';

import 'package:epark/api/networkConnectivity.dart';
import 'package:epark/dataSource/local/userDataSource.dart';
import 'package:epark/dataSource/remote/userDataSource.dart';
import 'package:epark/models/parkingSlot.dart';
import 'package:epark/models/user.dart';

abstract class UserRepository {
  Future<int> updatePassword(String userId, Map<String, String> data);
  Future<Map<int, String>> registerUser(User user);
  Future<List<User>> getAllUser();
  Future<User?> loginUser(
      String username, String password, String forgetPassword);
  Future<int> updateProfile(File? img, String userId, User user);
  Future<List<ParkingSlot>> getSlotByBike(String userId);
  Future<List<ParkingSlot>> getSlotByCar(String userId);
  Future<bool> checkPassword(String username, String password);
}

class UserRepositoryImpl extends UserRepository {
// ------------------------ Register ------------------------------------
  @override
  Future<Map<int, String>> registerUser(User user) async {
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      // First save to API
      return UserRemoteDataSource().registerUser(user).whenComplete(() {
        // Only then save to object box (Local storage) (objectbox)
        UserDataSource().registerUser(user);
      });
    }
    return {0: "No network connection."};
  }

  // get all users
  @override
  Future<List<User>> getAllUser() {
    return UserDataSource().getAllUser();
  }

// ------------------------ Login ------------------------------------
  @override
  Future<User?> loginUser(
      String username, String password, String forgetPassword) async {
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return UserRemoteDataSource()
          .loginUser(username, password, forgetPassword);
    }
    return UserDataSource().loginUser(username, password);
  }

  // Update profile
  @override
  Future<int> updateProfile(File? img, String userId, User user) async {
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return UserRemoteDataSource().updateProfile(img, userId, user);
    }
    return 0;
  }

  // Update password
  @override
  Future<int> updatePassword(String userId, Map<String, String> data) async {
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return UserRemoteDataSource().updatePassword(userId, data);
    }
    return 0;
  }

  @override
  Future<List<ParkingSlot>> getSlotByBike(String userId) async {
    // only when testing
    // bool networkStatus = true;
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return UserRemoteDataSource().getSlotByBike(userId);
    }
    return [];
  }

  @override
  Future<List<ParkingSlot>> getSlotByCar(String userId) async {
    // only when testing
    // bool networkStatus = true;
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return UserRemoteDataSource().getSlotByCar(userId);
    }
    return [];
  }

  @override
  Future<bool> checkPassword(String username, String password) async {
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return UserRemoteDataSource().checkPassword(username, password);
    }
    return false;
  }
}
