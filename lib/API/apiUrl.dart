import 'package:epark/models/transacation.dart';
import 'package:epark/models/user.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

class API_URL {
  // static String baseURL = "http://localhost:3001";
  static String baseURL = "http://172.20.10.4:3001";
  // static String baseURL = "http://10.0.2.2:3001";
  // static String baseURL = "http://192.168.1.17:3001";
  // static String baseURL = "http://192.168.43.52:3001";
  static String registerURL = "/user/register";
  static String loginURL = "/user/login";
  static String vehicleURL = "/vehicle";
  static String bookingURL = "/parkingSlot";
  static String updateUserURL = "/user/updateProfile";
  static String updatePasswordURL = "/user/updatePassword";
  static String deleteUserURL = "/user/deleteUser";
  static String getUserURL = "/user/getUser";
  static String getBookedBikes = "/user/bike";
  static String getBookedCar = "/user/car";
  static String getTransactions = "/user/transaction";
  static String addTransactions = "/user/transaction";
  static String checkPassword = "/user/checkPassword";
  static List<TransactionHistoryModel> allTransaction = [];
  static int amount = 0;
  static String token = "";
  static User userData = User(
      username: "none",
      password: "none",
      profileImage: "none",
      contact: "none",
      email: "none",
      role: "none",
      user_id: "none",
      fullname: "none");

  // Khalti configuration
  static final config = PaymentConfig(
    amount: amount, // Amount should be in paisa
    productIdentity: 'dell-g5-g5510-2021',
    productName: 'Dell G5 G5510 2021',
    productUrl: 'https://www.khalti.com/#/bazaar',
    additionalData: {
      // Not mandatory; can be used for reporting purpose
      'vendor': 'Khalti Bazaar',
    },
    mobile:
        '9840355789', // Not mandatory; can be used to fill mobile number field
    mobileReadOnly: false, // Not mandatory; makes the mobile field not editable
  );
}
