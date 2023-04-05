import "package:epark/api/apiUrl.dart";
import "package:epark/measure/measure.dart";
import "package:epark/models/parkingSlot.dart";
import "package:epark/providers/userProvider.dart";
import "package:epark/repository/userRepo.dart";
import "package:epark/screens/bookings/cancelslots/slots.dart";
import "package:epark/theme/themeData.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";

class VehicleCategoryScreen extends StatelessWidget {
  const VehicleCategoryScreen({Key? key}) : super(key: key);
  static const route = "/vehicleCategoryScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Category"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.count(
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            _BikeSlots(),
            _CarSlots(),
          ],
        ),
      ),
    );
  }
}

// Bike
class _BikeSlots extends ConsumerWidget {
  const _BikeSlots({Key? key}) : super(key: key);
  // String user_id = API_URL.userData.user_id ?? "none";
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String userId = ref.watch(UserProvider.userProvider).user_id!;
    return Container(
      decoration: homeBoxDecoration,
      child: FutureBuilder(
        future: UserRepositoryImpl().getSlotByBike(userId),
        builder: (context, AsyncSnapshot<List<ParkingSlot>> snapshot) {
          // On progress/waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: phoneHeight(context) > 1000
                  ? const EdgeInsets.all(170)
                  : const EdgeInsets.all(80),
              child: const CircularProgressIndicator(),
            );
            // On connection active/done
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            // if snapshot has successfully recieve data
            if (snapshot.hasData) {
              List<ParkingSlot> lstOfSlotbike = snapshot.data!;
              // Main content
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CancelSlotScreen.route,
                      arguments: lstOfSlotbike);
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
                        "Bike",
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

// Car
class _CarSlots extends ConsumerWidget {
  const _CarSlots({Key? key}) : super(key: key);
  // String user_id = API_URL.userData.user_id ?? "none";
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String userId = ref.watch(UserProvider.userProvider).user_id!;
    return Container(
      decoration: homeBoxDecoration,
      child: FutureBuilder(
        future: UserRepositoryImpl().getSlotByCar(userId),
        builder: (context, AsyncSnapshot<List<ParkingSlot>> snapshot) {
          // On progress/waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Padding(
              padding: phoneHeight(context) > 1000
                  ? const EdgeInsets.all(170)
                  : const EdgeInsets.all(80),
              child: const CircularProgressIndicator(),
            );
            // On connection active/done
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.done) {
            // if snapshot has successfully recieve data
            if (snapshot.hasData) {
              List<ParkingSlot> lstOfSlotCar = snapshot.data!;
              // Main content
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(context, CancelSlotScreen.route,
                      arguments: lstOfSlotCar);
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
                        "Car",
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
