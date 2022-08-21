import 'package:flutter/material.dart';

class CustomPageRoute extends PageRouteBuilder {
  CustomPageRoute({
    required this.child,
    this.direction = AxisDirection.right,
  }) : super(
          transitionDuration: const Duration(seconds: 1),
          reverseTransitionDuration: const Duration(seconds: 1),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );

  final Widget child;
  final AxisDirection direction;

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation, Widget child) =>
      SlideTransition(
        position: Tween<Offset>(
          begin: _getBeginOffset(),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );

  Offset _getBeginOffset() {
    switch (direction) {
      case AxisDirection.up:
        return Offset(0, 1);
      case AxisDirection.down:
        return Offset(0, -1);
      case AxisDirection.right:
        return Offset(-1, 0);
      case AxisDirection.left:
        return Offset(1, 0);
      default:
        return Offset.zero;
    }
  }
}
