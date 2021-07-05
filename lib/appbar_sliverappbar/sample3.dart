import 'package:flutter/material.dart';
import 'package:flutter_samples/appbar_sliverappbar/main_appbar_sliverappbar.dart';

class Sample3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.pinkAccent,
          backgroundColor: kBackgroundColor,
          currentIndex: 4,
          elevation: 4.0,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: 'Library',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.music_note),
              label: 'Songs',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_input_antenna),
              label: 'Radio',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
          ],
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: CustomScrollView(
                slivers: <Widget>[
                  HeaderWidget(),
                  AlbumWidget(),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Top songs',
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                          Text(
                            'ADD TO PLAYLIST',
                            style: TextStyle(
                                color: Colors.pinkAccent, fontSize: 13),
                          )
                        ],
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (_, index) {
                        final song = songs[index % songs.length];
                        return ListTile(
                          leading: Image.network(
                            song.image,
                            height: 30,
                            fit: BoxFit.cover,
                          ),
                          title: Text(song.title),
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.add,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        );
                      },
                      childCount: 20,
                    ),
                  ),
                ],
              ),
            ),
            BottomWidget(),
          ],
        ),
      ),
    );
  }
}

class AlbumWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Image.network(
              'https://clanfmok.com/wp-content/uploads/2019/12/unnamed.png',
              height: 90,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Fades Away (Tribute Concert Version) [feat. MishCatt] - Single',
                    style: TextStyle(color: Colors.white),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                      primary: Colors.pinkAccent,
                    ),
                    child: Text('ADD TO PLAYLIST'),
                    onPressed: () {},
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kBackgroundColor,
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: <Widget>[
          Image.network(
            'https://images.genius.com/aaedbb591aa119f91b9339bbe97f20ae.1000x998x1.png',
            height: 40.0,
          ),
          SizedBox(width: 10.0),
          Text('Heaven'),
          Spacer(),
          IconButton(
            icon: Icon(
              Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          Align(
            widthFactor: 0.2,
            child: IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
          Align(
            widthFactor: 0.2,
            child: IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class HeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 300.0,
      stretch: true,
      backgroundColor: Color(0xFF0B0B14),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: <StretchMode>[StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned.fill(
              child: Image.network(
                'https://pbs.twimg.com/media/DbQDvwGXkAgkh5f.jpg',
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Avicii',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.pinkAccent,
                      child: Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                      ),
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
