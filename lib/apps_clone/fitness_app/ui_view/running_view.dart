import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/fitness_app/fitness_app_theme.dart';

class RunningView extends StatelessWidget {
  final AnimationController animationController;
  final Animation<double> animation;

  const RunningView({
    Key? key,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: new Transform(
            transform: new Matrix4.translationValues(
              0.0,
              30 * (1.0 - animation.value),
              0.0,
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    left: 24.0,
                    right: 24.0,
                    top: 0.0,
                    bottom: 0.0,
                  ),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0, bottom: 16.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: FitnessAppTheme.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              bottomLeft: Radius.circular(8.0),
                              bottomRight: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: FitnessAppTheme.grey.withOpacity(0.4),
                                offset: Offset(1.1, 1.1),
                                blurRadius: 10.0,
                              ),
                            ],
                          ),
                          child: Stack(
                            alignment: Alignment.topLeft,
                            children: <Widget>[
                              ClipRRect(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                child: SizedBox(
                                  height: 74.0,
                                  child: AspectRatio(
                                    aspectRatio: 1.714,
                                    child: Image.asset(
                                      "assets/fitness_app/back.png",
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 100.0,
                                          right: 16.0,
                                          top: 16.0,
                                        ),
                                        child: Text(
                                          "You're doing great!",
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14.0,
                                            letterSpacing: 0.0,
                                            color:
                                                FitnessAppTheme.nearlyDarkBlue,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 100.0,
                                      bottom: 12.0,
                                      top: 4.0,
                                      right: 16.0,
                                    ),
                                    child: Text(
                                      "Keep it up\nand stick to your plan!",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                        letterSpacing: 0.0,
                                        color: FitnessAppTheme.grey
                                            .withOpacity(0.5),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: -16.0,
                        left: 0.0,
                        child: SizedBox(
                          width: 110.0,
                          height: 110.0,
                          child: Image.asset("assets/fitness_app/runner.png"),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
