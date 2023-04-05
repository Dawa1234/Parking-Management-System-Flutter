// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'responseTransaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TransactionHistoryResponse _$TransactionHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    TransactionHistoryResponse(
      allTransaction: (json['allTransaction'] as List<dynamic>?)
          ?.map((e) =>
              TransactionHistoryModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TransactionHistoryResponseToJson(
        TransactionHistoryResponse instance) =>
    <String, dynamic>{
      'allTransaction': instance.allTransaction,
    };
