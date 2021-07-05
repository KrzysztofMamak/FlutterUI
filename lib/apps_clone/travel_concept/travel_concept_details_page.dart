import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/travel_concept/travel_concept_page.dart';

class TravelConceptDetailsPage extends StatelessWidget {
  final LocationCard location;

  const TravelConceptDetailsPage({
    Key? key,
    required this.location,
  }) : super(key: key);

  void _onVerticalDrag(
    DragUpdateDetails details,
    BuildContext context,
  ) {
    if (details.primaryDelta! > 3.0) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GestureDetector(
            onVerticalDragUpdate: (details) =>
                _onVerticalDrag(details, context),
            child: Hero(
              tag: location.title,
              child: Image.network(
                location.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          ...List.generate((20), (index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(avatars.last),
                  radius: 15,
                ),
                title: Text('The Dart Side'),
                subtitle: Text(
                    'Come to the Dart Side :) ..... $index\nline 22222 \nline 33'),
              ),
            );
          })
        ],
      ),
    );
  }
}
