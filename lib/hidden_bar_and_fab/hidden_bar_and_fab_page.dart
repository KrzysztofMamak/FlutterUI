import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HiddenBarAndFabPage extends StatefulWidget {
  const HiddenBarAndFabPage({Key? key}) : super(key: key);

  @override
  _HiddenBarAndFabPageState createState() => _HiddenBarAndFabPageState();
}

class _HiddenBarAndFabPageState extends State<HiddenBarAndFabPage> {
  bool _isFabVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              floating: true,
              snap: true,
              title: const Text('Hidden Bar and Fab'),
            ),
          ];
        },
        body: NotificationListener<UserScrollNotification>(
          onNotification: (notification) {
            if (notification.direction == ScrollDirection.forward) {
              if (!_isFabVisible) {
                setState(() {
                  _isFabVisible = true;
                });
              }
            } else if (notification.direction == ScrollDirection.reverse) {
              if (_isFabVisible) {
                setState(() {
                  _isFabVisible = false;
                });
              }
            }
            return true;
          },
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: 35,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(
                  'Item ${index + 1}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: _isFabVisible
          ? FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.add),
            )
          : null,
    );
  }
}
