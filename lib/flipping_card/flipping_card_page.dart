import 'package:flutter/material.dart';
import 'package:flutter_samples/flipping_card/flip_card_widget.dart';

class FlippingCardPage extends StatefulWidget {
  const FlippingCardPage({Key? key}) : super(key: key);

  @override
  _FlippingCardPageState createState() => _FlippingCardPageState();
}

class _FlippingCardPageState extends State<FlippingCardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flipping Card'),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: FlipCardWidget(
          front: Image.asset('assets/flipping_card/front.png'),
          back: Image.asset('assets/flipping_card/back.png'),
        ),
      ),
    );
  }
}
