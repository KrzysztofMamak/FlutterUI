import 'dart:math' as math;

import 'package:flutter/material.dart';

class AnimatedCircleAvatar extends StatefulWidget {
  const AnimatedCircleAvatar({
    required this.child,
    this.innerColor = Colors.deepOrange,
    this.outerColor = Colors.deepOrange,
    this.innerAnimation = Curves.linear,
    this.outerAnimation = Curves.linear,
    this.size = 200,
    this.innerIconSize = 3,
    this.outerIconSize = 3,
    this.innerAnimationSeconds = 30,
    this.outerAnimationSeconds = 30,
    this.reverse = true,
  });

  final Color innerColor;
  final Color outerColor;
  final Curve innerAnimation;
  final Curve outerAnimation;
  final double innerIconSize;
  final double size;
  final double outerIconSize;
  final int innerAnimationSeconds;
  final int outerAnimationSeconds;
  final Widget child;
  final bool reverse;

  @override
  _AnimatedCircleAvatarState createState() => _AnimatedCircleAvatarState();
}

class _AnimatedCircleAvatarState extends State<AnimatedCircleAvatar>
    with TickerProviderStateMixin {
  late final Animation<double> _animation1;
  late final Animation<double> _animation2;
  late final AnimationController _controller2;
  late final AnimationController _controller1;

  void _initAnimations() {
    _controller1 = AnimationController(
      duration: Duration(seconds: widget.innerAnimationSeconds),
      vsync: this,
    );

    _controller2 = AnimationController(
      duration: Duration(seconds: widget.outerAnimationSeconds),
      vsync: this,
    );

    _animation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller1,
        curve: Interval(
          0.0,
          1.0,
          curve: widget.innerAnimation,
        ),
      ),
    );

    final secondAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller2,
        curve: Interval(
          0.0,
          1.0,
          curve: widget.outerAnimation,
        ),
      ),
    );

    widget.reverse
        ? _animation2 = ReverseAnimation(secondAnimation)
        : _animation2 = secondAnimation;

    _controller2.repeat();
    _controller1.repeat();
  }

  @override
  void initState() {
    super.initState();
    _initAnimations();
  }

  @override
  void dispose() {
    _controller2.dispose();
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.center,
      children: [
        RotationTransition(
          turns: _animation1,
          child: CustomPaint(
            painter: Arc1Painter(
              color: widget.innerColor,
              iconSize: widget.outerIconSize,
            ),
            child: Container(
              width: 0.85 * widget.size,
              height: 0.85 * widget.size,
            ),
          ),
        ),
        RotationTransition(
          turns: _animation2,
          child: CustomPaint(
            painter: Arc2Painter(
              color: widget.outerColor,
              iconSize: widget.innerIconSize,
            ),
            child: Container(
              width: widget.size,
              height: widget.size,
            ),
          ),
        ),
        Container(
          width: widget.size * 0.7,
          height: widget.size * 0.7,
          child: widget.child,
        )
      ],
    );
  }
}

class Arc2Painter extends CustomPainter {
  Arc2Painter({
    required this.color,
    this.iconSize = 3,
  });

  final Color color;
  final double iconSize;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height);

    canvas.drawArc(rect, 0.0, 0.67 * math.pi, false, p);
    canvas.drawArc(rect, 0.74 * math.pi, 0.65 * math.pi, false, p);
    canvas.drawArc(rect, 1.46 * math.pi, 0.47 * math.pi, false, p);

    canvas.drawRect(
      Rect.fromLTWH(
        size.width * 0.2 - iconSize,
        size.width * 0.9 - iconSize,
        iconSize * 2,
        iconSize * 2,
      ),
      p,
    );

    final centerX = size.width * 0.385;
    final centerY = size.width * 0.015;
    final lineLength = iconSize / 2;
    canvas.drawLine(
      Offset(
        centerX - lineLength,
        centerY + lineLength,
      ),
      Offset(
        centerX + lineLength,
        centerY - lineLength,
      ),
      p,
    );
    canvas.drawLine(
      Offset(
        centerX + lineLength,
        centerY + lineLength,
      ),
      Offset(
        centerX - lineLength,
        centerY - lineLength,
      ),
      p,
    );

    canvas.drawCircle(
      Offset(
        centerX,
        centerY,
      ),
      iconSize + 1,
      p,
    );

    canvas.drawOval(
      Rect.fromLTWH(
        size.width - iconSize * 1.5,
        size.width * 0.445 - iconSize,
        iconSize * 3,
        iconSize * 2,
      ),
      p,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class Arc1Painter extends CustomPainter {
  Arc1Painter({
    required this.color,
    this.iconSize = 3,
  });

  final Color color;
  final double iconSize;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint p = Paint()
      ..color = color
      ..strokeWidth = 1
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final Rect rect = Rect.fromLTWH(0, 0, size.width, size.height);

    canvas.drawArc(
      rect,
      0.15,
      0.9 * math.pi,
      false,
      p,
    );
    canvas.drawArc(
      rect,
      1.05 * math.pi,
      0.9 * math.pi,
      false,
      p,
    );

    final centerY = size.width / 2;
    canvas.drawLine(
      Offset(
        -iconSize,
        centerY - iconSize,
      ),
      Offset(
        iconSize,
        centerY + iconSize,
      ),
      p,
    );
    canvas.drawLine(
      Offset(
        iconSize,
        centerY - iconSize,
      ),
      Offset(
        -iconSize,
        centerY + iconSize,
      ),
      p,
    );

    canvas.drawCircle(
      Offset(
        size.width,
        centerY,
      ),
      iconSize,
      p,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
