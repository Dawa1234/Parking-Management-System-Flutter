import 'package:epark/models/parkingSlot.dart';
import 'package:epark/models/vehicleCategory.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'floor.g.dart';

@JsonSerializable()
@Entity()
class Floor {
  @Id(assignable: true)
  int floor_id;

  @Unique()
  @Index()
  @JsonKey(name: "_id")
  String? floorId;
  String? floorNum;
  List<String>? parkingSlot;

  final vehicle = ToOne<VehicleCategory>();
  @Backlink()
  final parkingSlots = ToMany<ParkingSlot>();

  Floor({this.floorId, this.floorNum, this.parkingSlot, this.floor_id = 0});

  factory Floor.fromJson(Map<String, dynamic> json) => _$FloorFromJson(json);

  Map<String, dynamic> toJson() => _$FloorToJson(this);
}
