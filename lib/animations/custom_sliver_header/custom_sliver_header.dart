import 'dart:math';

import 'package:flutter/material.dart';

const kAvatarSize = 60.0;
const kMinAvatarSize = 30.0;
const kExtraSpace = 70.0;

class CustomSliverHeader extends StatefulWidget {
  @override
  _CustomSliverHeaderState createState() => _CustomSliverHeaderState();
}

class _CustomSliverHeaderState extends State<CustomSliverHeader> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Material(
        color: Color(0xFF181818),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  delegate: MyHeaderDelegate(
                    kToolbarHeight + kAvatarSize + kExtraSpace,
                  ),
                  pinned: true,
                ),
              ];
            },
            body: ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Item $index'));
              },
            ),
          ),
        ),
      ),
    );
  }
}

class MyHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double extendedHeight;

  MyHeaderDelegate(this.extendedHeight);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double newSize = maxExtent - shrinkOffset;
    double newSizePercent = kAvatarSize + kExtraSpace - shrinkOffset;
    double newAvatarSize = kAvatarSize - shrinkOffset;
    double newAvatarSpace = kAvatarSize - shrinkOffset;
    if (newSize < minExtent) newSize = minExtent;
    if (newAvatarSize < kMinAvatarSize) newAvatarSize = kMinAvatarSize;
    if (newAvatarSpace < 0) newAvatarSpace = 0;
    final percent = (newSizePercent >= 0 ? newSizePercent : 0) /
        (kAvatarSize + kExtraSpace).abs();
    double avatarXPosition = max(
        ((MediaQuery.of(context).size.width / 2) - newAvatarSize / 2) * percent,
        15.0);
    double actionsXPosition = 50 * (1 - percent);

    return Container(
      color: Color(0xFF2C2E2F),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            height: kToolbarHeight + newAvatarSpace,
            child: Stack(
              children: <Widget>[
                AppBar(
                  title: Text('Google'),
                  centerTitle: false,
                  elevation: 0.0,
                  actions: <Widget>[
                    Container(
                      width: 150.0,
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          Positioned(
                            top: 0.0,
                            right: actionsXPosition,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.help),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(Icons.more_vert),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  backgroundColor: Colors.transparent,
                ),
                Positioned(
                  bottom: kMinAvatarSize / 2,
                  right: avatarXPosition,
                  child: CircleAvatar(
                    radius: newAvatarSize / 2,
                    backgroundColor: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Opacity(
              opacity: percent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      'Full Name',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'email@email.com',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => extendedHeight;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
