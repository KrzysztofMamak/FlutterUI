import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/fitness_app/fitness_app_theme.dart';
import 'package:flutter_samples/apps_clone/fitness_app/models/tab_icon_data.dart';
import 'package:flutter_samples/apps_clone/fitness_app/my_diary/my_diary_screen.dart';
import 'package:flutter_samples/apps_clone/fitness_app/navigation/bottom_navigation_view.dart';
import 'package:flutter_samples/apps_clone/fitness_app/training/training_screen.dart';

class FitnessAppPage extends StatefulWidget {
  @override
  _FitnessAppPageState createState() => _FitnessAppPageState();
}

class _FitnessAppPageState extends State<FitnessAppPage>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;

  List<TabIconData> tabIconsList = TabIconData.tabIconsList;

  Widget tabBody = Container(
    color: FitnessAppTheme.background,
  );

  @override
  void initState() {
    tabIconsList.forEach((TabIconData tab) {
      tab.isSelected = false;
    });
    tabIconsList[0].isSelected = true;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    tabBody = MyDiaryScreen(animationController: _animationController);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<bool>(
          future: getData(),
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (!snapshot.hasData) {
              return const SizedBox();
            } else {
              return Stack(
                children: <Widget>[
                  tabBody,
                  bottomBar(),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  Widget bottomBar() {
    return Column(
      children: <Widget>[
        const Expanded(
          child: SizedBox(),
        ),
        BottomBarView(
          tabIconsList: tabIconsList,
          addClick: () {},
          changeIndex: (int index) {
            if (index == 0 || index == 2) {
              _animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      MyDiaryScreen(animationController: _animationController);
                });
              });
            } else if (index == 1 || index == 3) {
              _animationController.reverse().then<dynamic>((data) {
                if (!mounted) {
                  return;
                }
                setState(() {
                  tabBody =
                      TrainingScreen(animationController: _animationController);
                });
              });
            }
          },
        ),
      ],
    );
  }
}
