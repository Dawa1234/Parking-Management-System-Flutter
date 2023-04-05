import 'package:flutter/material.dart';

class ParkStatusScreen extends StatelessWidget {
  const ParkStatusScreen({Key? key}) : super(key: key);
  static const route = "/parkStatus";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Park Status"),
      ),
    );
  }
}
