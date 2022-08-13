import 'package:flutter/material.dart';
import 'package:flutter_samples/image_transformer/pinch_zoom_image.dart';

class ImageTransformerPage extends StatefulWidget {
  const ImageTransformerPage({Key? key}) : super(key: key);

  @override
  _ImageTransformerPageState createState() => _ImageTransformerPageState();
}

class _ImageTransformerPageState extends State<ImageTransformerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Transformer'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: PinchZoomImage(),
      ),
    );
  }
}
