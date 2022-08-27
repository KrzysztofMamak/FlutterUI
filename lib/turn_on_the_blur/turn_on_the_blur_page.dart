import 'dart:ui';

import 'package:flutter/material.dart';

class TurnOnTheBlurPage extends StatefulWidget {
  @override
  _TurnOnTheBlurPageState createState() => _TurnOnTheBlurPageState();
}

class _TurnOnTheBlurPageState extends State<TurnOnTheBlurPage> {
  double _x = 0.0, _y = 0.0;
  double _radius = 60.0;
  bool _lightOn = false;
  double _sigma = 1;

  void _onPanUpdate(Offset offset) {
    setState(() {
      _lightOn = true;
      _x = offset.dx;
      _y = offset.dy;
    });
  }

  void _onPanEnd(_) => setState(() => _lightOn = false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Turn on the light'),
      ),
      body: GestureDetector(
        onPanStart: (val) => _onPanUpdate(val.localPosition),
        onPanUpdate: (val) => _onPanUpdate(val.localPosition),
        onPanEnd: _onPanEnd,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            SizedBox.expand(
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(
                  'assets/stickerbomb.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            if (_lightOn)
              ClipPath(
                clipper: LightClipper(_x, _y, _radius),
                // child: Container(color: Colors.red),
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: _sigma,
                    sigmaY: _sigma,
                  ),
                  child: SizedBox(),
                ),
              ),
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    color: Colors.red,
                    child: Slider(
                      value: _sigma,
                      onChanged: (val) => setState(() => _sigma = val),
                      min: 1,
                      max: 10,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    color: Colors.yellow,
                    child: Slider(
                      value: _radius,
                      onChanged: (val) => setState(() => _radius = val),
                      min: 10,
                      max: 100,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: const EdgeInsets.all(15.0),
                color: Colors.red,
                child: Text(
                  'Touch the screen to turn on the blur',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LightClipper extends CustomClipper<Path> {
  LightClipper(
    this.x,
    this.y,
    this.radius,
  );

  final double x;
  final double y;
  final double radius;

  @override
  Path getClip(Size size) {
    return Path()
      ..addOval(
        Rect.fromCircle(center: Offset(x, y), radius: radius),
      );
  }

  @override
  bool shouldReclip(LightClipper oldClipper) =>
      x != oldClipper.x || y != oldClipper.y;
}
