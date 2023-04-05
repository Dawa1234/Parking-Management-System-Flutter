import 'package:epark/models/transacation.dart';
import 'package:epark/repository/transactionRepo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GetTransactionHistory
    extends StateNotifier<List<TransactionHistoryModel>> {
  GetTransactionHistory(super.state);

  Future<List<TransactionHistoryModel>> getTransactions(String userId) async {
    await TransactionReposiptoryImpl().getTransactions(userId).then((value) {
      state = value;
    });
    return state;
  }

  static final getTransactionHistory = StateNotifierProvider<
      GetTransactionHistory,
      List<TransactionHistoryModel>>((ref) => GetTransactionHistory([]));
}
