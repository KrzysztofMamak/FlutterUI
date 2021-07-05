import 'package:flutter/material.dart';
import 'package:flutter_samples/main.dart';
import 'package:flutter_samples/menu_navigations/header_navigation/main_header_navigation.dart';

class MainMenuNavigations extends StatelessWidget {
  void _onButtonTap(Widget page, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Menu Navigations'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: 'Header Navigation',
              onTap: () => _onButtonTap(MainHeaderNavigation(), context),
            ),
          ],
        ),
      ),
    );
  }
}
