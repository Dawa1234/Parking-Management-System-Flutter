import "package:epark/api/apiUrl.dart";
import "package:epark/models/parkingSlot.dart";
import "package:epark/models/user.dart";
import "package:epark/providers/userProvider.dart";
import "package:epark/repository/userRepo.dart";
import "package:epark/screens/wear_os/wearOs_cancelslots/slots.dart";
import "package:epark/theme/themeData.dart";
import "package:flutter/material.dart";
import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:wear/wear.dart";

class WearOsVehicleCategoryScreen extends StatelessWidget {
  final style = const TextStyle(fontSize: 10);
  const WearOsVehicleCategoryScreen({Key? key}) : super(key: key);
  static const route = "/wearOsvehicleCategoryScreen";

  @override
  Widget build(BuildContext context) {
    return WatchShape(builder: (context, shape, child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Choose Catgory", style: style),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(10),
            child: GridView.count(
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: const [
                _BikeSlots(),
                _CarSlots(),
              ],
            ),
          ),
        );
      });
    });
  }
}

// Bike
class _BikeSlots extends ConsumerWidget {
  const _BikeSlots({Key? key}) : super(key: key);
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(UserProvider.userProvider);
    return Container(
      decoration: homeBoxDecoration,
      child: FutureBuilder(
        future: UserRepositoryImpl().getSlotByBike(user.user_id!),
        builder: (context, AsyncSnapshot<List<ParkingSlot>> snapshot) {
          // On progress/waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(25),
              child: CircularProgressIndicator(),
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
                  Navigator.pushNamed(context, WearOsCancelSlotScreen.route,
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
                        size: 20,
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
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(UserProvider.userProvider);
    return Container(
      decoration: homeBoxDecoration,
      child: FutureBuilder(
        future: UserRepositoryImpl().getSlotByCar(user.user_id!),
        builder: (context, AsyncSnapshot<List<ParkingSlot>> snapshot) {
          // On progress/waiting
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(
              padding: EdgeInsets.all(25),
              child: CircularProgressIndicator(),
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
                  Navigator.pushNamed(context, WearOsCancelSlotScreen.route,
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
                        size: 20,
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
