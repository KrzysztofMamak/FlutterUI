import 'package:flutter/material.dart';
import 'package:flutter_samples/text_slide/background_image_widget.dart';
import 'package:marquee/marquee.dart';

class TextSlidePage extends StatelessWidget {
  const TextSlidePage({Key? key}) : super(key: key);

  Widget _buildAnimatedText(String text) {
    return Container(
      height: 80,
      color: Colors.red,
      margin: const EdgeInsets.all(24),
      child: Marquee(
        text: text,
        style: TextStyle(
          fontSize: 48,
          color: Colors.white,
        ),
        blankSpace: 90,
        velocity: 150,
        // pauseAfterRound: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundImageWidget(
      image: NetworkImage(
        'https://picsum.photos/400/800',
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Text Slide'),
        ),
        backgroundColor: Colors.transparent,
        body: Container(
          margin: const EdgeInsets.only(top: 50),
          // alignment: Alignment.center,
          child: _buildAnimatedText('This Text Is Animated'),
        ),
      ),
    );
  }
}
