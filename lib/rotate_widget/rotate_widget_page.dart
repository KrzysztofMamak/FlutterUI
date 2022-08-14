import 'dart:math' as math;

import 'package:flutter/material.dart';

class RotateWidgetPage extends StatefulWidget {
  const RotateWidgetPage({Key? key}) : super(key: key);

  @override
  _RotateWidgetPageState createState() => _RotateWidgetPageState();
}

class _RotateWidgetPageState extends State<RotateWidgetPage>
    with SingleTickerProviderStateMixin {
  late Animation<double> _animation;
  late final AnimationController _animationController;
  double _angle = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _setRotation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _setRotation() {
    final additionalAngle = math.pi / 2;
    _animation = Tween<double>(
      begin: _angle,
      end: _angle + additionalAngle,
    ).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotate Widget'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Transform.rotate(
                  angle: _animation.value,
                  child: child,
                );
              },
              child: Image.network(
                'https://picsum.photos/250/250',
                fit: BoxFit.cover,
                height: 250,
                width: 250,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_animationController.isAnimating) {
                  return;
                }
                _animationController.forward(from: 0);
                _angle += (math.pi / 2);
                _setRotation();
              },
              child: const Text('Rotate'),
            ),
          ],
        ),
      ),
    );
  }
}
