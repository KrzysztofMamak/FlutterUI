import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.urlImage,
    required this.subtitle,
    required this.color,
  }) : super(key: key);

  final String title;
  final String description;
  final String urlImage;
  final String subtitle;
  final Color color;

  Widget _buildImage() {
    return Image.asset(
      urlImage,
      width: double.infinity,
      fit: BoxFit.cover,
    );
  }

  Widget _buildText() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: color,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            description,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      child: Card(
        clipBehavior: Clip.hardEdge,
        shape: StadiumBorder(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: _buildImage(),
            ),
            Expanded(
              child: _buildText(),
            ),
          ],
        ),
      ),
    );
  }
}
