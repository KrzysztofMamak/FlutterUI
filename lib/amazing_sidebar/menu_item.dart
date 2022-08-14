import 'package:flutter/material.dart';

@immutable
class MenuItem {
  const MenuItem(
    this.title,
    this.icon,
  );

  final String title;
  final IconData icon;
}
