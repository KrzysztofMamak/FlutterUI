import 'package:flutter/material.dart';
import 'package:flutter_samples/amazing_hero_animations/first_screen.dart';
import 'package:flutter_samples/amazing_hero_animations/item.dart';

class AmazingHeroAnimationsPage extends StatelessWidget {
  AmazingHeroAnimationsPage({Key? key}) : super(key: key);

  final _items = [
    Item(
      title: 'Item 1',
      urlImage: 'https://picsum.photos/398/400',
    ),
    Item(
      title: 'Item 2',
      urlImage: 'https://picsum.photos/399/400',
    ),
    Item(
      title: 'Item 3',
      urlImage: 'https://picsum.photos/400/400',
    ),
    Item(
      title: 'Item 4',
      urlImage: 'https://picsum.photos/401/400',
    ),
    Item(
      title: 'Item 5',
      urlImage: 'https://picsum.photos/402/400',
    ),
  ];

  Widget _buildImage(String urlImage) {
    return Image.network(
      urlImage,
      fit: BoxFit.cover,
      width: 100,
      height: 100,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amazing Hero Animations'),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          final item = _items[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FirstScreen(item: item),
                ),
              );
            },
            child: Row(
              children: [
                Hero(
                  transitionOnUserGestures: true,
                  tag: item,
                  child: _buildImage(item.urlImage),
                ),
                const SizedBox(width: 16),
                Text(
                  'Item ${index + 1}',
                  style: TextStyle(fontSize: 24),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
