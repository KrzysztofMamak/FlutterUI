import 'package:flutter/material.dart';
import 'package:flutter_samples/instagram_like_animation/heart_animation_widget.dart';

class InstagramLikeAnimationPage extends StatefulWidget {
  const InstagramLikeAnimationPage({Key? key}) : super(key: key);

  @override
  _InstagramLikeAnimationPageState createState() =>
      _InstagramLikeAnimationPageState();
}

class _InstagramLikeAnimationPageState
    extends State<InstagramLikeAnimationPage> {
  bool _isLiked = false;
  bool _isHeartAnimating = false;

  Widget _buildImage() {
    return GestureDetector(
      onDoubleTap: () {
        setState(() {
          _isHeartAnimating = true;
          _isLiked = true;
        });
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  'https://picsum.photos/300/800',
                  fit: BoxFit.cover,
                ),
              ),
              Opacity(
                opacity: _isHeartAnimating ? 1 : 0,
                child: HeartAnimationWidget(
                  isAnimating: _isHeartAnimating,
                  onEnd: () {
                    setState(() {
                      _isHeartAnimating = false;
                    });
                  },
                  // duration: const Duration(milliseconds: 700),
                  child: Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 100,
                  ),
                ),
              ),
            ],
          ),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildActions() {
    final icon = _isLiked ? Icons.favorite : Icons.favorite_outline;
    final color = _isLiked ? Colors.red : Colors.white;

    return Container(
      padding: const EdgeInsets.all(4),
      child: Row(
        children: [
          HeartAnimationWidget(
            isAnimating: _isLiked,
            alwaysAnimate: true,
            child: IconButton(
              onPressed: () {
                setState(() {
                  _isLiked = !_isLiked;
                });
              },
              icon: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Instagram Like Animation'),
      ),
      backgroundColor: Colors.black,
      body: _buildImage(),
    );
  }
}
