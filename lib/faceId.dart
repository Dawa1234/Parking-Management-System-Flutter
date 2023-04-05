import 'package:epark/services/services.dart';
import 'package:flutter/material.dart';

class FaceIdScreen extends StatefulWidget {
  const FaceIdScreen({Key? key}) : super(key: key);

  @override
  State<FaceIdScreen> createState() => _FaceIdScreenState();
}

class _FaceIdScreenState extends State<FaceIdScreen> {
  bool authenticate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () async {
                final authenticated = await LocalAuth.authenticate();
                setState(() {
                  authenticate = authenticated;
                });
              },
              child: const Text("Authentication")),
          authenticate ? const Text("You are authenticated") : const Text("")
        ],
      )),
    );
  }
}
