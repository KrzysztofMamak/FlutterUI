import 'dart:math' as math;

import 'package:flutter/material.dart';

class FlipCardController {
  _FlipCardWidgetState? _state;

  Future flipCard() async {
    _state?._flipCard();
  }
}

class FlipCardWidget extends StatefulWidget {
  const FlipCardWidget({
    Key? key,
    required this.controller,
    required this.front,
    required this.back,
  }) : super(key: key);

  final FlipCardController controller;
  final Image front;
  final Image back;

  @override
  _FlipCardWidgetState createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  bool _isFront = true;
  double _anglePlus = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(widget.front.image, context);
      precacheImage(widget.back.image, context);
    });
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    widget.controller._state = this;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future _flipCard() async {
    if (_controller.isAnimating) {
      return;
    }
    _isFront = !_isFront;
    await _controller.forward(from: 0).then((value) => _anglePlus = math.pi);
  }

  bool _isFrontImage(double angle) {
    final degrees90 = math.pi / 2;
    final degrees270 = 3 * math.pi / 2;
    return angle <= degrees90 || angle >= degrees270;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        var angle = _controller.value * -math.pi;
        if (_isFront) {
          angle += _anglePlus;
        }
        final transform = Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateX(angle);
        return Transform(
          transform: transform,
          alignment: Alignment.center,
          child: _isFrontImage(angle.abs())
              ? widget.front
              : Transform(
                  transform: Matrix4.identity()..rotateX(math.pi),
                  alignment: Alignment.center,
                  child: widget.back,
                ),
        );
      },
    );
  }
}
