import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/album_flow/album.dart';
import 'package:flutter_samples/apps_clone/album_flow/album_flow_details_page.dart';
import 'package:flutter_samples/apps_clone/album_flow/album_image.dart';
import 'package:vector_math/vector_math.dart' as vector;

const _itemHeight = 220.0;
const _itemFactor = 0.6;

class AlbumFlowPage extends StatefulWidget {
  @override
  _AlbumFlowPageState createState() => _AlbumFlowPageState();
}

class _AlbumFlowPageState extends State<AlbumFlowPage> {
  late final _pageController;
  final _pageNotifier = ValueNotifier<double>(0.0);
  int _numberOfElements = 30;

  void _scrollListener() => _pageNotifier.value = _pageController.offset;

  Future<List<Album>> _loadData() async {
    await Future.delayed(Duration(seconds: 2));
    return albumsData;
  }

  void _onTapAlbum(String imageUrl, double angle) {
    final page = AlbumFlowDetailsPage(imageUrl: imageUrl, angle: angle);
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) {
          return FadeTransition(
            opacity: animation,
            child: page,
          );
        },
        transitionDuration: Duration(milliseconds: 700),
      ),
    );
  }

  @override
  void initState() {
    _pageController = PageController()..addListener(_scrollListener);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.removeListener(_scrollListener);
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            FutureBuilder<List<Album>>(
              future: _loadData(),
              builder: (context, snapshot) {
                return Positioned.fill(
                  child: snapshot.hasData
                      ? ValueListenableBuilder<double>(
                          valueListenable: _pageNotifier,
                          builder: (context, value, child) {
                            return ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.only(
                                top: 100.0,
                                left: 25.0,
                                right: 25.0,
                              ),
                              controller: _pageController,
                              itemCount: snapshot.data!.length,
                              itemBuilder: (context, index) {
                                final t =
                                    (index * _itemHeight * _itemFactor - value)
                                            .abs() /
                                        _numberOfElements;
                                final rotationY =
                                    lerpDouble(0.0, 5, t)! - 360.0;
                                return Align(
                                  alignment: Alignment.center,
                                  heightFactor: _itemFactor,
                                  child: Transform(
                                    transform: Matrix4.identity()
                                      ..setEntry(3, 2, 0.002)
                                      ..rotateX(
                                        vector.radians(rotationY),
                                      ),
                                    alignment: Alignment.center,
                                    child: InkWell(
                                      onTap: () => _onTapAlbum(
                                        snapshot.data![index].image,
                                        rotationY,
                                      ),
                                      child: SizedBox(
                                        height: _itemHeight,
                                        child: Stack(
                                          fit: StackFit.expand,
                                          children: <Widget>[
                                            Positioned.fill(
                                              child: AlbumImage(
                                                imageUrl:
                                                    snapshot.data![index].image,
                                                angle: rotationY,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomCenter,
                                              child: Container(
                                                height: 50.0,
                                                decoration: BoxDecoration(
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                      color: Colors.black87,
                                                      spreadRadius: 15.0,
                                                      blurRadius: 15.0,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : Center(
                          child: const CircularProgressIndicator(
                            backgroundColor: Colors.white,
                          ),
                        ),
                );
              },
            ),
            Positioned(
              left: 0.0,
              top: 0.0,
              right: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10.0,
                              spreadRadius: 10.0),
                        ],
                      ),
                      child: Text(
                        'Albums',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Colors.white),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
