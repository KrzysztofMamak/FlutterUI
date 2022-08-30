import 'package:flutter/material.dart';

// TODO -> Refactor
// TODO -> Inv. transparent color
// TODO -> Inv. stopping slider at current position and invoking callback
// TODO -> Use listener for updates
// TODO -> Add icon animations
// TODO -> Add callback args
// TODO -> Add customisation
// TODO -> Inv. AnimatedList

class SlideListTile extends StatefulWidget {
  const SlideListTile({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  _SlideListTileState createState() => _SlideListTileState();
}

class _SlideListTileState extends State<SlideListTile>
    with TickerProviderStateMixin {
  static const _iconSize = 16.0;

  late final AnimationController _slideAnimationController;
  late final AnimationController _iconAnimationController;
  late final Animation<double> _iconAnimation;

  bool _isDragging = false;
  bool _isDraggingLeft = false;
  bool _isDraggingRight = false;
  bool _isAnimating = false;
  double _offsetX = 0;

  @override
  void initState() {
    super.initState();
    _slideAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _iconAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 100),
    )..addListener(() {
        print('VALUE: ${_iconAnimation.value}');
      });
    // _iconAnimation = Tween<double>(
    //   begin: 1,
    //   end: 1.4,
    // ).animate(_iconAnimationController);
    _iconAnimation = CurvedAnimation(
      parent: _iconAnimationController,
      curve: Curves.easeInOutBack,
    );
  }

  @override
  void dispose() {
    _slideAnimationController.dispose();
    _iconAnimationController.dispose();
    super.dispose();
  }

  Future<void> _animateTileToOriginalPosition() async {
    setState(() {
      _isAnimating = true;
    });
    await _slideAnimationController.reverse(from: 1);
    setState(() {
      _isAnimating = false;
    });
  }

  Future<void> _animateIcon({bool reverse = false}) async {
    if (reverse) {
      await _iconAnimationController.reverse();
    } else {
      await _iconAnimationController.forward();
    }
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    final oldOffsetX = _offsetX;
    final dx = details.delta.dx;

    _isDraggingLeft = _offsetX < 0;
    _isDraggingRight = !_isDraggingLeft;

    if (oldOffsetX < 100 && oldOffsetX + dx >= 100 && _isDraggingRight) {
      _animateIcon();
    }
    if (oldOffsetX > -100 && oldOffsetX + dx <= -100 && _isDraggingLeft) {
      _animateIcon();
    }
    if (oldOffsetX > 100 && oldOffsetX + dx <= 100 && _isDraggingRight) {
      _animateIcon(reverse: true);
    }
    if (oldOffsetX < -100 && oldOffsetX + dx >= -100 && _isDraggingLeft) {
      _animateIcon(reverse: true);
    }
    setState(() {
      _offsetX += details.delta.dx;
    });
  }

  Future<void> _onHorizontalDragEnd(DragEndDetails details) async {
    _isDragging = false;

    _animateIcon(reverse: true);
    await _animateTileToOriginalPosition();

    setState(() {
      _isDraggingLeft = false;
      _isDraggingRight = false;
      _offsetX = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isDraggingRight ? Colors.green : Colors.red,
      child: IgnorePointer(
        ignoring: _isAnimating,
        child: Stack(
          children: [
            if (_isDragging || _isAnimating)
              Positioned(
                top: 0,
                bottom: 0,
                left: _isDraggingRight ? 24 : null,
                right: _isDraggingLeft ? 24 : null,
                child: AnimatedBuilder(
                  animation: _iconAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1 + _iconAnimation.value,
                      child: Icon(
                        _isDraggingRight ? Icons.delete : Icons.save,
                        size: _iconSize,
                      ),
                    );
                  },
                ),
                // child: ScaleTransition(
                //   scale: _iconAnimation,
                //   child: Icon(
                //     _isDraggingRight ? Icons.delete : Icons.save,
                //     size: _iconSize,
                //   ),
                // ),
              ),
            GestureDetector(
              onHorizontalDragStart: _onHorizontalDragStart,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: AnimatedBuilder(
                animation: _slideAnimationController,
                builder: (context, child) {
                  final offset = Offset(
                    _isDragging
                        ? _offsetX
                        : _slideAnimationController.value * _offsetX,
                    0,
                  );
                  return Transform.translate(
                    offset: offset,
                    child: child,
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      (_isAnimating || _isDragging) && _offsetX.abs() > 0.5
                          ? 8
                          : 0),
                  child: widget.child,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
