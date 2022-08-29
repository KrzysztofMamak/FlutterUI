import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/album_flow/album_flow_page.dart';
import 'package:flutter_samples/apps_clone/android_messages/android_messages_page.dart';
import 'package:flutter_samples/apps_clone/credit_cards_concept/credit_card_concept_page.dart';
import 'package:flutter_samples/apps_clone/fitness_app/fitness_app_page.dart';
import 'package:flutter_samples/apps_clone/gmail/gmail_main_page.dart';
import 'package:flutter_samples/apps_clone/hotel_booking/hotel_booking_page.dart';
import 'package:flutter_samples/apps_clone/movies_concept/movies_concept_page.dart';
import 'package:flutter_samples/apps_clone/photo_concept/photo_concept_page.dart';
import 'package:flutter_samples/apps_clone/shoes_store/shoes_store_page.dart';
import 'package:flutter_samples/apps_clone/sports_store/sports_store_page.dart';
import 'package:flutter_samples/apps_clone/travel_concept/travel_concept_page.dart';
import 'package:flutter_samples/apps_clone/twitter_profile/twitter_profile_page.dart';
import 'package:flutter_samples/main.dart';

class MainAppsClone extends StatefulWidget {
  @override
  _MainAppsCloneState createState() => _MainAppsCloneState();
}

class _MainAppsCloneState extends State<MainAppsClone> {
  void _onButtonTap(Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Apps Clone'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Android Messages Page",
              onTap: () => _onButtonTap(AndroidMessagesPage()),
            ),
            MyMenuButton(
              title: "Twitter Profile Page",
              onTap: () => _onButtonTap(TwitterProfilePage()),
            ),
            MyMenuButton(
              title: "Movies Concept",
              onTap: () => _onButtonTap(MoviesConceptPage()),
            ),
            MyMenuButton(
              title: "Photo Concept",
              onTap: () => _onButtonTap(PhotoConceptPage()),
            ),
            MyMenuButton(
              title: "Sports Store",
              onTap: () => _onButtonTap(SportsStorePage()),
            ),
            MyMenuButton(
              title: "Shoes Store",
              onTap: () => _onButtonTap(ShoesStorePage()),
            ),
            MyMenuButton(
              title: "Album Flow",
              onTap: () => _onButtonTap(AlbumFlowPage()),
            ),
            MyMenuButton(
              title: "Credit Cards Concept",
              onTap: () => _onButtonTap(CreditCardConceptPage()),
            ),
            MyMenuButton(
              title: "Travel Concept",
              onTap: () => _onButtonTap(TravelConceptPage()),
            ),
            MyMenuButton(
              title: 'Hotel Booking',
              onTap: () => _onButtonTap(HotelBookingPage()),
            ),
            MyMenuButton(
              title: 'Fitness App',
              onTap: () => _onButtonTap(FitnessAppPage()),
            ),
            MyMenuButton(
              title: 'Gmail',
              onTap: () => _onButtonTap(GmailMainPage()),
            ),
          ],
        ),
      ),
    );
  }
}
