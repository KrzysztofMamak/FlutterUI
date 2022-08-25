import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class ChristmasTreePage extends StatefulWidget {
  @override
  _ChristmasTreePageState createState() => _ChristmasTreePageState();
}

class _ChristmasTreePageState extends State<ChristmasTreePage> {
  final _offsets = _generateOffsets(100, 0.05).toList(growable: true);
  late final AudioPlayer _audioPlayer;
  final AudioCache _audioCache = AudioCache();
  bool _isPlayingMusic = true;

  @override
  void initState() {
    _playMusic();
    super.initState();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _playMusic() async {
    // TODO -> adjust to the newest audioplayers version
    // _audioPlayer = AudioPlayer();
    // _audioPlayer = await _audioCache('jingle.mp3');
  }

  void _resumePlaying() {
    setState(() => _isPlayingMusic = true);
    _audioPlayer.resume();
  }

  void _stopPlaying() {
    setState(() => _isPlayingMusic = false);
    _audioPlayer.stop();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Container(
        constraints: BoxConstraints(maxWidth: 700.0),
        padding: const EdgeInsets.symmetric(
          vertical: 40.0,
          horizontal: 8.0,
        ),
        child: ListView(
          children: <Widget>[
            Center(
              child: Icon(
                Icons.star,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 8.0),
            for (final x in _offsets) Light(x: x),
            SizedBox(height: 8.0),
            Center(child: Text('Happy Holidays')),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: _isPlayingMusic ? _stopPlaying : _resumePlaying,
              child: Text(_isPlayingMusic ? 'Stop' : 'Start'),
            ),
          ],
        ),
      ),
    );
  }

  static Iterable<double> _generateOffsets(
      int count, double acceleration) sync* {
    double x = 0.0;
    yield x;
    double ax = acceleration;
    for (int i = 0; i < count; i++) {
      x += ax;
      ax *= 1.5;
      final maxLateral = min(1, i / count);
      if (x.abs() > maxLateral) {
        x = maxLateral * x.sign;
        ax = x >= 0.0 ? -acceleration : acceleration;
      }
      yield x;
    }
  }
}

class Light extends StatefulWidget {
  static const festiveColors = <Color>[
    Colors.red,
    Colors.green,
    Colors.orange,
    Colors.yellow,
  ];

  final double x;
  final int period;
  final Color color;

  Light({
    Key? key,
    required this.x,
  })   : period = 500 + (x.abs() * 4000).floor(),
        color = festiveColors[Random().nextInt(4)],
        super(key: key);

  @override
  _LightState createState() => _LightState();
}

class _LightState extends State<Light> {
  Color _newColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10.0,
      child: Align(
        alignment: Alignment(widget.x, 0.0),
        child: AspectRatio(
          aspectRatio: 1,
          child: TweenAnimationBuilder(
            tween: ColorTween(begin: widget.color, end: _newColor),
            onEnd: () {
              setState(() {
                _newColor =
                    _newColor == Colors.white ? widget.color : Colors.white;
              });
            },
            duration: Duration(milliseconds: widget.period),
            builder: (_, Color? color, __) {
              return Container(
                color: color,
              );
            },
          ),
        ),
      ),
    );
  }
}
