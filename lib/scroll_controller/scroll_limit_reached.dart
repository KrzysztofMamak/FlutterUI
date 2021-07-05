import 'package:flutter/material.dart';

class ScrollLimitReached extends StatefulWidget {
  @override
  _ScrollLimitReachedState createState() => _ScrollLimitReachedState();
}

class _ScrollLimitReachedState extends State<ScrollLimitReached> {
  late ScrollController _scrollController;
  String message = '';

  void _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() => message = 'reach the bottom');
    }
    if (_scrollController.offset <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() => message = 'reach the top');
    }
  }

  @override
  void initState() {
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scroll Limit reached'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 50.0,
            color: Colors.green,
            child: Center(child: Text(message)),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: 30,
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
