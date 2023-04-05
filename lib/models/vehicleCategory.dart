import 'package:epark/models/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'vehicleCategory.g.dart';

@JsonSerializable()
@Entity()
class VehicleCategory {
  @Id(assignable: true)
  int vehicle_id;

  @Unique()
  @Index()
  @JsonKey(name: "_id")
  String? vehicleId;
  String? vehicleCategory;
  List<Floor>? floor;

  @Backlink()
  final floors = ToMany<Floor>();

  VehicleCategory(
      {this.vehicleCategory, this.floor, this.vehicleId, this.vehicle_id = 0});

  factory VehicleCategory.fromJson(Map<String, dynamic> json) =>
      _$VehicleCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$VehicleCategoryToJson(this);
}
