import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_samples/amazing_hero_animations/amazing_hero_animations_page.dart';
import 'package:flutter_samples/amazing_sidebar/amazing_sidebar_page.dart';
import 'package:flutter_samples/animated_circle_avatar/animated_circle_avatar_page.dart';
import 'package:flutter_samples/animated_list/animated_list_page.dart';
import 'package:flutter_samples/animations/main_animations.dart';
import 'package:flutter_samples/appbar_sliverappbar/main_appbar_sliverappbar.dart';
import 'package:flutter_samples/apps_clone/main_apps_clone.dart';
import 'package:flutter_samples/awaiting_button/awaiting_button_page.dart';
import 'package:flutter_samples/bouncing_cards/bouncing_cards_page.dart';
import 'package:flutter_samples/collapsing_toolbar/main_collapsing_toolbar.dart';
import 'package:flutter_samples/communication_widgets/main_communication_widgets.dart';
import 'package:flutter_samples/confetti/confetti_page.dart';
import 'package:flutter_samples/countdown_timer/countdown_timer_page.dart';
import 'package:flutter_samples/curved_navigation/curved_navigation_page.dart';
import 'package:flutter_samples/double_tap_image/double_tap_image_page.dart';
import 'package:flutter_samples/fab_range/fab_range_page.dart';
import 'package:flutter_samples/flipping_card/flipping_card_page.dart';
import 'package:flutter_samples/flipping_card_2/flipping_card_2_page.dart';
import 'package:flutter_samples/hero_animations/main_hero_animations.dart';
import 'package:flutter_samples/hidden_bar_and_fab/hidden_bar_and_fab_page.dart';
import 'package:flutter_samples/hidden_drawer/hidden_drawer_page.dart';
import 'package:flutter_samples/hide_bottom_nav_bar/hide_bottom_nav_bar_page.dart';
import 'package:flutter_samples/hover_effects/hover_effects_page.dart';
import 'package:flutter_samples/image_transformer/image_transformer_page.dart';
import 'package:flutter_samples/instagram_like_animation/instagram_like_animation_page.dart';
import 'package:flutter_samples/jigsaw_puzzle/jigsaw_puzzle_page.dart';
import 'package:flutter_samples/menu_navigations/main_menu_navigations.dart';
import 'package:flutter_samples/page_transition/page_transition_page.dart';
import 'package:flutter_samples/parallax/parallax_page.dart';
import 'package:flutter_samples/persistent_tab_bar/main_persistent_tab_bar.dart';
import 'package:flutter_samples/rotate_widget/rotate_widget_page.dart';
import 'package:flutter_samples/rotating_waves/rotating_waves_page.dart';
import 'package:flutter_samples/screens/screens_page.dart';
import 'package:flutter_samples/scroll_controller/main_scroll_controller.dart';
import 'package:flutter_samples/shimmer_effect/shimmer_effect_page.dart';
import 'package:flutter_samples/size_and_position/main_size_and_position.dart';
import 'package:flutter_samples/speed_dial/speed_dial_page.dart';
import 'package:flutter_samples/split_image/main_split_image.dart';
import 'package:flutter_samples/stop_watch_timer/stop_watch_timer_page.dart';
import 'package:flutter_samples/text_slide/text_slide_page.dart';
import 'package:flutter_samples/tinder_carousel/tinder_carousel_page.dart';
import 'package:flutter_samples/transition_animations/transition_animations_page.dart';
import 'package:flutter_samples/turn_on_the_blur/turn_on_the_blur_page.dart';

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
            MyMenuButton(
              title: "FabRange",
              onTap: () => _onButtonTap(FabRangePage()),
            ),
            MyMenuButton(
              title: "Confetti",
              onTap: () => _onButtonTap(ConfettiPage()),
            ),
            MyMenuButton(
              title: "Parallax",
              onTap: () => _onButtonTap(ParallaxPage()),
            ),
            MyMenuButton(
              title: "Page Transition",
              onTap: () => _onButtonTap(PageTransitionPage()),
            ),
            MyMenuButton(
              title: "Tinder Carousel",
              onTap: () => _onButtonTap(TinderCarouselPage()),
            ),
            MyMenuButton(
              title: "Image Transformer",
              onTap: () => _onButtonTap(ImageTransformerPage()),
            ),
            MyMenuButton(
              title: "Double Tap Image",
              onTap: () => _onButtonTap(DoubleTapImagePage()),
            ),
            MyMenuButton(
              title: "Flipping Card",
              onTap: () => _onButtonTap(FlippingCardPage()),
            ),
            MyMenuButton(
              title: "Flipping Card 2",
              onTap: () => _onButtonTap(FlippingCard2Page()),
            ),
            MyMenuButton(
              title: "Rotate Widget",
              onTap: () => _onButtonTap(RotateWidgetPage()),
            ),
            MyMenuButton(
              title: "Curved Navigation",
              onTap: () => _onButtonTap(CurvedNavigationPage()),
            ),
            MyMenuButton(
              title: "Hidden Bar and Fab",
              onTap: () => _onButtonTap(HiddenBarAndFabPage()),
            ),
            MyMenuButton(
              title: "Speed Dial",
              onTap: () => _onButtonTap(SpeedDialPage()),
            ),
            MyMenuButton(
              title: "Awaiting Button",
              onTap: () => _onButtonTap(AwaitingButtonPage()),
            ),
            MyMenuButton(
              title: "Amazing Hero Animations",
              onTap: () => _onButtonTap(AmazingHeroAnimationsPage()),
            ),
            MyMenuButton(
              title: "Amazing Sidebar",
              onTap: () => _onButtonTap(AmazingSidebarPage()),
            ),
            MyMenuButton(
              title: "Text Slide",
              onTap: () => _onButtonTap(TextSlidePage()),
            ),
            MyMenuButton(
              title: "Hide Bottom Nav Bar",
              onTap: () => _onButtonTap(HideBottomNavBarPage()),
            ),
            MyMenuButton(
              title: "Instagram Like Animation",
              onTap: () => _onButtonTap(InstagramLikeAnimationPage()),
            ),
            MyMenuButton(
              title: "Stop Watch Timer",
              onTap: () => _onButtonTap(StopWatchTimerPage()),
            ),
            MyMenuButton(
              title: "Countdown Timer",
              onTap: () => _onButtonTap(CountdownTimerPage()),
            ),
            MyMenuButton(
              title: "Transition Animations",
              onTap: () => _onButtonTap(TransitionAnimationsPage()),
            ),
            // Only web
            MyMenuButton(
              title: "Hover Effects",
              onTap: () => _onButtonTap(HoverEffectsPage()),
            ),
            MyMenuButton(
              title: "Hidden Drawer",
              onTap: () => _onButtonTap(HiddenDrawerPage()),
            ),
            MyMenuButton(
              title: "Shimmer Effect",
              onTap: () => _onButtonTap(ShimmerEffectPage()),
            ),
            MyMenuButton(
              title: "Animated List",
              onTap: () => _onButtonTap(AnimatedListPage()),
            ),
            MyMenuButton(
              title: "Turn on the blur",
              onTap: () => _onButtonTap(TurnOnTheBlurPage()),
            ),
            MyMenuButton(
              title: "Jigsaw Puzzle",
              onTap: () => _onButtonTap(JigsawPuzzlePage()),
            ),
            MyMenuButton(
              title: "Bouncing cards",
              onTap: () => _onButtonTap(BouncingCardsPage()),
            ),
            MyMenuButton(
              title: "Rotating Waves",
              onTap: () => _onButtonTap(RotatingWavesPage()),
            ),
            MyMenuButton(
              title: "Animated Circle Avatar",
              onTap: () => _onButtonTap(AnimatedCircleAvatarPage()),
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
