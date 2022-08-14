import 'package:flutter/material.dart';
import 'package:flutter_samples/amazing_hero_animations/item.dart';
import 'package:flutter_samples/amazing_hero_animations/second_screen.dart';

class FirstScreen extends StatelessWidget {
  FirstScreen({
    Key? key,
    required this.item,
  }) : super(key: key);

  final Item item;

  Widget _buildImage() {
    return Image.network(
      item.urlImage,
      fit: BoxFit.cover,
      width: 240,
      height: 240,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hero Animations'),
      ),
      body: Center(
        child: Hero(
          transitionOnUserGestures: true,
          tag: item,
          child: _buildImage(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => SecondScreen(item: item),
            ),
          );
        },
        child: Icon(Icons.navigate_next, size: 48),
      ),
    );
  }
}
