import 'package:epark/api/networkConnectivity.dart';
import 'package:epark/dataSource/remote/transactionDataSource.dart';
import 'package:epark/models/transacation.dart';

abstract class TransactionReposiptory {
  Future<List<TransactionHistoryModel>> getTransactions(String userId);
  Future<int> addTransaction(TransactionHistoryModel transactionHistoryModel);
}

class TransactionReposiptoryImpl extends TransactionReposiptory {
  @override
  Future<List<TransactionHistoryModel>> getTransactions(String userId) async {
    // bool networkStatus = true;
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return TransactionRemoteDataSource().getTransactions(userId);
    }
    return [];
  }

  @override
  Future<int> addTransaction(
      TransactionHistoryModel transactionHistoryModel) async {
    bool networkStatus = await NetworkConnection.isOnline();
    if (networkStatus) {
      return TransactionRemoteDataSource()
          .addTransaction(transactionHistoryModel);
    }
    return 0;
  }
}
