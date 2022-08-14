import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Text(
          'Profile',
          style: TextStyle(
            fontSize: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
