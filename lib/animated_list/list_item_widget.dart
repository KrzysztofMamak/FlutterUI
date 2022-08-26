import 'package:flutter/material.dart';
import 'package:flutter_samples/animated_list/list_item.dart';

class ListItemWidget extends StatelessWidget {
  const ListItemWidget({
    Key? key,
    required this.item,
    required this.animation,
    this.onClicked,
  }) : super(key: key);

  final ListItem item;
  final Animation<double> animation;
  final VoidCallback? onClicked;

  Widget _buildItem() {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: CircleAvatar(
          radius: 32,
          backgroundImage: NetworkImage(item.urlImage),
        ),
        title: Text(
          item.title,
          style: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        trailing: IconButton(
          onPressed: onClicked,
          icon: Icon(
            Icons.delete,
            color: Colors.red,
            size: 32,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: Offset(-1, 0),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
        ),
      ),
      child: _buildItem(),
    );
    // return SizeTransition(
    //   key: ValueKey(item.urlImage),
    //   sizeFactor: animation,
    //   child: _buildItem(),
    // );
  }
}
