import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/fitness_app/fitness_app_theme.dart';
import 'package:flutter_samples/apps_clone/fitness_app/my_diary/meals_list_view.dart';
import 'package:flutter_samples/apps_clone/fitness_app/my_diary/water_view.dart';
import 'package:flutter_samples/apps_clone/fitness_app/ui_view/body_measurement.dart';
import 'package:flutter_samples/apps_clone/fitness_app/ui_view/diet_view.dart';
import 'package:flutter_samples/apps_clone/fitness_app/ui_view/glass_view.dart';
import 'package:flutter_samples/apps_clone/fitness_app/ui_view/title_view.dart';

class MyDiaryScreen extends StatefulWidget {
  const MyDiaryScreen({
    Key? key,
    required this.animationController,
  }) : super(key: key);

  final AnimationController animationController;
  @override
  _MyDiaryScreenState createState() => _MyDiaryScreenState();
}

class _MyDiaryScreenState extends State<MyDiaryScreen>
    with TickerProviderStateMixin {
  late final Animation<double> _topBarAnimation;
  List<Widget> _listViews = <Widget>[];
  final ScrollController _scrollController = ScrollController();
  double _topBarOpacity = 0.0;

  @override
  void initState() {
    _topBarAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.animationController,
        curve: Interval(0, 0.5, curve: Curves.fastOutSlowIn),
      ),
    );
    addAllListData();

    _scrollController.addListener(() {
      if (_scrollController.offset >= 24) {
        if (_topBarOpacity != 1.0) {
          setState(() => _topBarOpacity = 1.0);
        }
      } else if (_scrollController.offset <= 24 &&
          _scrollController.offset >= 0) {
        if (_topBarOpacity != _scrollController.offset / 24) {
          setState(() => _topBarOpacity = _scrollController.offset / 24);
        }
      } else if (_scrollController.offset <= 0) {
        if (_topBarOpacity != 0.0) {
          setState(() => _topBarOpacity = 0.0);
        }
      }
    });
    super.initState();
  }

  void addAllListData() {
    const int count = 9;

    _listViews.add(
      TitleView(
        titleTxt: 'Mediterranean diet',
        subTxt: 'Details',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 0,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );
    _listViews.add(
      DietView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 1,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );
    _listViews.add(
      TitleView(
        titleTxt: 'Meals today',
        subTxt: 'Customize',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 2,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    _listViews.add(
      MealsListView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 3,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        mainScreenAnimationController: widget.animationController,
      ),
    );

    _listViews.add(
      TitleView(
        titleTxt: 'Body measurement',
        subTxt: 'Today',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 4,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    _listViews.add(
      BodyMeasurementView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 5,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );
    _listViews.add(
      TitleView(
        titleTxt: 'Water',
        subTxt: 'Aqua SmartBottle',
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 6,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );

    _listViews.add(
      WaterView(
        mainScreenAnimation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 7,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        mainScreenAnimationController: widget.animationController,
      ),
    );
    _listViews.add(
      GlassView(
        animation: Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: widget.animationController,
            curve: Interval(
              (1 / count) * 8,
              1.0,
              curve: Curves.fastOutSlowIn,
            ),
          ),
        ),
        animationController: widget.animationController,
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            getMainListViewUI(),
            getAppBarUI(),
            SizedBox(height: MediaQuery.of(context).padding.bottom)
          ],
        ),
      ),
    );
  }

  Widget getMainListViewUI() {
    return FutureBuilder<bool>(
      future: getData(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox();
        } else {
          return ListView.builder(
            controller: _scrollController,
            padding: EdgeInsets.only(
              top: AppBar().preferredSize.height +
                  MediaQuery.of(context).padding.top +
                  24,
              bottom: 62 + MediaQuery.of(context).padding.bottom,
            ),
            itemCount: _listViews.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              widget.animationController.forward();
              return _listViews[index];
            },
          );
        }
      },
    );
  }

  Widget getAppBarUI() {
    return Column(
      children: <Widget>[
        AnimatedBuilder(
          animation: widget.animationController,
          builder: (context, child) {
            return FadeTransition(
              opacity: _topBarAnimation,
              child: Transform(
                transform: Matrix4.translationValues(
                  0.0,
                  30 * (1.0 - _topBarAnimation.value),
                  0.0,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: FitnessAppTheme.white.withOpacity(_topBarOpacity),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(32.0),
                    ),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: FitnessAppTheme.grey
                            .withOpacity(0.4 * _topBarOpacity),
                        offset: const Offset(1.1, 1.1),
                        blurRadius: 10.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: MediaQuery.of(context).padding.top),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0 - 8.0 * _topBarOpacity,
                            bottom: 12.0 - 8.0 * _topBarOpacity),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'My Diary',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontFamily: FitnessAppTheme.fontName,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 22.0 + 6.0 - 6.0 * _topBarOpacity,
                                    letterSpacing: 1.2,
                                    color: FitnessAppTheme.darkerText,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 38.0,
                              width: 38.0,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_left,
                                    color: FitnessAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 8.0),
                                    child: Icon(
                                      Icons.calendar_today,
                                      color: FitnessAppTheme.grey,
                                      size: 18.0,
                                    ),
                                  ),
                                  Text(
                                    '15 May',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                      fontFamily: FitnessAppTheme.fontName,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 18.0,
                                      letterSpacing: -0.2,
                                      color: FitnessAppTheme.darkerText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 38.0,
                              width: 38.0,
                              child: InkWell(
                                highlightColor: Colors.transparent,
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(32.0),
                                ),
                                onTap: () {},
                                child: Center(
                                  child: Icon(
                                    Icons.keyboard_arrow_right,
                                    color: FitnessAppTheme.grey,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        )
      ],
    );
  }
}
