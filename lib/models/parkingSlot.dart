import 'package:epark/models/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'parkingSlot.g.dart';

@JsonSerializable()
@Entity()
class ParkingSlot {
  @Id(assignable: true)
  int parkingSlot_id;

  String slot;
  String row;
  String column;
  String? floorId;
  bool booked;
  bool occupied;

  final floor = ToOne<Floor>();

  // For Api
  String? userId;
  @Unique()
  @JsonKey(name: "_id")
  String? parkingId;
  String? vehicleCategory;

  ParkingSlot(this.row, this.column,
      {this.parkingId,
      this.slot = "",
      this.floorId,
      this.userId,
      this.occupied = false,
      this.booked = false,
      this.vehicleCategory,
      this.parkingSlot_id = 0});

  factory ParkingSlot.fromJson(Map<String, dynamic> json) =>
      _$ParkingSlotFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingSlotToJson(this);
}
