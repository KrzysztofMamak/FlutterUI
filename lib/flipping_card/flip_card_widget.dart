import 'dart:math' as math;

import 'package:flutter/material.dart';

class FlipCardWidget extends StatefulWidget {
  const FlipCardWidget({
    Key? key,
    required this.front,
    required this.back,
  }) : super(key: key);

  final Image front;
  final Image back;

  @override
  _FlipCardWidgetState createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _animation;
  double _dragPosition = 0;
  bool _isFront = true;
  bool _isFrontStart = true;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 500),
    )..addListener(() {
      setState(() {
        _dragPosition = _animation.value;
        _setImageSide();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setImageSide() {
    if (_dragPosition <= 90 || _dragPosition >= 270) {
      _isFront = true;
    } else {
      _isFront = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final angle = _dragPosition / 180 * math.pi;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(angle);

    return GestureDetector(
      onHorizontalDragStart: (details) {
        _animationController.stop();
        _isFrontStart = _isFront;
      },
      onHorizontalDragUpdate: (details) {
        setState(() {
          _dragPosition -= details.delta.dx;
          _dragPosition %= 360;
          _setImageSide();
        });
      },
      onHorizontalDragEnd: (details) {
        final velocity = details.velocity.pixelsPerSecond.dx.abs();

        if (velocity >= 100) {
          _isFront = !_isFrontStart;
        }
        final end = _isFront ? (_dragPosition > 180 ? 360.0 : 0.0) : 180.0;
        _animation = Tween<double>(
          begin: _dragPosition,
          end: end,
        ).animate(_animationController);

        _animationController.forward(from: 0);
      },
      child: Transform(
        transform: transform,
        alignment: Alignment.center,
        child: _isFront
            ? widget.front
            : Transform(
          transform: Matrix4.identity()
            ..rotateX(math.pi),
          alignment: Alignment.center,
          child: widget.back,
        ),
      ),
    );
  }
}
