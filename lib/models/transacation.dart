import 'package:json_annotation/json_annotation.dart';
part 'transacation.g.dart';

@JsonSerializable()
class TransactionHistoryModel {
  @JsonKey(name: '_id')
  String? transasctionId;
  String? date;
  String? slot;
  String? vehicleCategory;
  String? amount;
  String? userId;

  TransactionHistoryModel(
      {this.date, this.slot, this.vehicleCategory, this.amount, this.userId});

  factory TransactionHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryModelFromJson(json);
}
