import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiPage extends StatefulWidget {
  const ConfettiPage({Key? key}) : super(key: key);

  @override
  _ConfettiPageState createState() => _ConfettiPageState();
}

class _ConfettiPageState extends State<ConfettiPage> {
  bool _isPlaying = false;
  late final ConfettiController _controller;

  void _onPressed() {
    if (_isPlaying) {
      _controller.stop();
    } else {
      _controller.play();
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = ConfettiController();
    _controller..addListener(() {
      setState(() {
        _isPlaying = _controller.state == ConfettiControllerState.playing;
      });
    })
      ..play();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text('Confetti'),
          ),
          body: Center(
            child: ElevatedButton(
              onPressed: _onPressed,
              child: Text(_isPlaying ? 'Stop' : 'Start'),
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: _controller,
          shouldLoop: true,
          // blastDirection: -math.pi / 2,
          blastDirectionality: BlastDirectionality.explosive,
          // minBlastForce: 10,
          // maxBlastForce: 100,
          // emissionFrequency: 0.4,
          // gravity: 0.2,
          // colors: [],
        ),
      ],
    );
  }
}
