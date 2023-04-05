import 'package:epark/repository/parkingslotRepo.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/parkingSlot.dart';

class CancelSlotScreen extends ConsumerStatefulWidget {
  const CancelSlotScreen({Key? key}) : super(key: key);
  static const route = "/cancelSlotScreen";

  @override
  ConsumerState<CancelSlotScreen> createState() => _CancelSlotScreenState();
}

class _CancelSlotScreenState extends ConsumerState<CancelSlotScreen> {
  _cancelBook(String slotId) async {
    int status = await ParkingSlotRepoImpl().cancleSlots(slotId);
    _checkStatus(status);
  }

  _checkStatus(int status) {
    if (status > 0) {
      successBar(context, "Slot Removed");
      return;
    }
    invalidBar(context, "No internet connection");
  }

  @override
  Widget build(BuildContext context) {
    List<ParkingSlot> lstofSlots =
        ModalRoute.of(context)!.settings.arguments as List<ParkingSlot>;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Booked slots"),
        centerTitle: true,
      ),
      body: lstofSlots.isEmpty
          ? const Center(
              child: Text("No slots booked!"),
            )
          : ListView.builder(
              itemCount: lstofSlots.length,
              itemBuilder: (context, index) {
                return Card(
                  // margin: const EdgeInsets.all(10),
                  child: ListTile(
                    leading: const Icon(Icons.stairs_outlined),
                    title: Text("Slot: ${lstofSlots[index].slot}"),
                    subtitle: Text(
                        "Floor: ${lstofSlots[index].floorId}    Category : ${lstofSlots[index].vehicleCategory}"),
                    trailing: InkWell(
                      onTap: () {
                        _cancelBook(lstofSlots[index].parkingId!);
                        setState(() {
                          lstofSlots.remove(lstofSlots[index]);
                        });
                      },
                      child: Wrap(children: const [
                        Text("Cancel Book"),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(size: 20, Icons.cancel_schedule_send_outlined)
                      ]),
                    ),
                  ),
                );
              }),
    );
  }
}
