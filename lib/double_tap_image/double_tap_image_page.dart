import 'package:flutter/material.dart';

class DoubleTapImagePage extends StatefulWidget {
  const DoubleTapImagePage({Key? key}) : super(key: key);

  @override
  _DoubleTapImagePageState createState() => _DoubleTapImagePageState();
}

class _DoubleTapImagePageState extends State<DoubleTapImagePage>
    with SingleTickerProviderStateMixin {
  late final TransformationController _transformationController;
  TapDownDetails? _tapDownDetails;
  late final AnimationController _animationController;
  Animation<Matrix4>? _animation;

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener(() {
      _transformationController.value = _animation!.value;
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(24),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    return GestureDetector(
      onDoubleTapDown: (details) {
        _tapDownDetails = details;
      },
      onDoubleTap: () {
        final position = _tapDownDetails!.localPosition;
        final double scale = 3;
        final x = -position.dx * (scale - 1);
        final y = -position.dy * (scale - 1);
        final zoomed = Matrix4.identity()
          ..translate(x, y)
          ..scale(scale);
        final end = _transformationController.value.isIdentity()
            ? zoomed
            : Matrix4.identity();
        _animation = Matrix4Tween(
          begin: _transformationController.value,
          end: end,
        ).animate(
          CurveTween(curve: Curves.easeOut).animate(_animationController),
        );

        _animationController.forward(from: 0);
      },
      child: InteractiveViewer(
        transformationController: _transformationController,
        clipBehavior: Clip.none,
        panEnabled: false,
        scaleEnabled: false,
        child: AspectRatio(
          aspectRatio: 1,
          child: Image.network(
            'https://picsum.photos/300/800',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
