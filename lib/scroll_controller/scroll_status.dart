import 'package:flutter/material.dart';

class ScrollStatus extends StatefulWidget {
  @override
  _ScrollStatusState createState() => _ScrollStatusState();
}

class _ScrollStatusState extends State<ScrollStatus> {
  String message = '';

  void _onStartScroll(ScrollMetrics metrics) =>
      setState(() => message = 'Scroll Start');

  void _onUpdateScroll(ScrollMetrics metrics) =>
      setState(() => message = 'Scroll Update');

  void _onEndScroll(ScrollMetrics metrics) =>
      setState(() => message = 'Scroll End');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Status'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(child: Text(message)),
          ),
          Expanded(
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollNotification) {
                  _onStartScroll(scrollNotification.metrics);
                } else if (scrollNotification is ScrollUpdateNotification) {
                  _onUpdateScroll(scrollNotification.metrics);
                } else if (scrollNotification is ScrollEndNotification) {
                  _onEndScroll(scrollNotification.metrics);
                }
                return false;
              },
              child: ListView.builder(
                itemCount: 30,
                itemBuilder: (context, index) {
                  return ListTile(title: Text('Index : $index'));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
