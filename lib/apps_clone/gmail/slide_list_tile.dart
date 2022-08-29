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
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  bool _isDragging = false;
  bool _isDraggingLeft = false;
  bool _isDraggingRight = false;
  bool _isAnimating = false;
  double _offsetX = 0;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _animateToOriginalPosition() async {
    setState(() {
      _isAnimating = true;
    });
    await _animationController.reverse(from: 1);
    setState(() {
      _isAnimating = false;
    });
  }

  void _onHorizontalDragStart(DragStartDetails details) {
    setState(() {
      _isDragging = true;
    });
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _offsetX += details.delta.dx;
      _isDraggingLeft = _offsetX < 0;
      _isDraggingRight = !_isDraggingLeft;
    });
  }

  Future<void> _onHorizontalDragEnd(DragEndDetails details) async {
    _isDragging = false;

    await _animateToOriginalPosition();

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
            Positioned(
              top: 0,
              bottom: 0,
              right: 24,
              child: const Icon(Icons.delete),
            ),
            Positioned(
              top: 0,
              bottom: 0,
              left: 24,
              child: const Icon(Icons.save_alt),
            ),
            GestureDetector(
              onHorizontalDragStart: _onHorizontalDragStart,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  final offset = Offset(
                    _isDragging
                        ? _offsetX
                        : _animationController.value * _offsetX,
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
