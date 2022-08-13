import 'dart:math' as math;

import 'package:flutter/material.dart';

const _kFabSize = 80.0;

class FabRangePage extends StatefulWidget {
  const FabRangePage({Key? key}) : super(key: key);

  @override
  _FabRangePageState createState() => _FabRangePageState();
}

class _FabRangePageState extends State<FabRangePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fab Range'),
      ),
      body: const CircularFab(),
    );
  }
}

class CircularFab extends StatefulWidget {
  const CircularFab({Key? key}) : super(key: key);

  @override
  _CircularFabState createState() => _CircularFabState();
}

class _CircularFabState extends State<CircularFab>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onPressed() {
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Flow(
      delegate: FlowMenuDelegate(
        controller: _controller,
      ),
      children: [
        Icons.mail,
        Icons.call,
        Icons.notifications,
        Icons.sms,
        Icons.menu,
      ].map(_buildFab).toList(),
    );
  }

  Widget _buildFab(IconData icon) {
    return SizedBox(
      width: _kFabSize,
      height: _kFabSize,
      child: FloatingActionButton(
        elevation: 0,
        splashColor: Colors.black,
        onPressed: _onPressed,
        child: Icon(
          icon,
          color: Colors.white,
          size: 45,
        ),
      ),
    );
  }
}

class FlowMenuDelegate extends FlowDelegate {
  const FlowMenuDelegate({
    required this.controller,
  }) : super(repaint: controller);

  final Animation<double> controller;

  @override
  void paintChildren(FlowPaintingContext context) {
    final n = context.childCount;
    for (var i = 0; i < n; i++) {
      final isLastItem = i == context.childCount - 1;
      final setValue = (value) => isLastItem ? 0.0 : value;

      final radius = 180 * controller.value;
      final theta = i * math.pi * 0.5 / (n - 2);

      final x = setValue(radius * math.cos(theta));
      final y = setValue(radius * math.sin(theta));
      context.paintChild(
        i,
        transform: Matrix4.identity()
          ..translate(x, y, 0)
          ..translate(_kFabSize / 2, _kFabSize / 2)
          ..rotateZ(isLastItem ? 0.0 : 180 * (1 - controller.value) * math.pi / 180)
          ..scale(isLastItem ? 1.0 : math.max(controller.value, 0.5))
          ..translate(-_kFabSize / 2, -_kFabSize / 2),
      );
    }
  }

  @override
  bool shouldRepaint(covariant FlowDelegate oldDelegate) {
    return true;
  }
}
