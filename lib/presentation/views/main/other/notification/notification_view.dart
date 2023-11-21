import 'package:flutter/material.dart';

class NotificationView extends StatelessWidget {
  // ignore: use_super_parameters
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
    );
  }
}
