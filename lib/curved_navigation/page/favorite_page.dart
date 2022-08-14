import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: Center(
        child: Text(
          'Favorite',
          style: TextStyle(
            fontSize: 60,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
