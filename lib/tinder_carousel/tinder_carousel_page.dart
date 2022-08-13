import 'package:flutter/material.dart';
import 'package:flutter_samples/tinder_carousel/card_provider.dart';
import 'package:flutter_samples/tinder_carousel/tinder_card.dart';
import 'package:provider/provider.dart';

class TinderCarouselPage extends StatefulWidget {
  const TinderCarouselPage({Key? key}) : super(key: key);

  @override
  _TinderCarouselPageState createState() => _TinderCarouselPageState();
}

class _TinderCarouselPageState extends State<TinderCarouselPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CardProvider>(
      create: (context) => CardProvider(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tinder Carousel'),
        ),
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(16),
          child: CardsWidget(),
        ),
      ),
    );
  }
}

class CardsWidget extends StatelessWidget {
  const CardsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CardProvider>(context);
    final urlImages = provider.urlImages;

    return Stack(
      children: urlImages
          .map(
            (urlImage) => TinderCard(
              urlImage: urlImage,
              isFront: urlImages.last == urlImage,
            ),
          )
          .toList(),
    );
  }
}
