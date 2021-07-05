import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/credit_cards_concept/credit_card.dart';
import 'package:flutter_samples/apps_clone/credit_cards_concept/credit_card_concept_details_page.dart';
import 'package:flutter_samples/apps_clone/credit_cards_concept/credit_card_widget.dart';

class CreditCardConceptPage extends StatelessWidget {
  final pageNotifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    int _lastPage = 0;
    final textTheme = Theme.of(context).textTheme;
    const padding = EdgeInsets.all(18.0);

    return Theme(
      data: ThemeData.dark().copyWith(
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
      ),
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: padding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bank Cards',
                    style: textTheme.headline4!.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Balance',
                    style: textTheme.subtitle2!.copyWith(color: Colors.grey),
                  ),
                  const SizedBox(height: 3),
                  ValueListenableBuilder<int>(
                    valueListenable: pageNotifier,
                    builder: (context, snapshot, _) {
                      final currentCard = creditCards[snapshot];
                      final lastCard = creditCards[_lastPage];
                      return TweenAnimationBuilder<double>(
                        tween: Tween<double>(
                          begin: lastCard.amount,
                          end: currentCard.amount,
                        ),
                        duration: const Duration(milliseconds: 500),
                        builder: (_, value, ___) => Text(
                          value.toStringAsFixed(2),
                          style: textTheme.headline6!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                scrollDirection: Axis.horizontal,
                onPageChanged: (page) {
                  _lastPage = pageNotifier.value;
                  pageNotifier.value = page;
                },
                controller: PageController(viewportFraction: 0.7),
                physics: const BouncingScrollPhysics(),
                itemCount: creditCards.length,
                itemBuilder: (_, index) => Align(
                  child: Transform.translate(
                    offset: Offset(-30.0, 0.0),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: CreditCardWidget(
                        onTap: () {
                          final page = CreditCardsConceptDetailsPage(
                            card: creditCards[index],
                          );
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (BuildContext context,
                                  Animation<double> animation, _) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: page,
                                );
                              },
                              transitionDuration: Duration(milliseconds: 900),
                            ),
                          );
                        },
                        card: creditCards[index],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
      ),
    );
  }
}
