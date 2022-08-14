import 'package:flutter/material.dart';
import 'package:flutter_samples/amazing_sidebar/menu_widget.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('About Us Page'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline),
            const SizedBox(height: 30),
            const Text(
              'About Us',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
