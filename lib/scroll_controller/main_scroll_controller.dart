import 'package:flutter/material.dart';
import 'package:flutter_samples/main.dart';
import 'package:flutter_samples/scroll_controller/scroll_limit_reached.dart';
import 'package:flutter_samples/scroll_controller/scroll_movement.dart';
import 'package:flutter_samples/scroll_controller/scroll_status.dart';
import 'package:flutter_samples/scroll_controller/scroll_sync/scroll_sync.dart';

class MainScrollController extends StatelessWidget {
  void _onButtonTap(Widget page, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ScrollController / ScrollNotification'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: 'Scroll Limit Reached',
              onTap: () => _onButtonTap(ScrollLimitReached(), context),
            ),
            MyMenuButton(
              title: 'Scroll Movement',
              onTap: () => _onButtonTap(ScrollMovement(), context),
            ),
            MyMenuButton(
              title: 'Scroll Status',
              onTap: () => _onButtonTap(ScrollStatus(), context),
            ),
            MyMenuButton(
              title: 'Scroll Sync',
              onTap: () => _onButtonTap(ScrollSync(), context),
            ),
          ],
        ),
      ),
    );
  }
}
