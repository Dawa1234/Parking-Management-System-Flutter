import 'package:dio/dio.dart';
import 'package:epark/api/apiUrl.dart';
import 'package:epark/api/httpServices.dart';
import 'package:epark/dataSource/remote/response/parkingSlot/parkingSlotResponse.dart';
import 'package:epark/models/parkingSlot.dart';

class ParkingSlotRemoteDataSource {
  final Dio __httpService = HttpService().getDioInstance();

  // Get all the parking slots from certain flood by floor Id
  Future<List<ParkingSlot>> getAllParkingSlots(String floorId) async {
    try {
      Response response = await __httpService.get(
          "/floor/$floorId/parkingSlots",
          options: Options(headers: {'Authorization': API_URL.token}));
      if (response.statusCode == 200) {
        ParkingSlotResponse parkingSlotResponse =
            ParkingSlotResponse.fromJson(response.data);
        return parkingSlotResponse.parkingSlots!;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Book the selected Parking Slots
  Future<int> bookSlots(List<String> selectedSlots, String userId) async {
    try {
      Response response = await __httpService.put(API_URL.bookingURL,
          options: Options(headers: {"Authorization": API_URL.token}),
          data: {"userId": userId, "parkingSlots": selectedSlots});
      if (response.statusCode == 200) {
        return 1;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }

  // Book the selected Parking Slots
  Future<int> cancelBooking(String slotId) async {
    try {
      Response response = await __httpService.put(
        "/parkingSlot/$slotId",
        options: Options(headers: {"Authorization": API_URL.token}),
      );
      if (response.statusCode == 200) {
        return 1;
      }
      return 0;
    } catch (e) {
      return 0;
    }
  }
}
