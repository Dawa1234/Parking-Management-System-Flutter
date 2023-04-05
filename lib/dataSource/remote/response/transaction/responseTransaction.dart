import 'package:epark/models/transacation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'responseTransaction.g.dart';

@JsonSerializable()
class TransactionHistoryResponse {
  List<TransactionHistoryModel>? allTransaction;

  TransactionHistoryResponse({this.allTransaction});

  factory TransactionHistoryResponse.fromJson(Map<String, dynamic> json) =>
      _$TransactionHistoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionHistoryResponseToJson(this);
}
