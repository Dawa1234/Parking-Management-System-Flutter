import 'dart:io';

import 'package:dio/dio.dart';
import 'package:epark/api/apiUrl.dart';
import 'package:epark/api/httpServices.dart';
import 'package:epark/dataSource/remote/response/login/login_response.dart';
import 'package:epark/dataSource/remote/response/parkingSlot/parkingSlotResponse.dart';
import 'package:epark/models/parkingSlot.dart';
import 'package:epark/models/user.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/src/media_type.dart';

class UserRemoteDataSource {
  final Dio _httpService = HttpService().getDioInstance();

  // ---------------- Login ------------------------------
  Future<User?> loginUser(
      String username, String password, String forgetPasssword) async {
    User? user;
    try {
      // On password
      if (password != "") {
        Response response = await _httpService.post(API_URL.loginURL, data: {
          'username': username,
          'password': password,
        });
        if (response.statusCode == 203) {
          LoginResponse loginResponse = LoginResponse.fromJson(response.data);
          API_URL.token = "Bearer ${loginResponse.token}";
          user = loginResponse.user!;
          return user;
        }
      }

      // On forgot password
      if (forgetPasssword != "") {
        Response response = await _httpService.post(API_URL.loginURL, data: {
          'username': username,
          'forgetPassword': forgetPasssword,
        });
        if (response.statusCode == 203) {
          LoginResponse loginResponse = LoginResponse.fromJson(response.data);
          API_URL.token = "Bearer ${loginResponse.token}";
          user = loginResponse.user!;
          return user;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

// -------------------- Add new user -----------------------------------
  Future<Map<int, String>> registerUser(User user) async {
    Response response;
    try {
      response = await _httpService.post(API_URL.registerURL, data: {
        'fullname': user.fullname,
        'contact': user.contact,
        'email': user.email,
        'username': user.username,
        'password': user.password,
        'forgetPassword': user.forgetPassword,
        'role': user.role
      });
      /*  status 400, 401, 403, 404, etc are known as error from the server itself
      so jumps to catch directly */
      // status 201, 203 , etc are success statusCode.
      if (response.statusCode == 201) {
        return {1: "Registerd Successfully"};
      } else {
        return {0: "Status code${response.statusCode} not found"};
      }
    } catch (e) {
      return {0: "Username already taken"};
    }
  }

  // -------------------- Delete user id ---------------------
  // Only for testing purpose
  Future<int> deleteUserById(String userId) async {
    try {
      Response response = await _httpService.delete(API_URL.deleteUserURL,
          options: Options(headers: {"Authorization": API_URL.token}),
          queryParameters: {"userId": userId});
      if (response.statusCode == 200) {
        return 1;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // -------------------- Update user ---------------------
  Future<int> updateProfile(File? img, String userId, User user) async {
    try {
      // convert file image
      MultipartFile? extractedImage;
      if (img != null) {
        var mimeType = lookupMimeType(img.path);
        extractedImage = await MultipartFile.fromFile(img.path,
            filename: img.path.split("/").last,
            contentType: MediaType('image', mimeType!.split('/')[1]));
      }

      // To send image we need to send as a formdata.
      // where in api multer is used to accept api
      FormData formData = FormData.fromMap({
        'fullname': user.fullname,
        'email': user.email,
        'contact': user.contact,
        'username': user.username,
        'image': extractedImage
      });

      // req/res
      Response response = await _httpService.put(API_URL.updateUserURL,
          options: Options(headers: {"Authorization": API_URL.token}),
          queryParameters: {"userId": userId},
          data: formData);
      if (response.statusCode == 200) {
        return 1;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // -------------------- Update user ---------------------
  Future<int> getUserById(String userId) async {
    try {
      Response response = await _httpService.get(API_URL.getUserURL,
          options: Options(headers: {"Authorization": API_URL.token}),
          queryParameters: {"userId": userId});
      if (response.statusCode == 200) {
        return 1;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // -------------------- Update Password ---------------------
  Future<int> updatePassword(String userId, Map<String, String> data) async {
    try {
      Response response = await _httpService.put(API_URL.updatePasswordURL,
          options: Options(headers: {"Authorization": API_URL.token}),
          queryParameters: {
            "userId": userId
          },
          data: {
            'oldPassword': data['oldPassword'],
            'newPassword': data['newPassword'],
          });
      if (response.statusCode == 200) {
        return 1;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // -------------------- Get parking by bike booked by user ---------------------
  Future<List<ParkingSlot>> getSlotByBike(String userId) async {
    try {
      Response response = await _httpService.get(API_URL.getBookedBikes,
          options: Options(headers: {"Authorization": API_URL.token}),
          queryParameters: {"userId": userId});
      if (response.statusCode == 200) {
        ParkingSlotResponse parkingSlotResponse =
            ParkingSlotResponse.fromJson(response.data);
        return parkingSlotResponse.parkingSlots!;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // -------------------- Get parking by bike booked by user ---------------------
  Future<List<ParkingSlot>> getSlotByCar(String userId) async {
    try {
      Response response = await _httpService.get(API_URL.getBookedCar,
          options: Options(headers: {"Authorization": API_URL.token}),
          queryParameters: {"userId": userId});
      if (response.statusCode == 200) {
        ParkingSlotResponse parkingSlotResponse =
            ParkingSlotResponse.fromJson(response.data);
        return parkingSlotResponse.parkingSlots!;
      }
      return [];
    } catch (e) {
      return [];
    }
  }

  // -------------------- Get parking by bike booked by user ---------------------
  Future<bool> checkPassword(String username, String password) async {
    try {
      Response response = await _httpService.post(API_URL.checkPassword,
          options: Options(headers: {"Authorization": API_URL.token}),
          data: {
            'username': username,
            'password': password,
          });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
