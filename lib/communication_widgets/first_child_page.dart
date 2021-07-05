import 'package:flutter/material.dart';
import 'package:flutter_samples/communication_widgets/parent_page.dart';

class FirstChildPage extends StatefulWidget {
  final String title;
  final ValueChanged<String> child2Action3;
  final ValueChanged<String> child2Action2;

  const FirstChildPage({
    Key? key,
    required this.title,
    required this.child2Action3,
    required this.child2Action2,
  }) : super(key: key);

  @override
  _FirstChildPageState createState() => _FirstChildPageState();
}

class _FirstChildPageState extends State<FirstChildPage> {
  String value = 'Page 1';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Text(
            widget.title,
            style: Theme.of(context).primaryTextTheme.headline5,
          ),
          ElevatedButton(
            child: Text("Action 2"),
            onPressed: () => widget.child2Action2("Update from Child 1"),
          ),
          ElevatedButton(
            child: Text("Action 3"),
            onPressed: () => widget.child2Action3("Update from Child 1"),
          ),
          ElevatedButton(
            child: Text("Action 4"),
            onPressed: () {
              final controller = ParentProvider.of(context).tabController;
              controller.index = 1;
            },
          ),
        ],
      ),
    );
  }
}
