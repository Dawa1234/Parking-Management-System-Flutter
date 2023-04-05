// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Floor _$FloorFromJson(Map<String, dynamic> json) => Floor(
      floorId: json['_id'] as String?,
      floorNum: json['floorNum'] as String?,
      parkingSlot: (json['parkingSlot'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      floor_id: json['floor_id'] as int? ?? 0,
    );

Map<String, dynamic> _$FloorToJson(Floor instance) => <String, dynamic>{
      'floor_id': instance.floor_id,
      '_id': instance.floorId,
      'floorNum': instance.floorNum,
      'parkingSlot': instance.parkingSlot,
    };
