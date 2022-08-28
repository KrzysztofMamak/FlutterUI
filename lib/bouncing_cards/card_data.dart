import 'package:flutter/material.dart';

@immutable
class CardData {
  const CardData({
    required this.title,
    required this.description,
    required this.imgUrl,
    required this.subtitle,
    required this.color,
  });

  final String title;
  final String description;
  final String imgUrl;
  final String subtitle;
  final Color color;
}
