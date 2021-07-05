import 'package:flutter/material.dart';

class AndroidMessagesPage extends StatefulWidget {
  @override
  _AndroidMessagesPageState createState() => _AndroidMessagesPageState();
}

class _AndroidMessagesPageState extends State<AndroidMessagesPage> {
  bool _isGoingDown = true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          title: Text('Messages'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ],
        ),
        body: NotificationListener<ScrollNotification>(
          onNotification: (scrollNotification) {
            if (scrollNotification is ScrollUpdateNotification &&
                scrollNotification.scrollDelta != null) {
              if (scrollNotification.scrollDelta! <= 0.0) {
                if (!_isGoingDown) setState(() => _isGoingDown = true);
              } else {
                if (_isGoingDown) setState(() => _isGoingDown = false);
              }
            }
            return false;
          },
          child: _buildList(),
        ),
        floatingActionButton: MyFabButton(_isGoingDown),
      ),
    );
  }

  Widget _buildList() {
    return ListView(
      physics: ClampingScrollPhysics(),
      children: List.generate(30, (index) => 'Message ${index + 1}')
          .map((val) => SMSItem(
                number: '456',
                text: val,
              ))
          .toList(),
    );
  }
}

class MyFabButton extends StatelessWidget {
  final bool isExtend;

  MyFabButton(this.isExtend);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      child: RawMaterialButton(
        elevation: 5.0,
        shape: isExtend
            ? RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(25.0)))
            : CircleBorder(),
        onPressed: () {},
        fillColor: Colors.redAccent[400],
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: isExtend
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                    SizedBox(width: 5.0),
                    Text(
                      'Start chat',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              : const Icon(
                  Icons.message,
                  color: Colors.white,
                ),
        ),
      ),
    );
  }
}

class SMSItem extends StatelessWidget {
  final String number;
  final String text;

  SMSItem({
    required this.number,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 20.0,
        horizontal: 10.0,
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            child: Icon(Icons.person),
            foregroundColor: Colors.white,
            backgroundColor: Colors.redAccent[400],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    number,
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 17.0),
                  ),
                  Text(
                    text,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              'Sat',
              style: TextStyle(
                fontSize: 15.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
