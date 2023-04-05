import 'package:epark/models/vehicleCategory.dart';
import 'package:epark/repository/vehicleRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetallVehicleProvider extends StateNotifier<List<VehicleCategory>> {
  GetallVehicleProvider(super.state);

  Future<List<VehicleCategory>> getAllVehicle() async {
    await VehicleRepoImpl().getAllvehicle().then((value) {
      state = value;
    });
    return state;
  }

  static final getAllVehicleProvider =
      StateNotifierProvider<GetallVehicleProvider, List<VehicleCategory>>(
          (ref) => GetallVehicleProvider([]));
}
