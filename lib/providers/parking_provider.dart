import 'package:epark/models/parkingSlot.dart';
import 'package:epark/repository/parkingslotRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetParkingSlotProvider extends StateNotifier<List<ParkingSlot>> {
  GetParkingSlotProvider(super.state);

  Future<List<ParkingSlot>> getAllParkingSlot(String floorId) async {
    await ParkingSlotRepoImpl().getAllParkingSlot(floorId).then((value) {
      state = value;
    });
    return state;
  }

  static final getParkingSlots =
      StateNotifierProvider<GetParkingSlotProvider, List<ParkingSlot>>(
          (ref) => GetParkingSlotProvider([]));
}
