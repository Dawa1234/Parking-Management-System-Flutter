import 'package:epark/models/parkingSlot.dart';
import 'package:json_annotation/json_annotation.dart';
part 'parkingSlotResponse.g.dart';

@JsonSerializable()
class ParkingSlotResponse {
  List<ParkingSlot>? parkingSlots;

  ParkingSlotResponse({this.parkingSlots});

  factory ParkingSlotResponse.fromJson(Map<String, dynamic> json) =>
      _$ParkingSlotResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParkingSlotResponseToJson(this);
}
