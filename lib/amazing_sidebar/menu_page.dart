import 'package:flutter/material.dart' hide MenuItem;
import 'package:flutter_samples/amazing_sidebar/menu_item.dart';

// TODO -> fix - put pages layer on the top

class MenuItems {
  static const payment = MenuItem('Payment', Icons.payment);
  static const promos = MenuItem('Promo', Icons.card_giftcard);
  static const notifications = MenuItem('Notifications', Icons.notifications);
  static const help = MenuItem('Help', Icons.help);
  static const aboutUs = MenuItem('About us', Icons.info_outline);
  static const rateUs = MenuItem('Rate us', Icons.star_border);

  static const all = [
    payment,
    promos,
    notifications,
    help,
    aboutUs,
    rateUs,
  ];
}

class MenuPage extends StatelessWidget {
  const MenuPage({
    Key? key,
    required this.currentItem,
    required this.onSelectedItem,
  }) : super(key: key);

  final MenuItem currentItem;
  final ValueChanged<MenuItem> onSelectedItem;

  Widget _buildMenuItem(MenuItem item) {
    return ListTileTheme(
      selectedColor: Colors.white,
      child: ListTile(
        selectedTileColor: Colors.black26,
        selected: currentItem == item,
        minLeadingWidth: 20,
        leading: Icon(item.icon),
        title: Text(item.title),
        onTap: () => onSelectedItem(item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              ...MenuItems.all.map(_buildMenuItem).toList(),
              Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}
