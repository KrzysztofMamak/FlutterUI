import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_samples/amazing_sidebar/menu_item.dart';
import 'package:flutter_samples/amazing_sidebar/menu_page.dart';
import 'package:flutter_samples/amazing_sidebar/page/about_us_page.dart';
import 'package:flutter_samples/amazing_sidebar/page/help_page.dart';
import 'package:flutter_samples/amazing_sidebar/page/notifications_page.dart';
import 'package:flutter_samples/amazing_sidebar/page/payment_page.dart';
import 'package:flutter_samples/amazing_sidebar/page/promos_page.dart';
import 'package:flutter_samples/amazing_sidebar/page/rate_us_page.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

class AmazingSidebarPage extends StatefulWidget {
  const AmazingSidebarPage({Key? key}) : super(key: key);

  @override
  _AmazingSidebarPageState createState() => _AmazingSidebarPageState();
}

class _AmazingSidebarPageState extends State<AmazingSidebarPage> {
  MenuItem _currentItem = MenuItems.payment;

  Widget _getScreen() {
    switch (_currentItem) {
      case MenuItems.payment:
        return PaymentPage();
      case MenuItems.payment:
        return PromosPage();
      case MenuItems.payment:
        return NotificationsPage();
      case MenuItems.payment:
        return HelpPage();
      case MenuItems.payment:
        return AboutUsPage();
      case MenuItems.payment:
      default:
        return RateUsPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      style: DrawerStyle.style1,
      borderRadius: 40,
      angle: -10,
      menuScreen: Builder(
        builder: (context) {
          return MenuPage(
            currentItem: _currentItem,
            onSelectedItem: (item) {
              setState(() {
                _currentItem = item;
                ZoomDrawer.of(context)!.close();
              });
            },
          );
        },
      ),
      mainScreen: _getScreen(),
    );
  }
}
