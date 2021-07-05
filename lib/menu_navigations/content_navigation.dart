import 'package:flutter/material.dart';

class ContentNavigation extends StatelessWidget {
  final Color color;

  const ContentNavigation({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 2 / 3,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 15.0,
      padding: const EdgeInsets.all(15.0),
      children: <Widget>[
        ContentItem(color: color),
        ContentItem(color: color),
        ContentItem(color: color),
        ContentItem(color: color),
      ],
    );
  }
}

class ContentItem extends StatelessWidget {
  final Color color;

  const ContentItem({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withOpacity(0.5),
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(height: 7.0, color: color.withOpacity(0.6)),
            const SizedBox(height: 5.0),
            Container(
              height: 7.0,
              margin: EdgeInsets.only(right: 10.0),
              color: color.withOpacity(0.6),
            ),
            const SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }
}
