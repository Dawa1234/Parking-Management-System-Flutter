import 'package:epark/api/networkConnectivity.dart';
import 'package:epark/dataSource/remote/vehicleDataSource.dart';
import 'package:epark/models/vehicleCategory.dart';

abstract class VechilceReposiptory {
  Future<List<VehicleCategory>> getAllvehicle();
}

class VehicleRepoImpl extends VechilceReposiptory {
  @override
  Future<List<VehicleCategory>> getAllvehicle() async {
    // only while testing
    // bool networkStatus = true;
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return VehicleRemoteDataSource().getAllvehicle();
    }
    return [];
  }
}
