import 'package:flutter/material.dart';
import 'package:flutter_samples/animations/christmas_tree/christmas_tree_page.dart';
import 'package:flutter_samples/animations/custom_appbar/my_custom_app_bar.dart';
import 'package:flutter_samples/animations/custom_sliver_header/custom_sliver_header.dart';
import 'package:flutter_samples/animations/foldable/foldable_page.dart';
import 'package:flutter_samples/animations/hide_my_widgets/main_hide_my_widgets.dart';
import 'package:flutter_samples/animations/list_details/list_page.dart';
import 'package:flutter_samples/animations/menu_exploration/main_menu_exploration.dart';
import 'package:flutter_samples/animations/neon_button/neon_button_main.dart';
import 'package:flutter_samples/animations/shimmer/shimmer_page.dart';
import 'package:flutter_samples/animations/shrink_top_list/shrink_top_list_page.dart';
import 'package:flutter_samples/animations/split_widget/main_split_widget.dart';
import 'package:flutter_samples/animations/turn_on_the_light/turn_on_the_light_page.dart';
import 'package:flutter_samples/main.dart';

class MainAnimations extends StatefulWidget {
  @override
  _MainAnimationsState createState() => _MainAnimationsState();
}

class _MainAnimationsState extends State<MainAnimations> {
  _onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Animations"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Foldable Page",
              onTap: () => _onButtonTap(FoldablePage()),
            ),
            MyMenuButton(
              title: "List - Details Page",
              onTap: () => _onButtonTap(ListPage()),
            ),
            MyMenuButton(
              title: "My Custom AppBar Page",
              onTap: () => _onButtonTap(MyCustomAppBarPage()),
            ),
            MyMenuButton(
              title: "My Custom Sliver Header",
              onTap: () => _onButtonTap(CustomSliverHeader()),
            ),
            MyMenuButton(
              title: "Split Widget",
              onTap: () => _onButtonTap(MainSplitWidget()),
            ),
            MyMenuButton(
              title: "Turn on the light",
              onTap: () => _onButtonTap(TurnOnTheLightPage()),
            ),
            MyMenuButton(
              title: "Hide my widgets",
              onTap: () => _onButtonTap(MainHideMyWidgets()),
            ),
            MyMenuButton(
              title: "Menu Exploration",
              onTap: () => _onButtonTap(MainMenuExploration()),
            ),
            MyMenuButton(
              title: "Shrink Top List",
              onTap: () => _onButtonTap(ShrinkTopListPage()),
            ),
            MyMenuButton(
              title: "Neon Buttons",
              onTap: () => _onButtonTap(NeonButtonMain()),
            ),
            MyMenuButton(
              title: "Christmas Tree",
              onTap: () => _onButtonTap(ChristmasTreePage()),
            ),
            MyMenuButton(
              title: "Shimmer",
              onTap: () => _onButtonTap(ShimmerPage()),
            ),
          ],
        ),
      ),
    );
  }
}
