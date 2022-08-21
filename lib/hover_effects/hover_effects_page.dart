import 'package:flutter/material.dart';
import 'package:flutter_samples/hover_effects/on_hover_button.dart';
import 'package:flutter_samples/hover_effects/on_hover_text.dart';

class HoverEffectsPage extends StatelessWidget {
  const HoverEffectsPage({Key? key}) : super(key: key);

  static const _texts = [
    'Milk',
    'Bread',
    'Onions',
    'Eggs',
    'Tomatoes',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hover Effects'),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OnHoverButton(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: Colors.blue,
                    width: 4,
                  ),
                  shape: StadiumBorder(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 16,
                  ),
                ),
                onPressed: () {},
                child: Text(
                  'Join Flutter',
                  style: TextStyle(
                    fontSize: 32,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            ListView.separated(
              shrinkWrap: true,
              padding: const EdgeInsets.all(16),
              itemCount: _texts.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final text = _texts[index];
                return Center(
                  child: OnHoverText(
                    builder: (isHovered) {
                      final color = isHovered ? Colors.orange : Colors.white;
                      return Container(
                        width: 160,
                        child: Text(
                          text,
                          style: TextStyle(
                            fontSize: 32,
                            color: color,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
