// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parkingSlotResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParkingSlotResponse _$ParkingSlotResponseFromJson(Map<String, dynamic> json) =>
    ParkingSlotResponse(
      parkingSlots: (json['parkingSlots'] as List<dynamic>?)
          ?.map((e) => ParkingSlot.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ParkingSlotResponseToJson(
        ParkingSlotResponse instance) =>
    <String, dynamic>{
      'parkingSlots': instance.parkingSlots,
    };
