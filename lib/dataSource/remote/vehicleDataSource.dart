import 'package:dio/dio.dart';
import 'package:epark/api/apiUrl.dart';
import 'package:epark/api/httpServices.dart';
import 'package:epark/dataSource/remote/response/vehicle/vehicle_response.dart';
import 'package:epark/models/vehicleCategory.dart';

class VehicleRemoteDataSource {
  final Dio __httpService = HttpService().getDioInstance();

  Future<List<VehicleCategory>> getAllvehicle() async {
    try {
      Response response = await __httpService.get(
        API_URL.vehicleURL,
        options: Options(headers: {"Authorization": API_URL.token}),
      );
      if (response.statusCode == 201) {
        VehicleResponse vehicleResponse =
            VehicleResponse.fromJson(response.data);
        return vehicleResponse.vehicle!;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }
}
