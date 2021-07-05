import 'package:flutter/material.dart';

class Sample2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverPersistentHeader(
              delegate: MySliverAppBar(expandedHeight: 200.0),
              pinned: true,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (_, index) => ListTile(title: Text('Index: $index')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliverAppBar extends SliverPersistentHeaderDelegate {
  final double expandedHeight;

  MySliverAppBar({required this.expandedHeight});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      clipBehavior: Clip.hardEdge,
      children: <Widget>[
        Image.network(
          'https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
          fit: BoxFit.cover,
        ),
        Center(
          child: Opacity(
            opacity: shrinkOffset / expandedHeight,
            child: Text(
              '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23.0,
              ),
            ),
          ),
        ),
        Positioned(
          top: expandedHeight / 2 - shrinkOffset,
          left: MediaQuery.of(context).size.width / 4,
          child: Opacity(
            opacity: 1 - shrinkOffset / expandedHeight,
            child: Card(
              elevation: 10.0,
              child: SizedBox(
                height: expandedHeight,
                width: MediaQuery.of(context).size.width / 2,
                child: FlutterLogo(),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ],
    );
  }

  @override
  double get maxExtent => expandedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
