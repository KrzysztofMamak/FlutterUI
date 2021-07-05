import 'package:flutter/material.dart';

class ScrollMovement extends StatefulWidget {
  @override
  _ScrollMovementState createState() => _ScrollMovementState();
}

class _ScrollMovementState extends State<ScrollMovement> {
  late ScrollController _scrollController;
  final itemSize = 100.0;

  void _moveUp() {
    _scrollController.animateTo(
      _scrollController.offset - itemSize,
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  void _moveDown() {
    _scrollController.animateTo(
      _scrollController.offset + itemSize,
      duration: Duration(milliseconds: 500),
      curve: Curves.linear,
    );
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Movement'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: _moveUp,
                    child: Text('up'),
                  ),
                  ElevatedButton(
                    onPressed: _moveDown,
                    child: Text('down'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 30,
              itemExtent: itemSize,
              itemBuilder: (context, index) {
                return ListTile(title: Text('Index : $index'));
              },
            ),
          ),
        ],
      ),
    );
  }
}
