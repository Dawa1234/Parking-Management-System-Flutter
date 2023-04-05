import 'package:epark/api/apiUrl.dart';
import 'package:epark/measure/measure.dart';
import 'package:epark/models/user.dart';
import 'package:epark/providers/userProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WearOsUserProfile extends ConsumerWidget {
  const WearOsUserProfile({Key? key}) : super(key: key);
  static const route = "/wearOsUserProfile";

  // Controllers
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    User user = ref.watch(UserProvider.userProvider);
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 35,
        title: const Text("Your detail"),
        centerTitle: true,
      ),
      body: SizedBox(
        width: phoneWidth(context),
        height: phoneHeight(context),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              gap10,
              Text("Fullname : ${user.fullname}"),
              Text("Username : ${user.username}"),
              Text("Email : ${user.email}"),
              Text("Contact : ${user.contact}"),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Go back"))
            ],
          ),
        ),
      ),
    );
  }
}
