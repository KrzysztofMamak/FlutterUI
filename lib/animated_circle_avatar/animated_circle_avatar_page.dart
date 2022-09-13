import 'package:flutter/material.dart';
import 'package:flutter_samples/animated_circle_avatar/animated_circle_avatar.dart';

class AnimatedCircleAvatarPage extends StatelessWidget {
  const AnimatedCircleAvatarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated Circle Avatar'),
        centerTitle: true,
      ),
      body: const Center(
        child: AnimatedCircleAvatar(
          child: Icon(Icons.save),
        ),
      ),
    );
  }
}
