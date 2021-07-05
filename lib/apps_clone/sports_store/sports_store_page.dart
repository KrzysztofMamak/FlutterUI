import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/sports_store/sports_store_details_page.dart';

const kLeftMargin = 40.0;

class Ball {
  final int price;
  final String model;
  final String name;
  final String image;
  final Color color;
  final Color textColor;

  const Ball({
    required this.price,
    required this.model,
    required this.name,
    required this.image,
    required this.color,
    required this.textColor,
  });
}

const balls = [
  const Ball(
    price: 24,
    name: 'Nike Strike',
    model: 'Armory Black',
    color: Colors.black,
    textColor: Colors.white,
    image: 'assets/balls/ball1.png',
  ),
  const Ball(
    price: 30,
    name: 'UEFA CL 18',
    model: 'UEFA blue',
    color: Color(0xFF07205A),
    textColor: Colors.white,
    image: 'assets/balls/ball2.png',
  ),
  const Ball(
    price: 31,
    name: 'Nike Strike X',
    model: 'UEFA Turquoise',
    color: Color(0xFF6EE897),
    textColor: Colors.black,
    image: 'assets/balls/ball3.png',
  ),
  const Ball(
    price: 40,
    name: 'Adidas beau jeu',
    model: 'UEFA 2016',
    color: Color(0xFF743AD6),
    textColor: Colors.white,
    image: 'assets/balls/ball4.png',
  ),
];

class SportsStorePage extends StatefulWidget {
  @override
  _SportsStorePageState createState() => _SportsStorePageState();
}

class _SportsStorePageState extends State<SportsStorePage> {
  final _priceNotifier = ValueNotifier<int>(balls.first.price);
  final _pageController = PageController(viewportFraction: 0.9);
  final _pageNotifier = ValueNotifier<double>(0.0);

  Widget _buildHeader() {
    Widget _buildGroup(bool selected, IconData icon) {
      return Row(
        children: <Widget>[
          Icon(
            icon,
            color: selected ? Colors.black : Colors.grey[300],
            size: 13,
          ),
          const SizedBox(width: 3),
          Text(
            'Soccer ball',
            style: TextStyle(
              fontSize: 13,
              color: selected ? Colors.black : Colors.grey,
            ),
          ),
          const SizedBox(height: 10),
        ],
      );
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: kLeftMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Sports store',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 26,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: IconButton(
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[400],
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: kLeftMargin),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Row(children: [
                _buildGroup(true, Icons.battery_charging_full),
                const SizedBox(
                  width: 20,
                ),
                _buildGroup(false, Icons.shopping_basket),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey[300],
      elevation: 4,
      type: BottomNavigationBarType.fixed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.home),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.shopping_basket),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.shopping_cart),
        ),
        BottomNavigationBarItem(
          label: '',
          icon: Icon(Icons.wb_sunny),
        )
      ],
    );
  }

  Widget _buildBottomWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: kLeftMargin),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              backgroundImage: AssetImage('assets/mesi.png'),
            ),
            title: Text(
              'Lionel Messi',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: Text('Barcelona'),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  void _listener() {
    _pageNotifier.value = _pageController.page!;
    setState(() {});
  }

  @override
  void initState() {
    lastPrice = balls.first.price;
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      _pageController.addListener(_listener);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_listener);
    _pageController.dispose();
    _pageNotifier.dispose();
    _priceNotifier.dispose();
    super.dispose();
  }

  int lastPrice = 0;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.light(),
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: <Widget>[
              _buildHeader(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 46.0),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                        left: 0,
                        top: 0,
                        width: MediaQuery.of(context).size.width / 3,
                        bottom: 20,
                        child: Padding(
                          padding: const EdgeInsets.only(left: kLeftMargin),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Spacer(),
                              ValueListenableBuilder<int>(
                                  valueListenable: _priceNotifier,
                                  builder: (context, value, child) {
                                    return TweenAnimationBuilder<int>(
                                      duration:
                                          const Duration(milliseconds: 200),
                                      tween: IntTween(
                                        begin: lastPrice,
                                        end: value,
                                      ),
                                      builder:
                                          (context, animationValue, child) {
                                        return Text(
                                          "\$$animationValue",
                                          style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.grey[700],
                                          ),
                                        );
                                      },
                                    );
                                  }),
                              Spacer(),
                              Text(
                                'Available size',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: Colors.grey[400],
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                height: 30,
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        child: Text(
                                          '3',
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        child: Text(
                                          '4',
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: OutlinedButton(
                                        onPressed: () {},
                                        child: Text(
                                          '5',
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ValueListenableBuilder<double>(
                        valueListenable: _pageNotifier,
                        builder: (context, value, child) {
                          return PageView.builder(
                            controller: _pageController,
                            itemCount: balls.length,
                            onPageChanged: (index) {
                              _priceNotifier.value = balls[index].price;
                              lastPrice = balls[index].price;
                            },
                            itemBuilder: (context, index) {
                              final lerp = lerpDouble(
                                  1, 0, (index - _pageNotifier.value).abs())!;

                              double opacity = lerpDouble(1.0, 0.0,
                                  (index - _pageNotifier.value).abs())!;
                              opacity = opacity < 0 ? 0 : opacity;

                              return Opacity(
                                opacity: opacity,
                                child: Stack(
                                  fit: StackFit.expand,
                                  children: <Widget>[
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 20),
                                            child: Hero(
                                              tag:
                                                  'hero_text_${balls[index].name}',
                                              child: Material(
                                                color: Colors.transparent,
                                                child: Text(
                                                  balls[index]
                                                      .name
                                                      .split(" ")
                                                      .join("\n"),
                                                  maxLines: 2,
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w700,
                                                    color: Colors.black,
                                                    fontSize: 24,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                PageRouteBuilder(
                                                  transitionDuration:
                                                      const Duration(
                                                          milliseconds: 800),
                                                  pageBuilder:
                                                      (_, animation, __) {
                                                    return FadeTransition(
                                                      opacity: animation,
                                                      child:
                                                          SportsStoreDetailsPage(
                                                        ball: balls[index],
                                                      ),
                                                    );
                                                  },
                                                ),
                                              );
                                            },
                                            child: Hero(
                                              tag:
                                                  'hero_background_${balls[index].name}',
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: balls[index].color,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20.0),
                                                ),
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomLeft,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            30),
                                                    child: Material(
                                                      color: Colors.transparent,
                                                      child: Text(
                                                        balls[index]
                                                            .model
                                                            .split(" ")
                                                            .join("\n"),
                                                        maxLines: 2,
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                          color: balls[index]
                                                              .textColor,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Transform.scale(
                                        alignment: Alignment.centerRight,
                                        scale: lerp,
                                        child: Hero(
                                          tag: 'hero_ball_${balls[index].name}',
                                          child: Image.asset(
                                            balls[index].image,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
              _buildBottomWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
