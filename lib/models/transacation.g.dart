// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transacation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistoryModel _$TransactionHistoryModelFromJson(
        Map<String, dynamic> json) =>
    TransactionHistoryModel(
      date: json['date'] as String?,
      slot: json['slot'] as String?,
      vehicleCategory: json['vehicleCategory'] as String?,
      amount: json['amount'] as String?,
      userId: json['userId'] as String?,
    )..transasctionId = json['_id'] as String?;

Map<String, dynamic> _$TransactionHistoryModelToJson(
        TransactionHistoryModel instance) =>
    <String, dynamic>{
      '_id': instance.transasctionId,
      'date': instance.date,
      'slot': instance.slot,
      'vehicleCategory': instance.vehicleCategory,
      'amount': instance.amount,
      'userId': instance.userId,
    };
