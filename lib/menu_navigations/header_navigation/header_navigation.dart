import 'package:flutter/material.dart';

class HeaderNavigationItem {
  final Color backgroundColor;
  final Color foregroundColor;
  final Widget icon;
  final String title;
  final Widget child;

  HeaderNavigationItem({
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
    required this.icon,
    required this.child,
    required this.title,
  });
}

class HeaderNavigation extends StatefulWidget {
  final List<HeaderNavigationItem> items;
  final Duration duration;

  const HeaderNavigation({
    Key? key,
    required this.items,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  @override
  _HeaderNavigationState createState() => _HeaderNavigationState();
}

class _HeaderNavigationState extends State<HeaderNavigation> {
  int _currentIndex = 0;
  final _keyLayout = GlobalKey();
  double _heightLayout = 0.0;
  bool _open = true;

  void _onItemTapped(int index) {
    if (!_open) {
      setState(() {
        _currentIndex = index;
        _open = true;
      });
      return;
    }
    setState(() {
      _currentIndex = index;
      _open = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPersistentFrameCallback((_) {
      setState(
        () => _heightLayout =
            (_keyLayout.currentContext!.findRenderObject() as RenderBox)
                .size
                .height,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final count = widget.items.length;
    final verticalItems = <Widget>[];

    if (_heightLayout > 0.0) {
      final heightPerItem = _heightLayout / count;
      for (int i = count - 1; i >= 0; i--) {
        final item = widget.items[i];
        double itemSize = heightPerItem;
        if (!_open) {
          if (_currentIndex == i) {
            itemSize = kToolbarHeight;
          } else {
            itemSize = 0;
          }
        }
        final text = Text(
          item.title,
          style: TextStyle(
            fontSize: 16.0,
            color: item.foregroundColor,
          ),
        );
        verticalItems.add(
          AnimatedPositioned(
            duration: widget.duration,
            top: !_open ? 0.0 : i * heightPerItem,
            height: itemSize,
            left: 0.0,
            right: 0.0,
            child: InkWell(
              onTap: () => _onItemTapped(i),
              child: Container(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        if (_open)
                          Expanded(
                            flex: 2,
                            child: ClipRect(
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: <Color>[
                                    item.foregroundColor,
                                    item.foregroundColor,
                                  ],
                                  tileMode: TileMode.mirror,
                                ).createShader(bounds),
                                blendMode: BlendMode.srcIn,
                                child: item.icon,
                              ),
                            ),
                          ),
                        Expanded(child: _open ? text : Center(child: text)),
                      ],
                    ),
                    if (!_open)
                      Positioned(
                        left: 0.0,
                        right: 0.0,
                        bottom: 5.0,
                        child: ClipRect(
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: item.foregroundColor,
                            size: 10.0,
                          ),
                        ),
                      ),
                  ],
                ),
                decoration: BoxDecoration(
                  color: item.backgroundColor,
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(2.0, 1.0),
                      spreadRadius: 2.0,
                      blurRadius: 10.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
    }

    return Scaffold(
      body: Stack(
        key: _keyLayout,
        children: <Widget>[
          Positioned(
            top: kToolbarHeight,
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: IndexedStack(
              index: _currentIndex,
              children: widget.items.map((item) => item.child).toList(),
            ),
          ),
          Stack(children: verticalItems),
        ],
      ),
    );
  }
}
