import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/fitness_app/fitness_app_theme.dart';
import 'package:flutter_samples/apps_clone/fitness_app/models/meals_list_data.dart';
import 'package:flutter_samples/apps_clone/hotel_booking/hex_color.dart';

class MealsListView extends StatefulWidget {
  const MealsListView({
    Key? key,
    required this.mainScreenAnimationController,
    required this.mainScreenAnimation,
  }) : super(key: key);

  final AnimationController mainScreenAnimationController;
  final Animation<double> mainScreenAnimation;

  @override
  _MealsListViewState createState() => _MealsListViewState();
}

class _MealsListViewState extends State<MealsListView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  List<MealsListData> _mealsListData = MealsListData.tabIconsList;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.mainScreenAnimationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: widget.mainScreenAnimation,
          child: Transform(
            transform: Matrix4.translationValues(
              0.0,
              30 * (1.0 - widget.mainScreenAnimation.value),
              0.0,
            ),
            child: Container(
              height: 216.0,
              width: double.infinity,
              child: ListView.builder(
                padding: const EdgeInsets.only(
                  top: 0.0,
                  bottom: 0.0,
                  right: 16.0,
                  left: 16.0,
                ),
                itemCount: _mealsListData.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  final int count =
                      _mealsListData.length > 10 ? 10 : _mealsListData.length;
                  final Animation<double> animation =
                      Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: Interval(
                        (1 / count) * index,
                        1.0,
                        curve: Curves.fastOutSlowIn,
                      ),
                    ),
                  );
                  _animationController.forward();

                  return MealsView(
                    mealsListData: _mealsListData[index],
                    animation: animation,
                    animationController: _animationController,
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class MealsView extends StatelessWidget {
  const MealsView({
    Key? key,
    required this.mealsListData,
    required this.animationController,
    required this.animation,
  }) : super(key: key);

  final MealsListData mealsListData;
  final AnimationController animationController;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
              100 * (1.0 - animation.value),
              0.0,
              0.0,
            ),
            child: SizedBox(
              width: 130.0,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 32.0,
                      left: 8.0,
                      right: 8.0,
                      bottom: 16.0,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: HexColor(mealsListData.endColor)
                                .withOpacity(0.6),
                            offset: const Offset(1.1, 4.0),
                            blurRadius: 8.0,
                          ),
                        ],
                        gradient: LinearGradient(
                          colors: <HexColor>[
                            HexColor(mealsListData.startColor),
                            HexColor(mealsListData.endColor),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8.0),
                          bottomLeft: Radius.circular(8.0),
                          topLeft: Radius.circular(8.0),
                          topRight: Radius.circular(54.0),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 54.0,
                          left: 16.0,
                          right: 16.0,
                          bottom: 8.0,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              mealsListData.titleTxt,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  top: 8.0,
                                  bottom: 8.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      mealsListData.meals.join('\n'),
                                      style: TextStyle(
                                        fontFamily: FitnessAppTheme.fontName,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 10.0,
                                        letterSpacing: 0.2,
                                        color: FitnessAppTheme.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            mealsListData.kacl != 0
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text(
                                        mealsListData.kacl.toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontFamily: FitnessAppTheme.fontName,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 24.0,
                                          letterSpacing: 0.2,
                                          color: FitnessAppTheme.white,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          left: 4.0,
                                          bottom: 3.0,
                                        ),
                                        child: Text(
                                          'kcal',
                                          style: TextStyle(
                                            fontFamily:
                                                FitnessAppTheme.fontName,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 10.0,
                                            letterSpacing: 0.2,
                                            color: FitnessAppTheme.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    decoration: BoxDecoration(
                                      color: FitnessAppTheme.nearlyWhite,
                                      shape: BoxShape.circle,
                                      boxShadow: <BoxShadow>[
                                        BoxShadow(
                                          color: FitnessAppTheme.nearlyBlack
                                              .withOpacity(0.4),
                                          offset: Offset(8.0, 8.0),
                                          blurRadius: 8.0,
                                        ),
                                      ],
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(6.0),
                                      child: Icon(
                                        Icons.add,
                                        color: HexColor(mealsListData.endColor),
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 0.0,
                    child: Container(
                      width: 84.0,
                      height: 84.0,
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0.0,
                    left: 8.0,
                    child: SizedBox(
                      width: 80.0,
                      height: 80.0,
                      child: Image.asset(mealsListData.imagePath),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
