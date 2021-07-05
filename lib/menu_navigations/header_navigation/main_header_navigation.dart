import 'package:flutter/material.dart';
import 'package:flutter_samples/menu_navigations/content_navigation.dart';
import 'package:flutter_samples/menu_navigations/header_navigation/header_navigation.dart';

class MainHeaderNavigation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: HeaderNavigation(
          items: <HeaderNavigationItem>[
            HeaderNavigationItem(
              backgroundColor: Colors.purple,
              title: 'SERVICES',
              foregroundColor: Colors.white,
              icon: Icon(Icons.room_service, size: 45.0),
              child: ContentNavigation(color: Colors.purple),
            ),
            HeaderNavigationItem(
              backgroundColor: Colors.red,
              title: "AUTO",
              foregroundColor: Colors.white,
              icon: Icon(Icons.directions_car, size: 45),
              child: ContentNavigation(color: Colors.red),
            ),
            HeaderNavigationItem(
              backgroundColor: Colors.green,
              title: "JOB",
              foregroundColor: Colors.white,
              icon: Icon(Icons.person, size: 45),
              child: ContentNavigation(color: Colors.green),
            ),
            HeaderNavigationItem(
              backgroundColor: Colors.blue,
              title: "REALTY",
              foregroundColor: Colors.white,
              icon: Icon(Icons.home, size: 45),
              child: ContentNavigation(color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
