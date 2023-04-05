import 'package:epark/repository/parkingslotRepo.dart';
import 'package:epark/validation/registerValidation.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

import '../../../models/parkingSlot.dart';

class WearOsCancelSlotScreen extends StatefulWidget {
  const WearOsCancelSlotScreen({Key? key}) : super(key: key);
  static const route = "/WearOscancelSlotScreen";

  @override
  State<WearOsCancelSlotScreen> createState() => _WearOsCancelSlotScreenState();
}

class _WearOsCancelSlotScreenState extends State<WearOsCancelSlotScreen> {
  final style = const TextStyle(fontSize: 10);
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
    return WatchShape(builder: (context, shape, child) {
      return AmbientMode(builder: (context, mode, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Booked slots", style: style),
            centerTitle: true,
          ),
          body: lstofSlots.isEmpty
              ? Center(
                  child: Text(
                    "No slots booked!",
                    style: style,
                  ),
                )
              : ListView.builder(
                  itemCount: lstofSlots.length,
                  itemBuilder: (context, index) {
                    return Card(
                      // margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text("Slot: ${lstofSlots[index].slot}",
                            style: style),
                        subtitle: Text(
                            "Category : ${lstofSlots[index].vehicleCategory}",
                            style: style),
                        trailing: InkWell(
                          onTap: () {
                            _cancelBook(lstofSlots[index].parkingId!);
                            setState(() {
                              lstofSlots.remove(lstofSlots[index]);
                            });
                          },
                          child: Wrap(children: const [
                            Text(
                              "Cancel Book",
                              style: TextStyle(fontSize: 10),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(size: 10, Icons.cancel_schedule_send_outlined)
                          ]),
                        ),
                      ),
                    );
                  }),
        );
      });
    });
  }
}
