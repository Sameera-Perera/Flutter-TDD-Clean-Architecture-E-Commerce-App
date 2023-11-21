import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  // ignore: use_super_parameters
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
    );
  }
}
