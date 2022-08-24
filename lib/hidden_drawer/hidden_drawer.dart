import 'package:flutter/material.dart';
import 'package:flutter_samples/hidden_drawer/hidden_drawer_items.dart';

class HiddenDrawer extends StatelessWidget {
  const HiddenDrawer({Key? key}) : super(key: key);

  Widget _buildDrawerItems() {
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
                  fontSize: 24,
                ),
              ),
              onTap: () {},
            ),
          )
          .toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildDrawerItems(),
        ],
      ),
    );
  }
}
