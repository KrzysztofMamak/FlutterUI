import 'package:flutter/material.dart';
import 'package:flutter_samples/bouncing_cards/card_widget.dart';
import 'package:flutter_samples/bouncing_cards/data.dart';
import 'package:flutter_samples/bouncing_cards/shake_animation.dart';

class BouncingCardsPage extends StatefulWidget {
  const BouncingCardsPage({Key? key}) : super(key: key);

  @override
  _BouncingCardsPageState createState() => _BouncingCardsPageState();
}

class _BouncingCardsPageState extends State<BouncingCardsPage> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      viewportFraction: 0.8,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: const Text('Bouncing Cards'),
        foregroundColor: Colors.white,
        backgroundColor: Colors.orange[600],
      ),
      body: PageView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: Data.cards.length,
        controller: _pageController,
        itemBuilder: (context, index) {
          final cardData = Data.cards[index];
          final card = Container(
            padding: const EdgeInsets.all(8),
            child: CardWidget(
              title: cardData.title,
              description: cardData.description,
              color: cardData.color,
              subtitle: cardData.subtitle,
              urlImage: cardData.imgUrl,
            ),
          );
          if (_currentIndex == index) {
            return LeftRightShake(
              child: card,
            );
          } else {
            return RightLeftShake(
              child: card,
            );
          }
          return card;
        },
        onPageChanged: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
