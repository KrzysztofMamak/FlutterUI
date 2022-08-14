import 'package:flutter/material.dart';

class BackgroundImageWidget extends StatelessWidget {
  const BackgroundImageWidget({
    Key? key,
    required this.image,
    required this.child,
  }) : super(key: key);

  final ImageProvider image;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox.expand(
          child: Image(
            image: image,
            fit: BoxFit.cover,
          ),
        ),
        Center(
          child: child,
        ),
      ],
    );
  }
}
