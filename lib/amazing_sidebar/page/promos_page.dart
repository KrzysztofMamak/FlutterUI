import 'package:flutter/material.dart';
import 'package:flutter_samples/amazing_sidebar/menu_widget.dart';

class PromosPage extends StatelessWidget {
  const PromosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: const Text('Promos Page'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.card_giftcard),
            const SizedBox(height: 30),
            const Text(
              'Promo',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
