import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_samples/curved_navigation/page/favorite_page.dart';
import 'package:flutter_samples/curved_navigation/page/home_page.dart';
import 'package:flutter_samples/curved_navigation/page/profile_page.dart';
import 'package:flutter_samples/curved_navigation/page/search_page.dart';
import 'package:flutter_samples/curved_navigation/page/settings_page.dart';

class CurvedNavigationPage extends StatefulWidget {
  const CurvedNavigationPage({Key? key}) : super(key: key);

  @override
  _CurvedNavigationPageState createState() => _CurvedNavigationPageState();
}

class _CurvedNavigationPageState extends State<CurvedNavigationPage> {
  final _navigationKey = GlobalKey<CurvedNavigationBarState>();
  int _index = 2;
  final _screens = [
    HomePage(),
    SearchPage(),
    FavoritePage(),
    SettingsPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final items = [
      Icon(Icons.home, size: 30),
      Icon(Icons.search, size: 30),
      Icon(Icons.favorite, size: 30),
      Icon(Icons.settings, size: 30),
      Icon(Icons.person, size: 30),
    ];
    return Container(
      color: Colors.blue,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: Colors.orange,
          appBar: AppBar(
            title: const Text('Curved Navigation'),
          ),
          extendBody: true,
          bottomNavigationBar: Theme(
            data: Theme.of(context).copyWith(
              iconTheme: IconThemeData(color: Colors.white),
            ),
            child: CurvedNavigationBar(
              key: _navigationKey,
              color: Colors.blue,
              buttonBackgroundColor: Colors.purple,
              backgroundColor: Colors.transparent,
              height: 60,
              animationCurve: Curves.easeInOut,
              animationDuration: const Duration(milliseconds: 300),
              index: _index,
              items: items,
              onTap: (index) {
                setState(() {
                  _index = index;
                });
              },
            ),
          ),
          body: _screens[_index],
        ),
      ),
    );
  }
}
