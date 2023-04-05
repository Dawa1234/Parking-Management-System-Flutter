import 'package:epark/models/parkingSlot.dart';
import 'package:epark/theme/themeData.dart';
import 'package:flutter/material.dart';

class Information {
  Color color;
  String info;

  Information(this.color, this.info);
}

Widget slots(context, ParkingSlot data, List<String> selectedSlots) {
  return Container(
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: data.occupied // If booked
            ? Colors.red
            : data.booked // If booked
                ? Colors.yellow
                : selectedSlots.contains(data.parkingId) // if selected by user
                    ? Colors.blue
                    : Colors.green, // else empty slot
        borderRadius: BorderRadius.circular(10)),
    width: 40,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(data.column),
        // to show the direction of parking car.
        /*
        name of a row is 'R-1'.
        for e.g : data.row = 'R-1'
        split by '-' get index [1] then int.parse
        if odd upside direction 
        if even downside direction 
        */
        int.parse(data.row.split('-')[1]) % 2 == 1
            ? const Icon(
                Icons.keyboard_arrow_up,
                size: 20,
              )
            : const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
              )
      ],
    ),
  );
}

// Name of rows
Widget rowName(context, List<List<ParkingSlot>> allRows, index) {
  return Container(
    width: 30,
    height: double.infinity,
    alignment: Alignment.center,
    color: DARK_GREY_COLOR,
    child: Text(
      allRows[index][0].row,
      style: const TextStyle(color: Colors.white),
    ),
  );
}
