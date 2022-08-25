import 'package:flutter/material.dart';
import 'package:flutter_samples/hidden_drawer/hidden_drawer.dart';
import 'package:flutter_samples/hidden_drawer/hidden_drawer_item.dart';
import 'package:flutter_samples/hidden_drawer/hidden_drawer_items.dart';
import 'package:flutter_samples/hidden_drawer/page/explore_page.dart';
import 'package:flutter_samples/hidden_drawer/page/favorites_page.dart';
import 'package:flutter_samples/hidden_drawer/page/home_page.dart';
import 'package:flutter_samples/hidden_drawer/page/messages_page.dart';
import 'package:flutter_samples/hidden_drawer/page/profile_page.dart';
import 'package:flutter_samples/hidden_drawer/page/settings_page.dart';

class HiddenDrawerPage extends StatefulWidget {
  const HiddenDrawerPage({Key? key}) : super(key: key);

  @override
  _HiddenDrawerPageState createState() => _HiddenDrawerPageState();
}

class _HiddenDrawerPageState extends State<HiddenDrawerPage> {
  late double _xOffset;
  late double _yOffset;
  late double _scaleFactor;
  late bool _isDrawerOpen;
  bool _isDragging = false;
  HiddenDrawerItem _item = HiddenDrawerItems.home;

  Widget _buildDrawer() {
    return SafeArea(
      child: Container(
        width: _xOffset,
        child: HiddenDrawer(
          onItemSelected: (item) {
            switch (item) {
              case HiddenDrawerItems.logout:
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Logging out'),
                  ),
                );
                return;
              default:
                setState(() {
                  _item = item;
                });
                _closeDrawer();
            }
          },
        ),
      ),
    );
  }

  void _closeDrawer() {
    setState(() {
      _xOffset = 0;
      _yOffset = 0;
      _scaleFactor = 1;
      _isDrawerOpen = false;
    });
  }

  void _openDrawer() {
    setState(() {
      _xOffset = 230.0;
      _yOffset = 150.0;
      _scaleFactor = 0.6;
      _isDrawerOpen = true;
    });
  }

  Widget _getDrawerPage() {
    switch (_item) {
      case HiddenDrawerItems.explore:
        return ExplorePage(openDrawer: _openDrawer);
      case HiddenDrawerItems.favorites:
        return FavoritesPage(openDrawer: _openDrawer);
      case HiddenDrawerItems.messages:
        return MessagesPage(openDrawer: _openDrawer);
      case HiddenDrawerItems.profile:
        return ProfilePage(openDrawer: _openDrawer);
      case HiddenDrawerItems.settings:
        return SettingsPage(openDrawer: _openDrawer);
      case HiddenDrawerItems.home:
      default:
        return HomePage(openDrawer: _openDrawer);
    }
  }

  Widget _buildPage() {
    return WillPopScope(
      onWillPop: () async {
        if (_isDrawerOpen) {
          _closeDrawer();
          return false;
        }
        return true;
      },
      child: GestureDetector(
        onTap: _closeDrawer,
        onHorizontalDragStart: (details) => _isDragging = true,
        onHorizontalDragUpdate: (details) {
          if (!_isDragging) {
            return;
          }
          const delta = 1;
          if (details.delta.dx > delta) {
            _openDrawer();
          } else if (details.delta.dx < -delta) {
            _closeDrawer();
          }

          _isDragging = false;
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.translationValues(_xOffset, _yOffset, 0)
            ..scale(_scaleFactor),
          child: AbsorbPointer(
            absorbing: _isDrawerOpen,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_isDrawerOpen ? 20 : 0),
              child: Container(
                color: _isDrawerOpen ? Colors.white12 : null,
                child: _getDrawerPage(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        children: [
          _buildDrawer(),
          _buildPage(),
        ],
      ),
    );
  }
}
