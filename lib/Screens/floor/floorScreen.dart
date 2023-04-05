import 'package:epark/models/floor.dart';
import 'package:epark/models/parkingSlot.dart';
import 'package:epark/providers/parking_provider.dart';
import 'package:epark/screens/bookings/bookslots/slotScreen.dart';
import 'package:epark/theme/themeData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FloorScreen extends ConsumerWidget {
  const FloorScreen({Key? key}) : super(key: key);
  static const route = "/floorScreen";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Floor> floor =
        ModalRoute.of(context)!.settings.arguments as List<Floor>;
    return Scaffold(
        appBar: AppBar(
          title: const Text("Floors"),
          centerTitle: true,
        ),
        // Body
        body: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: floor.length,
            itemBuilder: (context, index) {
              // Main content
              return _Floors(
                floor: floor[index],
                totalParkingSlot: floor[index].parkingSlot!.length,
              );
            }));
  }
}

// Floor Tiles
class _Floors extends ConsumerWidget {
  Floor floor;
  int totalParkingSlot;
  _Floors({Key? key, required this.floor, required this.totalParkingSlot})
      : super(key: key);

  // Future<List<ParkingSlot>> _getAllParkingSlot(String floorId) async {
  //   return await ParkingSlotRepoImpl().getAllParkingSlot(floorId);
  // }
  Future<List<ParkingSlot>> data(WidgetRef ref, String floorId) async {
    return ref
        .watch(GetParkingSlotProvider.getParkingSlots.notifier)
        .getAllParkingSlot(floorId);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
        future: data(ref, floor.floorId!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Card(
                child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Center(child: CircularProgressIndicator()),
            ));
          } else if (snapshot.connectionState == ConnectionState.done ||
              snapshot.connectionState == ConnectionState.active) {
            List<ParkingSlot> parkingSlot = snapshot.data!;
            return Card(
              child: ListTile(
                iconColor: DARK_GREY_COLOR,
                // Leading Icons
                leading: const SizedBox(
                    height: double.infinity,
                    child: Icon(size: 35, Icons.stairs)),
                // Middle part
                title: Text("Floor: ${floor.floorNum}"),
                subtitle: Text("No. of parking slots : $totalParkingSlot"),
                // Last part
                trailing: InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BookSlotScreen(
                              parkingSlot: parkingSlot,
                            )));
                  },
                  child: Container(
                    padding: const EdgeInsets.only(top: 8),
                    height: 30,
                    child: Wrap(children: const [
                      Text("View spots"),
                      Icon(
                        Icons.arrow_right,
                        size: 20,
                      )
                    ]),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: Text("No data found"),
            );
          }
        });
  }
}
