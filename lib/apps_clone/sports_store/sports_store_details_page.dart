import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/sports_store/sports_store_page.dart';

class SportsStoreDetailsPage extends StatelessWidget {
  final Ball ball;

  const SportsStoreDetailsPage({
    Key? key,
    required this.ball,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0.0,
              right: 0.0,
              width: size.width / 2.5,
              height: size.height / 1.8,
              child: Hero(
                tag: 'hero_background_${ball.name}',
                child: Container(
                  decoration: BoxDecoration(
                    color: ball.color,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 30,
              top: 100,
              child: Hero(
                tag: 'hero_text_${ball.name}',
                child: Material(
                  color: Colors.transparent,
                  child: Text(
                    ball.name.split(' ').join('\n'),
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 30.0,
              top: size.height / 4,
              child: Hero(
                tag: 'hero_ball_${ball.name}',
                child: Image.asset(
                  ball.image,
                  height: MediaQuery.of(context).size.height / 2.2,
                ),
              ),
            ),
            Positioned(
              left: 20.0,
              top: 40.0,
              child: BackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
