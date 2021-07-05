import 'package:flutter/material.dart';

class PhotoDetailsPage extends StatelessWidget {
  final String image;
  final String tag;

  const PhotoDetailsPage({
    Key? key,
    required this.image,
    required this.tag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: BackButton(color: Colors.white),
              ),
            ),
            Center(
              child: Hero(
                tag: tag,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
