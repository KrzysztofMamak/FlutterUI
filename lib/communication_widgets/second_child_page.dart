import 'package:flutter/material.dart';
import 'package:flutter_samples/communication_widgets/parent_page.dart';

class SecondChildPage extends StatefulWidget {
  final String? title;

  const SecondChildPage({
    Key? key,
    this.title,
  }) : super(key: key);

  @override
  _SecondChildPageState createState() => _SecondChildPageState();
}

class _SecondChildPageState extends State<SecondChildPage> {
  final value = "Page 2";
  
  @override
  Widget build(BuildContext context) {
    final title = ParentProvider.of(context).title;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).primaryTextTheme.headline5,
          ),
        ],
      ),
    );
  }
}
