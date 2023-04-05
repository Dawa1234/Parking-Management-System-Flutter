// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parkingSlot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSlot _$ParkingSlotFromJson(Map<String, dynamic> json) => ParkingSlot(
      json['row'] as String,
      json['column'] as String,
      parkingId: json['_id'] as String?,
      slot: json['slot'] as String? ?? "",
      floorId: json['floorId'] as String?,
      userId: json['userId'] as String?,
      occupied: json['occupied'] as bool? ?? false,
      booked: json['booked'] as bool? ?? false,
      vehicleCategory: json['vehicleCategory'] as String?,
      parkingSlot_id: json['parkingSlot_id'] as int? ?? 0,
    );

Map<String, dynamic> _$ParkingSlotToJson(ParkingSlot instance) =>
    <String, dynamic>{
      'parkingSlot_id': instance.parkingSlot_id,
      'slot': instance.slot,
      'row': instance.row,
      'column': instance.column,
      'floorId': instance.floorId,
      'booked': instance.booked,
      'occupied': instance.occupied,
      'userId': instance.userId,
      '_id': instance.parkingId,
      'vehicleCategory': instance.vehicleCategory,
    };
