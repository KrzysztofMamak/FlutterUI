import 'package:flutter/foundation.dart' show immutable;

@immutable
class Item {
  const Item({
    required this.title,
    required this.urlImage,
  });

  final String title;
  final String urlImage;
}
