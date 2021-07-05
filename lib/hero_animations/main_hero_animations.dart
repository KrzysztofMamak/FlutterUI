import 'package:flutter/material.dart';
import 'package:flutter_samples/hero_animations/first_page.dart';
import 'package:flutter_samples/hero_animations/hero_dialog_route.dart';
import 'package:flutter_samples/hero_animations/second_page.dart';

class MainHeroAnimationsPage extends StatefulWidget {
  @override
  _MainHeroAnimationsPageState createState() => _MainHeroAnimationsPageState();
}

class _MainHeroAnimationsPageState extends State<MainHeroAnimationsPage> {
  void _onButtonTap(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => page,
      ),
    );
  }

  void _onButtonTapPopup(Widget page) {
    Navigator.push(
      context,
      HeroDialogRoute(builder: (context) => page),
    );
  }

  void _onButtonTapCustom(Widget page) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Opacity(
                opacity: animation.value,
                child: page,
              );
            },
          );
        },
        transitionDuration: Duration(milliseconds: 1600),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hero Animations'),
      ),
      body: Container(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildCustomButton('Simple Hero', FirstPage()),
              _buildCustomButton('Two Heroes', SecondPage()),
              _buildCustomButton('Hero on Dialog', _buildPopup(context),
                  isPopup: true),
              _buildCustomButton('Custom Hero Animation', FirstPage(),
                  isCustom: true),
              Hero(
                tag: 'hero1',
                child: ClipOval(child: CustomLogo(size: 60.0)),
              ),
              Hero(
                tag: 'hero2',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    'Sample Hero',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton(
    String text,
    Widget page, {
    bool isPopup = false,
    bool isCustom = false,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        height: 40.0,
        padding: const EdgeInsets.all(10.0),
        color: Colors.lightBlue,
        onPressed: () {
          if (isPopup) {
            _onButtonTapPopup(page);
          } else if (isCustom) {
            _onButtonTapCustom(page);
          } else {
            _onButtonTap(page);
          }
        },
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13.0),
        ),
      ),
    );
  }

  Widget _buildPopup(BuildContext context) {
    return Center(
      child: AlertDialog(
        title: Hero(
          tag: 'hero2',
          child: Material(child: Text('You are my hero')),
        ),
        content: Container(
          child: Hero(
            tag: 'hero1',
            child: CustomLogo(size: 300.0),
          ),
        ),
        actions: <Widget>[
          OutlinedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

class CustomLogo extends StatelessWidget {
  final double size;

  CustomLogo({this.size = 200.0});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightBlueAccent,
      width: size,
      height: size,
      child: Center(
        child: Image.asset(
          'assets/mario_logo.png',
          width: size,
          height: size,
        ),
      ),
    );
  }
}
