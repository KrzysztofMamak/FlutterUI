import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/fitness_app/fitness_app_theme.dart';
import 'package:vector_math/vector_math.dart' as vector;

class WaveView extends StatefulWidget {
  final double percentageValue;

  const WaveView({
    Key? key,
    this.percentageValue = 100.0,
  }) : super(key: key);
  @override
  _WaveViewState createState() => _WaveViewState();
}

class _WaveViewState extends State<WaveView> with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late final AnimationController _waveAnimationController;
  Offset _bottleOffset1 = Offset(0, 0);
  List<Offset> _animList1 = [];
  Offset _bottleOffset2 = Offset(60, 0);
  List<Offset> _animList2 = [];

  @override
  void initState() {
    _animationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _waveAnimationController = AnimationController(
      duration: Duration(milliseconds: 2000),
      vsync: this,
    );
    _animationController
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _animationController.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _animationController.forward();
          }
        },
      );
    _waveAnimationController.addListener(() {
      _animList1.clear();
      for (int i = -2 - _bottleOffset1.dx.toInt(); i <= 60 + 2; i++) {
        _animList1.add(
          new Offset(
            i.toDouble() + _bottleOffset1.dx.toInt(),
            math.sin((_waveAnimationController.value * 360 - i) %
                        360 *
                        vector.degrees2Radians) *
                    4 +
                (((100 - widget.percentageValue) * 160 / 100)),
          ),
        );
      }
      _animList2.clear();
      for (int i = -2 - _bottleOffset2.dx.toInt(); i <= 60 + 2; i++) {
        _animList2.add(
          new Offset(
            i.toDouble() + _bottleOffset2.dx.toInt(),
            math.sin((_waveAnimationController.value * 360 - i) %
                        360 *
                        vector.degrees2Radians) *
                    4 +
                (((100 - widget.percentageValue) * 160 / 100)),
          ),
        );
      }
    });
    _waveAnimationController.repeat();
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _waveAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: new AnimatedBuilder(
        animation: new CurvedAnimation(
          parent: _animationController,
          curve: Curves.easeInOut,
        ),
        builder: (context, child) => new Stack(
          children: <Widget>[
            new ClipPath(
              child: new Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.5),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.0),
                    bottomLeft: Radius.circular(80.0),
                    bottomRight: Radius.circular(80.0),
                    topRight: Radius.circular(80.0),
                  ),
                  gradient: LinearGradient(
                    colors: [
                      FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                      FitnessAppTheme.nearlyDarkBlue.withOpacity(0.5)
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              clipper: new WaveClipper(_animationController.value, _animList1),
            ),
            new ClipPath(
              child: new Container(
                decoration: BoxDecoration(
                  color: FitnessAppTheme.nearlyDarkBlue,
                  gradient: LinearGradient(
                    colors: [
                      FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                      FitnessAppTheme.nearlyDarkBlue
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.0),
                    bottomLeft: Radius.circular(80.0),
                    bottomRight: Radius.circular(80.0),
                    topRight: Radius.circular(80.0),
                  ),
                ),
              ),
              clipper: new WaveClipper(_animationController.value, _animList2),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 48.0),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.percentageValue.round().toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w500,
                        fontSize: 24.0,
                        letterSpacing: 0.0,
                        color: FitnessAppTheme.white,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3.0),
                      child: Text(
                        '%',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.0,
                          letterSpacing: 0.0,
                          color: FitnessAppTheme.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              left: 6.0,
              bottom: 8.0,
              child: new ScaleTransition(
                alignment: Alignment.center,
                scale: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(0.0, 1.0, curve: Curves.fastOutSlowIn),
                  ),
                ),
                child: Container(
                  width: 2.0,
                  height: 2.0,
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 24.0,
              right: 0.0,
              bottom: 16.0,
              child: new ScaleTransition(
                alignment: Alignment.center,
                scale: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
                  ),
                ),
                child: Container(
                  width: 4.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0.0,
              right: 24.0,
              bottom: 32.0,
              child: new ScaleTransition(
                alignment: Alignment.center,
                scale: Tween(begin: 0.0, end: 1.0).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: Interval(0.6, 0.8, curve: Curves.fastOutSlowIn),
                  ),
                ),
                child: Container(
                  width: 3.0,
                  height: 3.0,
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0.0,
              right: 20.0,
              bottom: 0.0,
              child: new Transform(
                transform: new Matrix4.translationValues(
                  0.0,
                  16 * (1.0 - _animationController.value),
                  0.0,
                ),
                child: Container(
                  width: 4.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(
                      _animationController.status == AnimationStatus.reverse
                          ? 0.0
                          : 0.4,
                    ),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            Column(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset("assets/fitness_app/bottle.png"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  final double animation;

  List<Offset> waveList1 = [];

  WaveClipper(this.animation, this.waveList1);

  @override
  Path getClip(Size size) {
    Path path = new Path();

    path.addPolygon(waveList1, false);

    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      animation != oldClipper.animation;
}
