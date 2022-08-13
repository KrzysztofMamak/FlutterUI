import 'package:flutter/material.dart';

// TODO -> fix - wrong overlay position, interaction with image when overlay is displayed

class PinchZoomImage extends StatefulWidget {
  const PinchZoomImage({Key? key}) : super(key: key);

  @override
  _PinchZoomImageState createState() => _PinchZoomImageState();
}

class _PinchZoomImageState extends State<PinchZoomImage>
    with SingleTickerProviderStateMixin {
  late final TransformationController _controller;
  late final AnimationController _animationController;
  Animation<Matrix4>? _animation;
  final double _minScale = 1;
  final double _maxScale = 4;
  double _scale = 1;
  OverlayEntry? _entry;

  @override
  void initState() {
    super.initState();
    _controller = TransformationController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    )
      ..addListener(() {
        _controller.value = _animation!.value;
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _removeOverlay();
        }
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _resetAnimation() {
    _animation = Matrix4Tween(
      begin: _controller.value,
      end: Matrix4.identity(),
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeIn,
      ),
    );

    _animationController.forward(from: 0);
  }

  Widget _buildImage() {
    return InteractiveViewer(
      transformationController: _controller,
      clipBehavior: Clip.none,
      panEnabled: false,
      minScale: _minScale,
      maxScale: _maxScale,
      onInteractionStart: (details) {
        if (details.pointerCount < 2) {
          return;
        }

        if (_entry == null) {
          _showOverlay(context);
        }
      },
      onInteractionUpdate: (details) {
        if (_entry == null) {
          return;
        }

        _scale = details.scale;
        _entry!.markNeedsBuild();
      },
      onInteractionEnd: (details) {
        if (details.pointerCount != 1) {
          return;
        }

        _resetAnimation();
      },
      child: AspectRatio(
        aspectRatio: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.network(
            'https://picsum.photos/300/800',
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  void _showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject()! as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;
    _entry = OverlayEntry(
      builder: (context) {
        final opacity = ((_scale - 1) / (_maxScale - 1)).clamp(0, 1).toDouble();
        return Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: opacity,
                child: Container(
                  color: Colors.black,
                ),
              ),
            ),
            Positioned(
              left: offset.dx,
              top: offset.dy, // * 3 ?
              width: size.width,
              child: _buildImage(),
            ),
          ],
        );
      },
    );
    final overlay = Overlay.of(context)!;
    overlay.insert(_entry!);
  }

  void _removeOverlay() {
    _entry?.remove();
    _entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _buildImage(),
    );
  }
}
