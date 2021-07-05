import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/album_flow/album_image.dart';

const _itemCount = 20;
const _margin = 20.0;

class AlbumFlowDetailsPage extends StatelessWidget {
  final String imageUrl;
  final double angle;

  const AlbumFlowDetailsPage({
    Key? key,
    required this.imageUrl,
    required this.angle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final imageSize = size.width * 0.7;
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: <Widget>[
            Positioned.fill(
              left: _margin / 2.0,
              right: _margin / 2.0,
              top: imageSize - _margin,
              bottom: 0.0,
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25.0),
                    topRight: Radius.circular(25.0),
                  ),
                ),
                child: ListView.builder(
                  padding: const EdgeInsets.only(top: 40.0),
                  itemCount: _itemCount,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 15.0,
                        vertical: 5.0,
                      ),
                      child: ListTile(
                        title: Text(
                          'Random song ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                          ),
                        ),
                        trailing: Text('3:33'),
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              width: imageSize,
              height: imageSize,
              top: 50.0,
              left: (size.width - imageSize) / 2,
              child: AlbumImage(imageUrl: imageUrl, angle: angle),
            ),
            Positioned(
              left: _margin,
              top: _margin,
              child: BackButton(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
