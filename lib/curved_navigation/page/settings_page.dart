import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown,
      body: Center(
        child: Text(
          'Settings',
          style: TextStyle(
            fontSize: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
