import 'package:epark/api/apiUrl.dart';
import 'package:epark/measure/measure.dart';
import 'package:epark/models/user.dart';
import 'package:epark/screens/wear_os/wearOs_cancelslots/chooseCategory.dart';
import 'package:epark/screens/wear_os/wear_login.dart';
import 'package:epark/screens/wear_os/wear_profile.dart';
import 'package:epark/services/services.dart';
import 'package:epark/theme/themeData.dart';
import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

class WearOsDashboardScreen extends StatelessWidget {
  const WearOsDashboardScreen({Key? key}) : super(key: key);

  static const route = "/wearOsdashboardScreen";
  final style = const TextStyle(
      letterSpacing: 1,
      fontSize: 18,
      color: DARK_GREY_COLOR,
      fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return Scaffold(
              appBar: AppBar(
                toolbarHeight: 35,
                title: const Text(
                  "Home",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                centerTitle: true,
              ),
              body: SizedBox(
                width: phoneWidth(context),
                height: phoneHeight(context),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        child: Wrap(children: const [
                          Text("Profile"),
                          Icon(
                            Icons.arrow_right,
                          )
                        ]),
                        onPressed: () {
                          Navigator.pushNamed(context, WearOsUserProfile.route);
                        },
                      ),
                      ElevatedButton(
                        child: Wrap(children: const [
                          Text("Booked Slots"),
                          Icon(
                            Icons.arrow_right,
                          )
                        ]),
                        onPressed: () {
                          Navigator.pushNamed(
                              context, WearOsVehicleCategoryScreen.route);
                        },
                      ),
                      ElevatedButton(
                        child: Wrap(children: const [
                          Text("Log out"),
                          Icon(
                            Icons.logout,
                          )
                        ]),
                        onPressed: () {
                          logOut().whenComplete(() {
                            Navigator.pushReplacementNamed(
                                context, WearLoginPageScreen.route);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
// ---------------------------- Drawer -------------------------------------------------
              // drawer: const Text("asd")
            );
          },
        );
      },
    );
  }
}
// ---------------------------- Drawer -------------------------------------------------

