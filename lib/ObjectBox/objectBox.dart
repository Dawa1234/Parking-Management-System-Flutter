import 'package:epark/models/floor.dart';
import 'package:epark/models/parkingSlot.dart';
import 'package:epark/models/vehicleCategory.dart';
import 'package:epark/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';

class ObjectBoxInstance {
  late final Store _store;
  late final Box<User> _user;
  late final Box<ParkingSlot> _parkingSlot;
  late final Box<Floor> _floor;
  late final Box<VehicleCategory> _vehicleCategory;

  ObjectBoxInstance(this._store) {
    _user = Box<User>(_store);
    _parkingSlot = Box<ParkingSlot>(_store);
    _floor = Box<Floor>(_store);
    _vehicleCategory = Box<VehicleCategory>(_store);
  }

  static Future<ObjectBoxInstance> init() async {
    var dir = await getApplicationDocumentsDirectory();
    final store = Store(getObjectBoxModel(), directory: '${dir.path}/User');
    return ObjectBoxInstance(store);
  }

  // If add successful return integer.
  int registerUser(User user) {
    return _user.put(user);
  }

  List<User> getAllUser() {
    // _user.removeAll();
    return _user.getAll();
  }

  User? loginStudent(String username, String password) {
    return _user
        .query(
            User_.username.equals(username) & User_.password.equals(password))
        .build()
        .findFirst();
  }
}
