import 'package:flutter/material.dart';
import 'package:sprung/sprung.dart';

class OnHoverText extends StatefulWidget {
  const OnHoverText({
    Key? key,
    required this.builder,
  }) : super(key: key);

  final Widget Function(bool isHovered) builder;

  @override
  _OnHoverTextState createState() => _OnHoverTextState();
}

class _OnHoverTextState extends State<OnHoverText> {
  bool _isHovered = false;

  void _onHoverChanged(bool hovering) {
    setState(() {
      _isHovered = hovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    final hoveredTransform = Matrix4.identity()
      ..translate(8, 0, 0)
      ..scale(1.2);
    final transform = _isHovered ? hoveredTransform : Matrix4.identity();
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (event) => _onHoverChanged(true),
      onExit: (event) => _onHoverChanged(false),
      child: AnimatedContainer(
        curve: Sprung.overDamped,
        duration: const Duration(milliseconds: 300),
        transform: transform,
        child: widget.builder(_isHovered),
      ),
    );
  }
}
