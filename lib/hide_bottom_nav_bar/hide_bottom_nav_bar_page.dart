import 'package:flutter/material.dart';
import 'package:flutter_samples/hide_bottom_nav_bar/scroll_to_hide_widget.dart';

class HideBottomNavBarPage extends StatefulWidget {
  const HideBottomNavBarPage({Key? key}) : super(key: key);

  @override
  _HideBottomNavBarPageState createState() => _HideBottomNavBarPageState();
}

class _HideBottomNavBarPageState extends State<HideBottomNavBarPage> {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildCard(int number) {
    return ListTile(
      title: Text('Item $number'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hide Bottom Nav Bar'),
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: 25,
        itemBuilder: (context, index) {
          return _buildCard(index + 1);
        },
      ),
      bottomNavigationBar: ScrollToHideWidget(
        controller: _controller,
        child: BottomNavigationBar(
          backgroundColor: Colors.blue,
          fixedColor: Colors.white,
          unselectedItemColor: Colors.white,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
