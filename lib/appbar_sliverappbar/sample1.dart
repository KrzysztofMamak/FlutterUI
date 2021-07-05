import 'package:flutter/material.dart';

class Sample1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(),
        appBar: MyCustomAppBar(
          height: 150.0,
          defaultAppBar: true,
        ),
        body: Center(
          child: FlutterLogo(
            size: MediaQuery.of(context).size.width / 2,
          ),
        ),
      ),
    );
  }
}

class MyCustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double height;
  final bool defaultAppBar;

  const MyCustomAppBar({
    Key? key,
    required this.height,
    this.defaultAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          color: Colors.grey[300],
          child: Padding(
            padding: EdgeInsets.all(30.0),
            child: defaultAppBar
                ? _buildDefaultAppBar()
                : _buildCustomAppBar(context),
          ),
        ),
      ],
    );
  }

  Widget _buildDefaultAppBar() {
    return AppBar(
      title: Container(
        color: Colors.white,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Search',
            contentPadding: EdgeInsets.all(10.0),
          ),
        ),
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.verified_user),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildCustomAppBar(BuildContext context) {
    return Container(
      color: Colors.red,
      padding: EdgeInsets.all(5.0),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.verified_user),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
