import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/gmail/slide_list_tile.dart';

class EmailListPage extends StatefulWidget {
  const EmailListPage({Key? key}) : super(key: key);

  @override
  _EmailListPageState createState() => _EmailListPageState();
}

class _EmailListPageState extends State<EmailListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gmail'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: 20,
        itemBuilder: (context, index) {
          final number = index + 1;
          return SlideListTile(
            child: Container(
              color: Colors.grey[800],
              child: ListTile(
                title: Text('Title $number'),
                subtitle: Text('Subtitle $number'),
              ),
            ),
          );
        },
      ),
    );
  }
}
