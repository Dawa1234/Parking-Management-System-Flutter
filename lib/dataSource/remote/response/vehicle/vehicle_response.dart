import 'package:epark/models/vehicleCategory.dart';
import 'package:json_annotation/json_annotation.dart';
part 'vehicle_response.g.dart';

@JsonSerializable()
class VehicleResponse {
  List<VehicleCategory>? vehicle;

  VehicleResponse({this.vehicle});

  factory VehicleResponse.fromJson(Map<String, dynamic> json) =>
      _$VehicleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleResponseToJson(this);
}
