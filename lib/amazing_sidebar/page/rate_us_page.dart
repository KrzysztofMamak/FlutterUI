import 'package:flutter/material.dart';
import 'package:flutter_samples/amazing_sidebar/menu_widget.dart';

class RateUsPage extends StatelessWidget {
  const RateUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: const Text('Rate Us Page'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.star_border),
            const SizedBox(height: 30),
            const Text(
              'Rate Us',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
