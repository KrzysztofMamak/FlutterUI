import 'package:flutter/material.dart';
import 'package:flutter_samples/animations/list_details/character.dart';
import 'package:flutter_samples/animations/list_details/details_page.dart';

class ListPage extends StatefulWidget {
  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  late final PageController _pageController;

  void _goToDetails(Character character) {
    final page = DetailsPage(character: character);
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              return Opacity(
                opacity: animation.value,
                child: page,
              );
            },
          );
        },
        transitionDuration: Duration(milliseconds: 400),
      ),
    );
  }

  void _pageListener() => setState(() {});

  @override
  void initState() {
    _pageController = PageController(viewportFraction: 0.6);
    _pageController.addListener(_pageListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_pageListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dragon Ball'),
        backgroundColor: Colors.black54,
      ),
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        controller: _pageController,
        itemCount: characters.length,
        itemBuilder: (context, index) {
          double currentPage = 0.0;
          try {
            currentPage = _pageController.page!;
          } catch (_) {}
          final resizeFactor =
              1 - (((currentPage - index).abs() * 0.3).clamp(0.0, 1.0));
          final currentCharacter = characters[index];
          return ListItem(
            character: currentCharacter,
            resizeFactor: resizeFactor,
            onTap: () => _goToDetails(currentCharacter),
          );
        },
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final Character character;
  final double resizeFactor;
  final VoidCallback onTap;

  const ListItem({
    Key? key,
    required this.character,
    required this.resizeFactor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.4;
    double width = MediaQuery.of(context).size.width * 0.85;
    return InkWell(
      onTap: onTap,
      child: Align(
        alignment: Alignment.topCenter,
        child: Container(
          width: width * resizeFactor,
          height: height * resizeFactor,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 0.0,
                right: 0.0,
                top: height / 4,
                bottom: 0.0,
                child: Hero(
                  tag: 'background_${character.title}',
                  child: Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 10.0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: <Color>[
                            Color(character.color),
                            Colors.white,
                          ],
                          stops: <double>[
                            0.4,
                            1.0,
                          ],
                        ),
                      ),
                      child: Container(
                        alignment: Alignment.bottomLeft,
                        margin: EdgeInsets.only(left: 20.0, bottom: 10.0),
                        child: Text(
                          character.title,
                          style: TextStyle(
                            fontSize: 24 * resizeFactor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: Hero(
                  tag: 'image_${character.title}',
                  child: Image.asset(
                    character.avatar,
                    width: width / 2,
                    height: height,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
