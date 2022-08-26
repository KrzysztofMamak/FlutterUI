import 'package:flutter/foundation.dart';

@immutable
class ListItem {
  const ListItem({
    required this.title,
    required this.urlImage,
  });

  final String title;
  final String urlImage;
}
