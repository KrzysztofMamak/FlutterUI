import 'package:flutter/material.dart';
import 'package:flutter_samples/main.dart';
import 'package:flutter_samples/screens/login/pages/login_page.dart';

class ScreensPage extends StatefulWidget {
  @override
  _ScreensPageState createState() => _ScreensPageState();
}

class _ScreensPageState extends State<ScreensPage> {
  _onButtonTap(Widget page) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Screens"),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Login Page",
              onTap: () => _onButtonTap(LoginPage()),
            ),
          ],
        ),
      ),
    );
  }
}
