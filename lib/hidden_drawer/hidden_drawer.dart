import 'package:flutter/material.dart';
import 'package:flutter_samples/hidden_drawer/hidden_drawer_item.dart';
import 'package:flutter_samples/hidden_drawer/hidden_drawer_items.dart';

class HiddenDrawer extends StatelessWidget {
  const HiddenDrawer({
    Key? key,
    required this.onItemSelected,
  }) : super(key: key);

  final ValueChanged<HiddenDrawerItem> onItemSelected;

  Widget _buildDrawerItems(BuildContext context) {
    return Column(
      children: HiddenDrawerItems.all
          .map(
            (item) => ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 8,
              ),
              leading: Icon(item.icon, color: Colors.white),
              title: Text(
                item.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              onTap: () => onItemSelected(item),
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildDrawerItems(context),
          ],
        ),
      ),
    );
  }
}
