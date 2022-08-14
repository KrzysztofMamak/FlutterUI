import 'package:flutter/material.dart';
import 'package:flutter_samples/amazing_sidebar/menu_widget.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Help Page'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.help),
            const SizedBox(height: 30),
            const Text(
              'Help',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
