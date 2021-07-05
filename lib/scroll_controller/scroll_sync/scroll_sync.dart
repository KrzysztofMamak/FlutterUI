import 'package:flutter/material.dart';

class ScrollSync extends StatefulWidget {
  @override
  _ScrollSyncState createState() => _ScrollSyncState();
}

class _ScrollSyncState extends State<ScrollSync> {
  late _CustomScrollController _scrollController1;
  late _CustomScrollController _scrollController2;

  @override
  void initState() {
    _scrollController1 = _CustomScrollController();
    _scrollController2 = _CustomScrollController();
    _scrollController1.addListener(() => _scrollController2
        .jumpToWithoutGoingIdleAndKeepBallistic(_scrollController1.offset));
    _scrollController2.addListener(() => _scrollController1
        .jumpToWithoutGoingIdleAndKeepBallistic(_scrollController2.offset));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController1.dispose();
    _scrollController2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Sync'),
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 1,
            child: ListView.builder(
              controller: _scrollController1,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) => Container(
                color: Colors.red,
                width: 150.0,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    '$index',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: ListView.builder(
              controller: _scrollController2,
              itemBuilder: (_, index) => Container(
                color: Colors.black,
                margin: EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    '$index',
                    style: Theme.of(context)
                        .textTheme
                        .headline3
                        ?.copyWith(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomScrollController extends ScrollController {
  _CustomScrollController({
    double initialScrollOffset = 0.0,
    keepScrollOffset = true,
    debugLabel,
  }) : super(
          initialScrollOffset: initialScrollOffset,
          keepScrollOffset: keepScrollOffset,
          debugLabel: debugLabel,
        );

  @override
  _SilentScrollPosition createScrollPosition(
    ScrollPhysics physics,
    ScrollContext context,
    ScrollPosition? oldPosition,
  ) {
    return _SilentScrollPosition(
      physics: physics,
      context: context,
      oldPosition: oldPosition,
      initialPixels: initialScrollOffset,
    );
  }

  void jumpToWithoutGoingIdleAndKeepBallistic(double value) {
    assert(positions.isNotEmpty, 'ScrollController not attached.');
    for (_SilentScrollPosition position in List<_SilentScrollPosition>.from(
        positions.map((position) => position as _SilentScrollPosition)))
      position.jumpToWithoutGoingIdleAndKeepBallistic(value);
  }
}

class _SilentScrollPosition extends ScrollPositionWithSingleContext {
  _SilentScrollPosition({
    required ScrollPhysics physics,
    required ScrollContext context,
    required ScrollPosition? oldPosition,
    required double initialPixels,
  }) : super(
          physics: physics,
          context: context,
          oldPosition: oldPosition,
          initialPixels: initialPixels,
        );

  void jumpToWithoutGoingIdleAndKeepBallistic(double value) {
    if (pixels != value) forcePixels(value);
  }
}
