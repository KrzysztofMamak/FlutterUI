import 'package:flutter/material.dart';
import 'package:flutter_samples/transition_animations/custom_page_route.dart';
import 'package:flutter_samples/transition_animations/test_page.dart';

class TransitionAnimationsPage extends StatelessWidget {
  const TransitionAnimationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).push(
                CustomPageRoute(
                  direction: AxisDirection.up,
                  child: TestPage(),
                ),
              ),
              child: const Text('Up'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                CustomPageRoute(
                  direction: AxisDirection.right,
                  child: TestPage(),
                ),
              ),
              child: const Text('Right'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                CustomPageRoute(
                  direction: AxisDirection.down,
                  child: TestPage(),
                ),
              ),
              child: const Text('Down'),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => Navigator.of(context).push(
                CustomPageRoute(
                  direction: AxisDirection.left,
                  child: TestPage(),
                ),
              ),
              child: const Text('Left'),
            ),
          ],
        ),
      ),
    );
  }
}
