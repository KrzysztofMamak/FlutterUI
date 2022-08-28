import 'dart:math' as math;

import 'package:flutter/material.dart';

// TODO -> add possibility to set circles amount

class CustomCircleProgressIndicator extends StatefulWidget {
  const CustomCircleProgressIndicator({
    Key? key,
    this.size = 200,
    this.center = true,
    this.color = Colors.green,
  }) : super(key: key);

  final double size;
  final bool center;
  final Color color;

  @override
  _CustomCircleProgressIndicatorState createState() =>
      _CustomCircleProgressIndicatorState();
}

class _CustomCircleProgressIndicatorState
    extends State<CustomCircleProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        6,
        (index) => Container(
          width: widget.size,
          height: widget.size,
          padding: EdgeInsets.all(index * (widget.size / 10)),
          child: AnimatedBuilder(
            animation: _animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _animationController.value * (index + 1).ceil() * 6.3,
                child: child,
              );
            },
            child: Shapes(
              index: index,
              color: widget.color,
              center: widget.center,
            ),
          ),
        ),
      ),
    );
  }
}

class Shapes extends StatefulWidget {
  Shapes({
    required this.index,
    required this.color,
    required this.center,
  });

  final int index;
  final bool center;
  final Color color;

  @override
  _ShapesState createState() => _ShapesState();
}

class _ShapesState extends State<Shapes> {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DrawShapes(
        index: widget.index,
        color: widget.color,
        center: widget.center,
      ),
    );
  }
}

class DrawShapes extends CustomPainter {
  DrawShapes({
    required this.index,
    required this.color,
    required this.center,
  });

  final Color color;
  final bool center;
  final int index;

  @override
  void paint(Canvas canvas, Size size) {
    Paint brush = new Paint()
      ..color = color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;

    var startArc = (20 * index * math.pi) / 180;
    var endArc = ((90) * math.pi) / 180;

    if (index == 0 && center) {
      brush.style = PaintingStyle.fill;
      canvas.drawCircle(Offset(size.height / 2, size.width / 2), 5, brush);
    } else {
      brush.style = PaintingStyle.stroke;
      canvas.drawArc(
        Rect.fromCenter(
          center: Offset(size.height / 2, size.width / 2),
          height: size.height,
          width: size.width,
        ),
        startArc,
        endArc,
        false,
        brush,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
