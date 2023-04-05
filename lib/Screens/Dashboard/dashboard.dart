import 'package:epark/api/apiUrl.dart';
import 'package:epark/measure/measure.dart';
import 'package:epark/models/transacation.dart';
import 'package:epark/models/user.dart';
import 'package:epark/models/vehicleCategory.dart';
import 'package:epark/providers/transaction_provider.dart';
import 'package:epark/providers/userProvider.dart';
import 'package:epark/providers/vehicle_provider.dart';
import 'package:epark/screens/bookings/cancelslots/chooseCategory.dart';
import 'package:epark/screens/dashboard/dashboardNavigation.dart';
import 'package:epark/screens/floor/floorScreen.dart';
import 'package:epark/screens/transactionHistory.dart';
import 'package:epark/theme/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  static const route = "/dashboardScreen";

  // Styling
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);
  getAllVehicle(WidgetRef ref) {
    ref
        .watch(GetallVehicleProvider.getAllVehicleProvider.notifier)
        .getAllVehicle();
  }

  getAllTransactionHistory(WidgetRef ref) {
    String userId = ref.watch(UserProvider.userProvider).user_id!;
    ref
        .watch(GetTransactionHistory.getTransactionHistory.notifier)
        .getTransactions(userId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    getAllVehicle(ref);
    getAllTransactionHistory(ref);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: phoneHeight(context) < 300
            ? const EdgeInsets.all(50)
            : phoneHeight(context) < 500
                ? const EdgeInsets.all(100)
                : phoneHeight(context) < 1000
                    ? const EdgeInsets.all(40)
                    : const EdgeInsets.all(150),
        crossAxisSpacing: phoneHeight(context) > 800 ? 10 : 20,
        mainAxisSpacing: phoneHeight(context) > 800 ? 50 : 20,
        crossAxisCount: 2,
        children: [
// ---------------------------- Book Park (Car) -------------------------------------------------
          const _DisplayCar(),
// ---------------------------- Park Status -------------------------------------------------
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, VehicleCategoryScreen.route);
            },
            child: Container(
              decoration: homeBoxDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.menu_book_sharp,
                    size: 100,
                    color: DARK_GREY_COLOR,
                  ),
                  Text(
                    "Parking Status",
                    style: style,
                  )
                ],
              ),
            ),
          ),
// ---------------------------- Book Park (Bike) -------------------------------------------------
          const _DisplayBike(),
// ---------------------------- Transaction History -------------------------------------------------
          // const _DisplayBike(),
          const _TransactionHistory(),
        ],
      ),
// ---------------------------- Drawer -------------------------------------------------
      drawer: _Drawer(),
    );
  }
}

// ---------------------------- Drawer -------------------------------------------------
// ignore: must_be_immutable
class _Drawer extends ConsumerWidget {
  _Drawer({Key? key}) : super(key: key);
  final List _lstOfNavigation = [
    'Profile',
    'Our Location',
    'Settings',
    'Security',
    'Log out',
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User userData = ref.watch(UserProvider.userProvider);
    return SafeArea(
      child: Drawer(
        width: phoneWidth(context) * 0.7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            gap20,
            ListTile(
              textColor: Colors.white,
              title: Text(userData.fullname!),
              subtitle: Text(userData.email!),
              leading: userData.profileImage != null &&
                      userData.profileImage != "" &&
                      userData.profileImage != "none"
                  ? CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "http://10.0.2.2:3001/${userData.profileImage}"),
                    )
                  : const CircleAvatar(
                      radius: 20,
                      backgroundImage: AssetImage("assets/images/default.jpg"),
                    ),
            ),
            gap10,
            gap10,
            Container(
              color: const Color.fromARGB(255, 177, 177, 177),
              height: 0.8,
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: _lstOfNavigation.length,
                  itemBuilder: (context, index) {
                    return DashboardNavigationScreen(_lstOfNavigation[index]);
                  }),
            ),
            RichText(
                text: const TextSpan(children: [
              TextSpan(text: "E"),
              TextSpan(
                  text: "park", style: TextStyle(color: DARK_YELLOW_COLOR)),
            ])),
            gap10
          ],
        ),
      ),
    );
  }
}

// ------------------------------ Car ------------------------------------------
class _DisplayCar extends ConsumerWidget {
  const _DisplayCar({Key? key}) : super(key: key);
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ref
    //     .watch(GetallVehicleProvider.getAllVehicleProvider.notifier)
    //     .getAllVehicle();
    // List<VehicleCategory> allVehicle =
    //     ref.watch(GetallVehicleProvider.getAllVehicleProvider);
    Future<List<VehicleCategory>> data(WidgetRef ref) async {
      return ref.watch(GetallVehicleProvider.getAllVehicleProvider);
    }

    return Container(
      decoration: homeBoxDecoration,
      child: FutureBuilder(
        future: data(ref),
        builder: (context, AsyncSnapshot<List<VehicleCategory>> snapshot) {
          // On progress/waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: phoneHeight(context) > 1000
                  ? const EdgeInsets.all(120)
                  : const EdgeInsets.all(60),
              child: const CircularProgressIndicator(),
            );
            // On connection active/done
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            // if snapshot has successfully recieve data
            if (snapshot.hasData) {
              VehicleCategory car = VehicleCategory(
                floor: [],
                vehicleCategory: "none",
                vehicleId: "none",
              );
              // List<VehicleCategory> allVehicle =
              //     ref.watch(GetallVehicleProvider.getAllVehicleProvider);
              // if (allVehicle.isNotEmpty) {
              //   car = snapshot.data![0];
              // }
              if (snapshot.data!.isNotEmpty) {
                car = snapshot.data![0];
              }
              // Main content
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, FloorScreen.route,
                      arguments: car.floor);
                },
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.car_repair,
                        size: 100,
                        color: DARK_GREY_COLOR,
                      ),
                      Text(
                        "Book Park \n    (${car.vehicleCategory})",
                        style: style,
                      )
                    ],
                  ),
                ),
              );
              // if snapshot has an error
            } else if (snapshot.hasError) {
              return const Text("Error on snapshot");
              // if snapshot has no data
            } else {
              return const Text("No data");
            }
          } else {
            return const Text("State error");
          }
        },
      ),
    );
  }
}

// ------------------------------ Bike ------------------------------------------
class _DisplayBike extends ConsumerWidget {
  const _DisplayBike({Key? key}) : super(key: key);
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);
  Future<List<VehicleCategory>> data(WidgetRef ref) async {
    return ref.watch(GetallVehicleProvider.getAllVehicleProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: homeBoxDecoration,
      child: FutureBuilder(
        future: data(ref),
        builder: (context, AsyncSnapshot<List<VehicleCategory>> snapshot) {
          // On progress/waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: phoneHeight(context) > 1000
                  ? const EdgeInsets.all(120)
                  : const EdgeInsets.all(60),
              child: const CircularProgressIndicator(),
            );
            // On connection active/done
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            // if snapshot has successfully recieve data
            if (snapshot.hasData) {
              VehicleCategory bike = VehicleCategory(
                floor: [],
                vehicleCategory: "none",
                vehicleId: "none",
              );
              // List<VehicleCategory> allVehicle =
              //     ref.watch(GetallVehicleProvider.getAllVehicleProvider);
              // if (allVehicle.isNotEmpty) {
              //   bike = snapshot.data![1];
              // }
              if (snapshot.data!.isNotEmpty) {
                bike = snapshot.data![1];
              }
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, FloorScreen.route,
                      arguments: bike.floor);
                },
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.bike_scooter_outlined,
                        size: 100,
                        color: DARK_GREY_COLOR,
                      ),
                      Text(
                        "Book Park \n    (${bike.vehicleCategory})",
                        style: style,
                      )
                    ],
                  ),
                ),
              );
              // if snapshot has an error
            } else if (snapshot.hasError) {
              return const Text("Error on snapshot");
              // if snapshot has no data
            } else {
              return const Text("No data");
            }
          } else {
            return const Text("State error");
          }
        },
      ),
    );
  }
}

// ------------------------------ Transaction History ------------------------------------------
class _TransactionHistory extends ConsumerWidget {
  const _TransactionHistory({Key? key}) : super(key: key);
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);
  // String user_Id = API_URL.userData.user_id ?? "none";
  Future<List<TransactionHistoryModel>> data(WidgetRef ref) async {
    return ref.watch(GetTransactionHistory.getTransactionHistory);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: homeBoxDecoration,
      child: FutureBuilder(
        future: data(ref),
        builder:
            (context, AsyncSnapshot<List<TransactionHistoryModel>> snapshot) {
          // On progress/waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: phoneHeight(context) > 1000
                  ? const EdgeInsets.all(120)
                  : const EdgeInsets.all(60),
              child: const CircularProgressIndicator(),
            );
            // On connection active/done
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            // if snapshot has successfully recieve data
            if (snapshot.hasData) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TransactionHistory(
                                allTransactions: API_URL.allTransaction,
                              )));
                },
                child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.attach_money,
                        size: 100,
                        color: DARK_GREY_COLOR,
                      ),
                      Text(
                        "Transaction\n     History",
                        style: style,
                      )
                    ],
                  ),
                ),
              );
              // if snapshot has an error
            } else if (snapshot.hasError) {
              return const Text("Error on snapshot");
              // if snapshot has no data
            } else {
              return const Text("No data");
            }
          } else {
            return const Text("State error");
          }
        },
      ),
    );
  }
}
