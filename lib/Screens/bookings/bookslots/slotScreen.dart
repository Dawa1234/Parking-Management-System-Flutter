// ignore_for_file: unused_element
import 'package:epark/api/apiUrl.dart';
import 'package:epark/measure/measure.dart';
import 'package:epark/models/parkingSlot.dart';
import 'package:epark/models/transacation.dart';
import 'package:epark/providers/transaction_provider.dart';
import 'package:epark/providers/userProvider.dart';
import 'package:epark/repository/parkingslotRepo.dart';
import 'package:epark/repository/transactionRepo.dart';
import 'package:epark/screens/bookings/bookslots/slots.dart';
import 'package:epark/screens/dashboard/dashboard.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookSlotScreen extends ConsumerStatefulWidget {
  List<ParkingSlot>? parkingSlot;
  BookSlotScreen({Key? key, this.parkingSlot}) : super(key: key);
  static const route = "/carScreen";

  @override
  ConsumerState<BookSlotScreen> createState() => _CarParkScreenState();
}

class _CarParkScreenState extends ConsumerState<BookSlotScreen> {
  // Send userId while booking slots
  String userId = "";
  List<ParkingSlot> parkingSlot = [];
  // Different lists of row.
  List<ParkingSlot> r1 = [];
  List<ParkingSlot> r2 = [];
  List<ParkingSlot> r3 = [];
  List<ParkingSlot> r4 = [];
  List<ParkingSlot> r5 = [];
  List<ParkingSlot> r6 = [];

  // Row are added as a list on a list.
  List<List<ParkingSlot>> allRows = [];

  // Selected slots by user.
  List<String> selectedSlots = [];

  void seperateRows() {
    // Seperation of rows.
    for (var data in parkingSlot) {
      if (data.row == 'R-1') {
        r1.add(data);
      } else if (data.row == 'R-2') {
        r2.add(data);
      } else if (data.row == 'R-3') {
        r3.add(data);
      }
    }

    // only add if row is not empty.
    if (r1.isNotEmpty) {
      allRows.add(r1);
    }
    if (r2.isNotEmpty) {
      allRows.add(r2);
    }
    if (r3.isNotEmpty) {
      allRows.add(r3);
    }
  }

  _paymentDetail() async {
    // Initialization of transaction data
    String slots = "";
    String vehicleCategory = "";
    for (var id in selectedSlots) {
      slots =
          "$slots, ${parkingSlot.where((element) => element.parkingId!.contains(id)).first.slot}";
    }
    vehicleCategory = parkingSlot[0].vehicleCategory!;
    // -------------------------------------------------------

    // ------------------------ Send data -------------------------------
    final transactionHistoryModel = TransactionHistoryModel(
      slot: slots,
      date: DateTime.now().toString(),
      amount: "${selectedSlots.length * 15}",
      userId: userId,
      vehicleCategory: vehicleCategory,
    );
    int status = await TransactionReposiptoryImpl()
        .addTransaction(transactionHistoryModel);
    if (status > 0) {
      ref
          .read(GetTransactionHistory.getTransactionHistory.notifier)
          .getTransactions(userId);
    }
  }

  // Book the slected slots.
  _bookSlots(List<String> selectedSlots) async {
    int status = await ParkingSlotRepoImpl().bookSlots(selectedSlots, userId);

    if (status > 0) {
      Navigator.pushReplacementNamed(context, DashboardScreen.route);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList("bookedSlots", selectedSlots);
      // Set timer
      // await Workmanager().registerOneOffTask(
      //     DateTime.now().toString(), "Cancel Slots",
      //     initialDelay: const Duration(seconds: 3));
      successBar(context, "Successfully Booked");
    } else {
      invalidBar(context, "Booking failed");
    }
  }

  // showbottom sheet
  _showBottomsheet() {
    showModalBottomSheet(
      backgroundColor: Colors.grey[300],
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: SizedBox(
          height: 150,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                ],
              ),
              Row(
                children: const [
                  Text(
                    "Payment method: Online ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 78, 78, 78),
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Total Cost: ",
                    style: TextStyle(
                      color: Color.fromARGB(255, 78, 78, 78),
                      fontSize: 20,
                    ),
                  ),
                  Text(
                    "Rs. ${selectedSlots.length * 15}",
                    style: const TextStyle(
                      color: Color.fromARGB(255, 78, 78, 78),
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  API_URL.amount = selectedSlots.length * 15 * 100;
                  KhaltiScope.of(context).pay(
                    config: API_URL.config,
                    preferences: [
                      PaymentPreference.khalti,
                    ],
                    onSuccess: (successModel) {
                      _paymentDetail();
                      _bookSlots(selectedSlots);
                      successBar(context, "Payment Success");
                      // Perform Server Verification
                    },
                    onFailure: (failureModel) {
                      invalidBar(context, "Booking/Payment Unsuccess");
                      // Perform Server Verification
                    },
                    onCancel: () {
                      successBar(context, "Payment Cancelled");
                      // Perform Server Verification
                    },
                  );
                },
                child: const Text("Go for payment"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    Future.delayed(Duration.zero).whenComplete(() {
      userId = ref.watch(UserProvider.userProvider).user_id!;
    });
    parkingSlot = widget.parkingSlot!;
    seperateRows();
    super.initState();
  }

  // Information
  final List<Information> _information = [
    Information(Colors.blue, 'Your Reservation'),
    Information(Colors.yellow, 'Reserved'),
    Information(const Color.fromARGB(255, 0, 255, 8), 'Available Seats'),
    Information(const Color.fromARGB(255, 255, 255, 255), 'Park Direction'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Available Slots"),
        centerTitle: true,
      ),
      body: Container(
        width: phoneWidth(context),
        height: phoneHeight(context),
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Information
            SizedBox(
              width: double.infinity,
              height: 50,
              child: GridView.builder(
                  itemCount: _information.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio:
                          phoneHeight(context) > 1000 ? 1 / 0.05 : 1 / 0.1,
                      crossAxisSpacing: 12,
                      crossAxisCount: 2,
                      mainAxisSpacing: 12),
                  itemBuilder: (context, index) {
                    // Contents
                    return SizedBox(
                      child: Row(children: [
                        _information[index].info == 'Park Direction'
                            ? const Icon(size: 20, Icons.keyboard_arrow_up)
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                color: _information[index].color,
                                width: 15,
                                height: 15,
                                alignment: Alignment.center,
                              ),
                        Text(
                          _information[index].info,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        )
                      ]),
                    );
                  }),
            ),
            gap30,
            Expanded(
              // List of Parking slots
              child: parkingSlot.isEmpty
                  ? const Center(
                      child: Text("No Slots Available"),
                    )
                  : GridView.builder(
                      itemCount: allRows.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              childAspectRatio: 1 / 0.12,
                              crossAxisCount: 1,
                              mainAxisSpacing: 15),
                      itemBuilder: (context, index) {
                        // List of (List of rows)
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                // List of Rows
                                child: Row(
                                  children: [
                                    // List of Rows
                                    for (var data in allRows[index]) ...{
                                      // If the slot is booked disable the slots.
                                      InkWell(
                                          onTap: data.booked
                                              ? null
                                              : () async {
                                                  setState(() {
                                                    if (!selectedSlots.contains(
                                                        data.parkingId)) {
                                                      selectedSlots
                                                          .add(data.parkingId!);
                                                      return;
                                                    }
                                                    selectedSlots
                                                        .remove(data.parkingId);
                                                  });
                                                },
                                          child: slots(
                                              context, data, selectedSlots)),
                                      const SizedBox(
                                        width: 20,
                                      )
                                    }
                                  ],
                                ),
                              ),
                            ),
                            // Row names (R-1 , R-2 , etc)
                            rowName(context, allRows, index)
                          ],
                        );
                      }),
            ),
            // If no parkingSlots are selected disable the button.
            ElevatedButton(
                onPressed: selectedSlots.isEmpty
                    ? null
                    : () async {
                        // await Workmanager().registerOneOffTask(
                        //     "Please work", "Cancel Slots",
                        //     initialDelay: const Duration(seconds: 3));
                        _showBottomsheet();
                        // _bookSlots(selectedSlots);
                      },
                child: const Text('BOOK'))
          ],
        ),
      ),
      // body: _gridBuilder(context, allData),
    );
  }
}
