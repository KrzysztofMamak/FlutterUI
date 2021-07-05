import 'package:flutter/material.dart';

class SliderView extends StatefulWidget {
  final Function(double) onChangedListValue;
  final double distValue;

  const SliderView({
    Key? key,
    required this.onChangedListValue,
    required this.distValue,
  }) : super(key: key);

  @override
  _SliderViewState createState() => _SliderViewState();
}

class _SliderViewState extends State<SliderView> {
  double distValue = 50.0;

  @override
  void initState() {
    distValue = widget.distValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class CustomThumbShape extends SliderComponentShape {
  static const double _thumbSize = 3.0;
  static const double _disabledThumbSize = 3.0;

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  double _convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    canvas.drawPath(
      Path()
        ..addOval(
          Rect.fromPoints(
            Offset(center.dx + 12, center.dy + 12),
            Offset(center.dx - 12, center.dy - 12),
          ),
        )
        ..fillType = PathFillType.evenOdd,
      Paint()
        ..color = Colors.black.withOpacity(0.5)
        ..maskFilter =
            MaskFilter.blur(BlurStyle.normal, _convertRadiusToSigma(8)),
    );
    final Paint cPaint = Paint();
    cPaint..color = Colors.white;
    cPaint..strokeWidth = 14 / 2;
    canvas.drawCircle(Offset(center.dx, center.dy), 12, cPaint);
    cPaint..color = colorTween.evaluate(enableAnimation)!;
    canvas.drawCircle(Offset(center.dx, center.dy), 10, cPaint);
  }
}
