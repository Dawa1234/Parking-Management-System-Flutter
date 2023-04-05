import 'package:epark/api/apiUrl.dart';
import 'package:epark/dataSource/remote/userDataSource.dart';
import 'package:epark/models/parkingSlot.dart';
import 'package:epark/models/transacation.dart';
import 'package:epark/models/user.dart';
import 'package:epark/models/vehicleCategory.dart';
import 'package:epark/repository/parkingslotRepo.dart';
import 'package:epark/repository/transactionRepo.dart';
import 'package:epark/repository/userRepo.dart';
import 'package:epark/repository/vehicleRepo.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/src/widgets/binding.dart';

void main() {
  setUp(() {
    WidgetsFlutterBinding.ensureInitialized();
    API_URL.token =
        "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfaWQiOiI2NDAwNWU0NTNkNTgyZmVjZmFjOWE1NTEiLCJ1c2VybmFtZSI6InRlc3QiLCJwYXNzd29yZCI6IiQyYSQxMCQ2V2hDZUhPS2NHUzVhd2dzcFlhUkdPT1VUQXdTNmRZOTRrdS5YQVJyOGhEcTdCSEZNWTZvMiIsImZvcmdldFBhc3N3b3JkIjoiMTIzMzExMjMiLCJmdWxsbmFtZSI6InRlc3QxMjMiLCJjb250YWN0IjoiOTIwMTkyOTM4MiIsImVtYWlsIjoidGVzdDEyM0BnbWFpbC5jb20iLCJyb2xlIjoiQWRtaW4iLCJpYXQiOjE2Nzc3NDU4NDgsImV4cCI6MTY3NzgzMjI0OH0.PQRLqQZ8KRPV5fBNnhTruNRt0tt02kPWGlxPkyTx7ZA";
  });
  group('Login and registration testing', () {
    test('Register through api testing', () async {
      User user = User(
          fullname: "test123",
          email: "test123@gmail.com",
          contact: "9201929382",
          username: "test",
          password: "test123123",
          forgetPassword: "12331123",
          role: "Admin");
      Map<int, String> expectedResult = {1: "Registerd Successfully"};
      Map<int, String> actualResut =
          await UserRemoteDataSource().registerUser(user);
      expect(actualResut, expectedResult);
    });
    test('Login through API testing', () async {
      User? user =
          await UserRemoteDataSource().loginUser('test', 'test123123', "");
      bool expectedValue = true;
      bool actualValue = false;
      // On login success

      if (user != null) {
        actualValue = true;
      }
      expect(actualValue, expectedValue);
    }, timeout: Timeout.none);

    test('Update user through api testing', () async {
      String userId = "64005e453d582fecfac9a551";
      // ------------------ Updated User Date ------------------
      User updatedUser = User();
      updatedUser.username = "test";
      updatedUser.fullname = "test1";
      updatedUser.email = "test1@gmail.com";
      updatedUser.contact = "9829283928";
      // ------------------ Updated User Date ------------------
      int expectedResult = 1;
      int actualResut =
          await UserRemoteDataSource().updateProfile(null, userId, updatedUser);
      expect(actualResut, expectedResult);
    });
    test('Get user through api testing', () async {
      String userId = "64005e453d582fecfac9a551";
      int expectedResult = 1;
      int actualResut = await UserRemoteDataSource().getUserById(userId);
      expect(actualResut, expectedResult);
    });

    test('Delete user through api testing', () async {
      String userId = "64005e453d582fecfac9a551";
      int expectedResult = 1;
      int actualResut = await UserRemoteDataSource().deleteUserById(userId);
      expect(actualResut, expectedResult);
    });
  });

  group("fetching data..", () {
    test("Fetch all vehicles", () async {
      bool actualvalue = false;
      List<VehicleCategory> allVehicle =
          await VehicleRepoImpl().getAllvehicle();
      bool expectedValue = true;
      if (allVehicle.isEmpty) {
        actualvalue = true;
      }
      expect(actualvalue, expectedValue);
    });
    test("Fetch all parking Slots from floor", () async {
      bool actualvalue = false;
      List<ParkingSlot> parkingSlots = await ParkingSlotRepoImpl()
          .getAllParkingSlot("63de96ea55aff61b698bec32");
      bool expectedValue = true;
      if (parkingSlots.isEmpty) {
        actualvalue = true;
      }
      expect(actualvalue, expectedValue);
    });

    test("Fetch all transaction history of a user", () async {
      bool actualvalue = false;
      List<TransactionHistoryModel> allTransaction =
          await TransactionReposiptoryImpl()
              .getTransactions("63ee7de8dfd4325766d48cd9");
      bool expectedValue = true;
      if (allTransaction.isEmpty) {
        actualvalue = true;
      }
      expect(actualvalue, expectedValue);
    });
  });

  group("getting booked bike and car of a user", () {
    test("get the booked bike", () async {
      bool actualvalue = false;
      List<ParkingSlot> bookedBike =
          await UserRepositoryImpl().getSlotByBike("63ee7de8dfd4325766d48cd9");
      bool expectedValue = true;
      if (bookedBike.isEmpty) {
        actualvalue = true;
      }
      expect(actualvalue, expectedValue);
    });
  });
  test("get the booked car", () async {
    bool actualvalue = false;
    List<ParkingSlot> bookedCar =
        await UserRepositoryImpl().getSlotByCar("63ee7de8dfd4325766d48cd9");
    bool expectedValue = true;
    if (bookedCar.isEmpty) {
      actualvalue = true;
    }
    expect(actualvalue, expectedValue);
  });
}
