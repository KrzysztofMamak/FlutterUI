import 'package:flutter/material.dart';

class DrawerMenuIcon extends StatelessWidget {
  const DrawerMenuIcon({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.menu),
      color: Colors.white,
      onPressed: onPressed,
    );
  }
}
