import 'package:epark/api/apiUrl.dart';
import 'package:epark/measure/measure.dart';
import 'package:epark/models/transacation.dart';
import 'package:epark/providers/userProvider.dart';
import 'package:epark/repository/transactionRepo.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionHistory extends ConsumerStatefulWidget {
  List<TransactionHistoryModel> allTransactions = [];
  TransactionHistory({Key? key, required this.allTransactions})
      : super(key: key);
  static const route = "/transactionHistory";

  @override
  ConsumerState<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends ConsumerState<TransactionHistory> {
  List<TransactionHistoryModel> allTransactions = API_URL.allTransaction;
  bool _loading = false;
  bool _buttonDisable = false;
  _disabledButton() {
    successBar(context, "Refreshed");
    setState(() {
      _loading = true;
      _buttonDisable = true;
    });
    Future.delayed(const Duration(seconds: 5)).whenComplete(() {
      setState(() {
        _buttonDisable = false;
      });
    });
  }

  Future _refreshData() async {
    String userId = ref.watch(UserProvider.userProvider).user_id!;
    API_URL.allTransaction =
        await TransactionReposiptoryImpl().getTransactions(userId);
    allTransactions = API_URL.allTransaction;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allTransactions = widget.allTransactions;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Transaction History"),
          actions: const [
            // IconButton(
            //     onPressed: _buttonDisable == true
            //         ? null
            //         : () {
            //             _disabledButton();

            //             _refreshData().whenComplete(() {
            //               setState(() {
            //                 _loading = false;
            //               });
            //             });
            //           },
            //     icon: const Icon(Icons.refresh))
          ],
        ),
        body: _loading == true
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : allTransactions.isEmpty
                ? const Center(
                    child: Text("No Transactions Yet"),
                  )
                : ListView.builder(
                    itemCount: allTransactions.length,
                    itemBuilder: (context, index) {
                      return Card(
                        // margin: const EdgeInsets.all(10),
                        child: ListTile(
                          leading: const Icon(Icons.monetization_on_outlined),
                          title: Row(children: [
                            const Text(
                              "Payment process ",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 78, 78, 78),
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              width: 35,
                              height: 35,
                              child: Image.asset("assets/images/khalti.png"),
                            )
                          ]),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Payment Method: Online",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 78, 78, 78),
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              ),
                              gap10,
                              Text(
                                  "Amount: Rs.${allTransactions[index].amount}"),
                              gap10,
                              Text(
                                  "Category : ${allTransactions[index].vehicleCategory}"),
                              gap10,
                              Text(
                                  "Transaction Date : ${allTransactions[index].date}"),
                              gap10,
                              Text(
                                  "Payment id : ${allTransactions[index].transasctionId}"),
                            ],
                          ),
                        ),
                      );
                    }));
  }
}
