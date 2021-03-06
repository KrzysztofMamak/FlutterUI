import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/animations/main_animations.dart';
import 'package:flutter_samples/appbar_sliverappbar/main_appbar_sliverappbar.dart';
import 'package:flutter_samples/apps_clone/main_apps_clone.dart';
import 'package:flutter_samples/collapsing_toolbar/main_collapsing_toolbar.dart';
import 'package:flutter_samples/communication_widgets/main_communication_widgets.dart';
import 'package:flutter_samples/hero_animations/main_hero_animations.dart';
import 'package:flutter_samples/menu_navigations/main_menu_navigations.dart';
import 'package:flutter_samples/persistent_tab_bar/main_persistent_tab_bar.dart';
import 'package:flutter_samples/screens/screens_page.dart';
import 'package:flutter_samples/scroll_controller/main_scroll_controller.dart';
import 'package:flutter_samples/size_and_position/main_size_and_position.dart';
import 'package:flutter_samples/split_image/main_split_image.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      primarySwatch: Colors.blueGrey,
    ),
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void _onButtonTap(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Samples'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: 'Persistent Tab Bar',
              onTap: () => _onButtonTap(MainPersistentTabBar()),
            ),
            MyMenuButton(
              title: 'Collapsing Toolbar',
              onTap: () => _onButtonTap(MainCollapsingToolbar()),
            ),
            MyMenuButton(
              title: 'Hero Animations',
              onTap: () => _onButtonTap(MainHeroAnimationsPage()),
            ),
            MyMenuButton(
              title: 'Size and Positions',
              onTap: () => _onButtonTap(MainSizeAndPosition()),
            ),
            MyMenuButton(
              title: 'ScrollController and ScrollNotification',
              onTap: () => _onButtonTap(MainScrollController()),
            ),
            MyMenuButton(
              title: 'Apps Clone',
              onTap: () => _onButtonTap(MainAppsClone()),
            ),
            MyMenuButton(
              title: 'Animations',
              onTap: () => _onButtonTap(MainAnimations()),
            ),
            MyMenuButton(
              title: 'Communication Widgets',
              onTap: () => _onButtonTap(MainCommunicationWidgets()),
            ),
            MyMenuButton(
              title: 'Split Image',
              onTap: () => _onButtonTap(MainSplitImage()),
            ),
            MyMenuButton(
              title: "Custom AppBar & SliverAppBar",
              onTap: () => _onButtonTap(MainAppBarSliverAppBar()),
            ),
            MyMenuButton(
              title: "Menu Navigations",
              onTap: () => _onButtonTap(MainMenuNavigations()),
            ),
            MyMenuButton(
              title: "Screens",
              onTap: () => _onButtonTap(ScreensPage()),
            ),
          ],
        ),
      ),
    );
  }
}

class MyMenuButton extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const MyMenuButton({
    Key? key,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: MaterialButton(
        height: 50.0,
        color: Theme.of(context).primaryColor,
        textColor: Colors.white,
        child: Text(title),
        onPressed: onTap,
      ),
    );
  }
}
