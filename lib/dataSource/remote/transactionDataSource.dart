import 'package:dio/dio.dart';
import 'package:epark/api/apiUrl.dart';
import 'package:epark/api/httpServices.dart';
import 'package:epark/dataSource/remote/response/transaction/responseTransaction.dart';
import 'package:epark/models/transacation.dart';

class TransactionRemoteDataSource {
  final Dio __httpService = HttpService().getDioInstance();

  // Get the transaction
  Future<List<TransactionHistoryModel>> getTransactions(String userId) async {
    try {
      Response response = await __httpService.get(
        API_URL.getTransactions,
        queryParameters: {'userId': userId},
        options: Options(headers: {"Authorization": API_URL.token}),
      );
      if (response.statusCode == 201) {
        TransactionHistoryResponse transactionResponse =
            TransactionHistoryResponse.fromJson(response.data);
        API_URL.allTransaction = transactionResponse.allTransaction!;
        return transactionResponse.allTransaction!;
      }
      return [];
    } catch (e) {
      print(e);
      return [];
    }
  }

  // Post a transaction of a user
  Future<int> addTransaction(
      TransactionHistoryModel transactionHistoryModel) async {
    final transactionData = {
      'date': transactionHistoryModel.date,
      'userId': transactionHistoryModel.userId,
      'slot': transactionHistoryModel.slot,
      'amount': transactionHistoryModel.amount,
      'vehicleCategory': transactionHistoryModel.vehicleCategory,
    };
    try {
      Response response = await __httpService.post(API_URL.addTransactions,
          options: Options(
            headers: {"Authorization": API_URL.token},
          ),
          data: transactionData);
      if (response.statusCode == 201) {
        return 1;
      }
      return 0;
    } catch (e) {
      print(e);
      return 0;
    }
  }
}
