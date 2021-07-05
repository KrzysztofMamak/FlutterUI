import 'package:flutter/material.dart';
import 'package:flutter_samples/animations/neon_button/neon_button.dart';

const kSeparator = SizedBox(height: 50.0);

class NeonButtonMain extends StatefulWidget {
  @override
  _NeonButtonMainState createState() => _NeonButtonMainState();
}

class _NeonButtonMainState extends State<NeonButtonMain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Neon Buttons'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => setState(() {}),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            kSeparator,
            NeonButton(
              text: 'BUTTON SAMPLE BLUE',
              color: Colors.blue,
              onTap: () => print('Blue pressed'),
            ),
            NeonButton(
              text: 'BUTTON SAMPLE RED',
              color: Colors.red,
              onTap: () => print('Red pressed'),
            ),
            NeonButton(
              text: 'BUTTON SAMPLE GREEN',
              color: Colors.green,
              onTap: () => print('Green pressed'),
            ),
            NeonButton(
              text: 'BUTTON SAMPLE YELLOW',
              color: Colors.yellow,
              onTap: () => print('Yellow pressed'),
            ),
            kSeparator,
          ],
        ),
      ),
    );
  }
}