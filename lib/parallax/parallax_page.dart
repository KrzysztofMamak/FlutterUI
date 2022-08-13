import 'package:flutter/material.dart';

class ParallaxPage extends StatelessWidget {
  const ParallaxPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parqallax'),
      ),
      backgroundColor: Colors.black,
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) => ItemWidget(index: index),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  ItemWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  final _keyImage = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: Flow(
        delegate: ParallaxFlowDelegate(
          scrollable: Scrollable.of(context)!,
          itemContext: context,
          keyImage: _keyImage,
        ),
        children: [
          Image.network(
            'https://picsum.photos/30${index % 5}/800',
            fit: BoxFit.cover,
            key: _keyImage,
          ),
        ],
      ),
    );
  }
}

class ParallaxFlowDelegate extends FlowDelegate {
  final ScrollableState scrollable;
  final BuildContext itemContext;
  final GlobalKey keyImage;

  ParallaxFlowDelegate({
    required this.scrollable,
    required this.itemContext,
    required this.keyImage,
  }) : super(repaint: scrollable.position);

  @override
  BoxConstraints getConstraintsForChild(int i, BoxConstraints constraints) {
    return BoxConstraints.tightFor(width: constraints.maxWidth);
  }

  @override
  void paintChildren(FlowPaintingContext context) {
    final scrollableBox = scrollable.context.findRenderObject() as RenderBox;
    final itemBox = itemContext.findRenderObject() as RenderBox;
    final itemOffset = itemBox.localToGlobal(
      itemBox.size.centerLeft(Offset.zero),
      ancestor: scrollableBox,
    );
    final viewportDimension = scrollable.position.viewportDimension;
    final scrollFraction = (itemOffset.dy / viewportDimension).clamp(0, 1);

    final verticalAlignment = Alignment(0, scrollFraction * 2 - 1);

    final imageBox = keyImage.currentContext!.findRenderObject() as RenderBox;
    final childRect = verticalAlignment.inscribe(
      imageBox.size,
      Offset.zero & context.size,
    );

    context.paintChild(
      0,
      transform: Transform.translate(
        offset: Offset(0, childRect.top),
      ).transform,
    );
  }

  @override
  bool shouldRepaint(ParallaxFlowDelegate oldDelegate) {
    return scrollable != oldDelegate.scrollable ||
        itemContext != oldDelegate.itemContext ||
        keyImage != oldDelegate.keyImage;
  }
}
