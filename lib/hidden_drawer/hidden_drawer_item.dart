import 'package:flutter/material.dart';

@immutable
class HiddenDrawerItem {
  const HiddenDrawerItem({
    required this.title,
    required this.icon,
  });

  final String title;
  final IconData icon;
}
