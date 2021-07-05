import 'package:flutter/material.dart';

class TurnOnTheLightPage extends StatefulWidget {
  @override
  _TurnOnTheLightPageState createState() => _TurnOnTheLightPageState();
}

class _TurnOnTheLightPageState extends State<TurnOnTheLightPage> {
  double _x = 0.0, _y = 0.0;
  final _radius = 60.0;
  bool _lightOn = false;

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
            Center(
              child: FlutterLogo(
                size: MediaQuery.of(context).size.width,
                style: FlutterLogoStyle.horizontal,
              ),
            ),
            ClipPath(
              clipper: _lightOn ? LightClipper(_x, _y, _radius) : null,
              child: Container(color: Colors.black),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'Touch the screen to turn on the light',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white),
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
  final double x, y;
  final double radius;

  LightClipper(
    this.x,
    this.y,
    this.radius,
  );

  @override
  Path getClip(Size size) {
    final circlePath = Path()
      ..addOval(Rect.fromCircle(center: Offset(x, y), radius: radius));
    final fullPath = Path()
      ..addRect(Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    return Path.combine(PathOperation.reverseDifference, circlePath, fullPath);
  }

  @override
  bool shouldReclip(LightClipper oldClipper) =>
      x != oldClipper.x || y != oldClipper.y;
}
