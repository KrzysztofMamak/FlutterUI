import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'Home',
          style: TextStyle(
            fontSize: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
