import 'package:flutter/material.dart';
import 'package:flutter_samples/amazing_sidebar/menu_widget.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Payment Page'),
        leading: MenuWidget(),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.payment),
            const SizedBox(height: 30),
            const Text(
              'Payment',
              style: TextStyle(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
