import 'package:flutter/material.dart';
import 'package:flutter_samples/hidden_drawer/hidden_drawer_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HiddenDrawerItems {
  static const home = HiddenDrawerItem(
    title: 'Home',
    icon: FontAwesomeIcons.home,
  );
  static const explore = HiddenDrawerItem(
    title: 'Explore',
    icon: Icons.explore,
  );
  static const favorites = HiddenDrawerItem(
    title: 'Favorites',
    icon: Icons.favorite,
  );
  static const messages = HiddenDrawerItem(
    title: 'Messages',
    icon: Icons.mail,
  );
  static const profile = HiddenDrawerItem(
    title: 'Profile',
    icon: FontAwesomeIcons.userAlt,
  );
  static const settings = HiddenDrawerItem(
    title: 'Settings',
    icon: Icons.settings,
  );
  static const logout = HiddenDrawerItem(
    title: 'Logout',
    icon: Icons.logout,
  );

  static final all = [
    home,
    explore,
    favorites,
    messages,
    profile,
    settings,
    logout,
  ];
}
