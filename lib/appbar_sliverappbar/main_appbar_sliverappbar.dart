import 'package:flutter/material.dart';
import 'package:flutter_samples/appbar_sliverappbar/sample1.dart';
import 'package:flutter_samples/appbar_sliverappbar/sample2.dart';
import 'package:flutter_samples/appbar_sliverappbar/sample3.dart';
import 'package:flutter_samples/main.dart';

final kBackgroundColor = Color(0xFF191719);

class Song {
  final String title;
  final String image;

  const Song({
    required this.title,
    required this.image,
  });
}

const songs = <Song>[
  Song(
    title: 'Wake Me Up',
    image: 'https://i.ytimg.com/vi/ssRPuC-w2M4/hqdefault.jpg',
  ),
  Song(
    title: 'SOS (feat. Aloe Blacc)',
    image:
        'https://lifestyle.americaeconomia.com/sites/lifestyle.americaeconomia.com/files/styles/600x600/public/avicii_sos_0.jpg',
  ),
  Song(
    title: 'Without You (feat. Sandro Cavazza)',
    image:
        'https://d2tml28x3t0b85.cloudfront.net/tracks/artworks/000/631/866/original/c42c03.jpeg?1507101208',
  ),
];

class MainAppBarSliverAppBar extends StatelessWidget {
  void _onButtonTap(Widget page, BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AppBar & SliverAppBar'),
      ),
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: ListView(
          children: <Widget>[
            MyMenuButton(
              title: "Sample 1 - AppBar",
              onTap: () => _onButtonTap(Sample1(), context),
            ),
            MyMenuButton(
              title: "Sample 2 - SliverAppBar",
              onTap: () => _onButtonTap(Sample2(), context),
            ),
            MyMenuButton(
              title: "Sample 3 - SliverAppBar with Strech",
              onTap: () => _onButtonTap(Sample3(), context),
            ),
          ],
        ),
      ),
    );
  }
}
