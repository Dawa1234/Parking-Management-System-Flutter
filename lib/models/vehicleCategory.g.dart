// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicleCategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VehicleCategory _$VehicleCategoryFromJson(Map<String, dynamic> json) =>
    VehicleCategory(
      vehicleCategory: json['vehicleCategory'] as String?,
      floor: (json['floor'] as List<dynamic>?)
          ?.map((e) => Floor.fromJson(e as Map<String, dynamic>))
          .toList(),
      vehicleId: json['_id'] as String?,
      vehicle_id: json['vehicle_id'] as int? ?? 0,
    );

Map<String, dynamic> _$VehicleCategoryToJson(VehicleCategory instance) =>
    <String, dynamic>{
      'vehicle_id': instance.vehicle_id,
      '_id': instance.vehicleId,
      'vehicleCategory': instance.vehicleCategory,
      'floor': instance.floor,
    };
