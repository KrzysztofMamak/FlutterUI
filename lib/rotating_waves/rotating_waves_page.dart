import 'package:flutter/material.dart';
import 'package:flutter_samples/rotating_waves/rotating_waves.dart';

class RotatingWavesPage extends StatelessWidget {
  const RotatingWavesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rotating Waves'),
      ),
      body: Center(
        child: CustomCircleProgressIndicator(),
      ),
    );
  }
}
