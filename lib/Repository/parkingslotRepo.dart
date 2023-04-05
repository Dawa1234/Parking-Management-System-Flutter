import 'package:epark/api/networkConnectivity.dart';
import 'package:epark/dataSource/remote/parkingslotDataSourse.dart';
import 'package:epark/models/parkingSlot.dart';

abstract class ParkingSlotReposiptory {
  Future<List<ParkingSlot>> getAllParkingSlot(String floorId);
  Future<int> bookSlots(List<String> selectedSlots, String userId);
  Future<int> cancleSlots(String slotId);
}

class ParkingSlotRepoImpl extends ParkingSlotReposiptory {
  @override
  Future<List<ParkingSlot>> getAllParkingSlot(String floorId) async {
    // only while testing
    // bool networkStatus = true;
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return await ParkingSlotRemoteDataSource().getAllParkingSlots(floorId);
    }
    return [];
  }

  @override
  Future<int> bookSlots(List<String> selectedSlots, String userId) async {
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return await ParkingSlotRemoteDataSource()
          .bookSlots(selectedSlots, userId);
    }
    return 0;
  }

  @override
  Future<int> cancleSlots(String slotId) async {
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return await ParkingSlotRemoteDataSource().cancelBooking(slotId);
    }
    return 0;
  }
}
