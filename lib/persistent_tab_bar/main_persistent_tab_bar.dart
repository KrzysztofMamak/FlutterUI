import 'package:flutter/material.dart';
import 'package:flutter_samples/persistent_tab_bar/first_page.dart';
import 'package:flutter_samples/persistent_tab_bar/second_page.dart';

class MainPersistentTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            isScrollable: true,
            tabs: <Tab>[
              Tab(
                icon: Icon(Icons.directions_car),
                text: 'Non persistent',
              ),
              Tab(icon: Icon(Icons.directions_transit)),
              Tab(icon: Icon(Icons.directions_railway)),
              Tab(icon: Icon(Icons.directions_subway)),
            ],
          ),
          title: Text('Persistent Tab Demo'),
        ),
        body: TabBarView(
          children: <Widget>[
            FirstPage(),
            SecondPage(),
            Text('Page 3'),
            Text('Page 4'),
          ],
        ),
      ),
    );
  }
}
