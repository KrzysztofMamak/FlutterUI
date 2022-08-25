import 'package:flutter/foundation.dart' show immutable;

@immutable
class Food {
  const Food({
    required this.urlImage,
    required this.title,
    required this.description,
  });

  final String urlImage;
  final String title;
  final String description;
}
