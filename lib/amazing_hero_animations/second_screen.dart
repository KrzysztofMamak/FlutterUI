import 'package:flutter/material.dart';
import 'package:flutter_samples/amazing_hero_animations/item.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  Widget _buildImage() {
    return AspectRatio(
      aspectRatio: 1,
      child: Image.network(
        item.urlImage,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Screen'),
      ),
      body: Hero(
        transitionOnUserGestures: true,
        tag: item,
        child: _buildImage(),
      ),
    );
  }
}
