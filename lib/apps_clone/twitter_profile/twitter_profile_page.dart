import 'package:flutter/material.dart';

class TwitterProfilePage extends StatefulWidget {
  @override
  _TwitterProfilePageState createState() => _TwitterProfilePageState();
}

class _TwitterProfilePageState extends State<TwitterProfilePage> {
  static const double _avatarMaximumRadius = 40.0;
  static const double _avatarMinimumRadius = 15.0;
  double _avatarRadius = _avatarMinimumRadius;
  double _expandedHeader = 130.0;
  double _translate = -_avatarMaximumRadius;
  bool _isExpanded = true;
  double _offset = 0.0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey[900],
        body: NotificationListener<ScrollUpdateNotification>(
          onNotification: (scrollNotification) {
            final pixels = scrollNotification.metrics.pixels;
            final scrollTabs = (scrollNotification.metrics.axisDirection ==
                    AxisDirection.right ||
                scrollNotification.metrics.axisDirection == AxisDirection.left);
            if (!scrollTabs) {
              if (_expandedHeader - pixels <= kToolbarHeight) {
                if (_isExpanded) {
                  _translate = 0.0;
                  setState(() => _isExpanded = false);
                }
              } else {
                _translate = -_avatarMaximumRadius + pixels;
                if (_translate > 0) _translate = 0.0;
                if (!_isExpanded) setState(() => _isExpanded = true);
              }

              _offset = pixels * 0.4;

              final newSize = _avatarMaximumRadius - _offset;

              setState(() {
                if (newSize < _avatarMinimumRadius) {
                  _avatarRadius = _avatarMinimumRadius;
                } else if (newSize > _avatarMaximumRadius) {
                  _avatarRadius = _avatarMaximumRadius;
                } else {
                  _avatarRadius = newSize;
                }
              });
            }
            return false;
          },
          child: DefaultTabController(
            length: 8,
            child: CustomScrollView(
              physics: ClampingScrollPhysics(),
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: _expandedHeader,
                  backgroundColor: Colors.grey,
                  leading: BackButton(
                      color: _isExpanded ? Colors.grey : Colors.white),
                  pinned: true,
                  elevation: 5.0,
                  forceElevated: true,
                  flexibleSpace: Container(
                    decoration: BoxDecoration(
                      color:
                          _isExpanded ? Colors.transparent : Colors.blue[800],
                      image: _isExpanded
                          ? DecorationImage(
                              fit: BoxFit.cover,
                              alignment: Alignment.bottomCenter,
                              image:
                                  AssetImage('assets/twitter_profile/twitter_flutter_bg.png'),
                            )
                          : null,
                    ),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: _isExpanded
                          ? Transform(
                              transform: Matrix4.identity()
                                ..translate(0.0, _avatarMaximumRadius),
                              child: MyAvatar(size: _avatarRadius),
                            )
                          : SizedBox.shrink(),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            _isExpanded
                                ? SizedBox(height: _avatarMinimumRadius * 2)
                                : MyAvatar(size: _avatarMinimumRadius),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                  horizontal: 10.0,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                child: Text(
                                  'Following',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        TwitterHeader(),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: TwitterTabs(50.0),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) => Tweet(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TwitterTabs extends SliverPersistentHeaderDelegate {
  final double size;

  TwitterTabs(this.size);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.blueGrey[900],
      height: size,
      child: TabBar(
        labelColor: Colors.white,
        isScrollable: true,
        tabs: <Widget>[
          Tab(text: 'Tweets'),
          Tab(text: 'Tweets & Replies'),
          Tab(text: 'Media'),
          Tab(text: 'Likes'),
          Tab(text: 'Tweets'),
          Tab(text: 'Tweets & Replies'),
          Tab(text: 'Media'),
          Tab(text: 'Likes'),
        ],
      ),
    );
  }

  @override
  double get maxExtent => size;

  @override
  double get minExtent => size;

  @override
  bool shouldRebuild(TwitterTabs oldDelegate) => oldDelegate.size != size;
}

class TwitterHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            '@flutterio',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 15.0,
              fontWeight: FontWeight.w200,
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            'Google\'s mobile app SDK for building beautiful native apps on iOS and Android in record time // For support visit https://stackoverflow.com/tags/flutter',
            style: TextStyle(
              color: Colors.white,
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}

class Tweet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.all(6.0),
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/twitter_profile/twitter_flutter_logo.jpg'),
      ),
      title: RichText(
        text: TextSpan(
          text: 'Flutter',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 16.0,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '  @flutterio 04 Dec 18',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
      subtitle: Text(
        'We just announced the general availability of Flutter 2.0 at #FlutterLive! \n\nThank you to all the amazing engineers who made this possible and to our awesome community for their support.',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class MyAvatar extends StatelessWidget {
  final double size;

  const MyAvatar({
    Key? key,
    required this.size,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[800]!,
            width: 2.0,
          ),
          shape: BoxShape.circle,
        ),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: CircleAvatar(
            radius: size,
            backgroundImage: AssetImage('assets/twitter_profile/twitter_flutter_logo.jpg'),
          ),
        ),
      ),
    );
  }
}
