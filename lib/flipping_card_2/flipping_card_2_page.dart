import 'package:flutter/material.dart';
import 'package:flutter_samples/flipping_card_2/flip_card_widget.dart';

class FlippingCard2Page extends StatefulWidget {
  const FlippingCard2Page({Key? key}) : super(key: key);

  @override
  _FlippingCard2PageState createState() => _FlippingCard2PageState();
}

class _FlippingCard2PageState extends State<FlippingCard2Page> {
  final _controller = FlipCardController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flipping Card 2'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(32),
        children: [
          FlipCardWidget(
            controller: _controller,
            front: Image.asset('assets/flipping_card/front.png'),
            back: Image.asset('assets/flipping_card/back.png'),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text('Flip Card'),
            onPressed: () async {
              await _controller.flipCard();
            },
          ),
        ],
      ),
    );
  }
}
