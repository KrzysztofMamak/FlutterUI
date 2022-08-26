import 'package:flutter/material.dart';
import 'package:flutter_samples/animated_list/data.dart';
import 'package:flutter_samples/animated_list/list_item.dart';
import 'package:flutter_samples/animated_list/list_item_widget.dart';

class AnimatedListPage extends StatefulWidget {
  const AnimatedListPage({Key? key}) : super(key: key);

  @override
  _AnimatedListPageState createState() => _AnimatedListPageState();
}

class _AnimatedListPageState extends State<AnimatedListPage> {
  final _listKey = GlobalKey<AnimatedListState>();
  final List<ListItem> _items = List.from(listItems);

  void _removeItem(int index) {
    final removedItem = _items[index];
    _items.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
      duration: const Duration(milliseconds: 600),
      (context, animation) {
        return ListItemWidget(
          item: removedItem,
          animation: animation,
          onClicked: () {},
        );
      },
    );
  }

  void _insertItem() {
    final newIndex = 1;
    final newItem = ListItem(
      title: 'Pasta',
      urlImage:
          'https://images.unsplash.com/photo-1563379926898-05f4575a45d8?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
    );
    _items.insert(newIndex, newItem);
    _listKey.currentState!.insertItem(
      newIndex,
      duration: const Duration(milliseconds: 600),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animated List'),
        centerTitle: true,
      ),
      body: AnimatedList(
        key: _listKey,
        initialItemCount: _items.length,
        itemBuilder: (context, index, animation) {
          return ListItemWidget(
            item: _items[index],
            animation: animation,
            onClicked: () => _removeItem(index),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _insertItem,
        child: const Icon(Icons.add),
      ),
    );
  }
}
