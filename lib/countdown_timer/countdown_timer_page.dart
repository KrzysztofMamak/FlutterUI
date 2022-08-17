import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerPage extends StatefulWidget {
  const CountdownTimerPage({Key? key}) : super(key: key);

  @override
  _CountdownTimerPageState createState() => _CountdownTimerPageState();
}

class _CountdownTimerPageState extends State<CountdownTimerPage> {
  static const _maxSeconds = 60;
  int _seconds = _maxSeconds;
  Timer? _timer;

  void _startTime() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (_seconds > 0) {
          setState(() {
            _seconds--;
          });
        } else {
          _stopTimer();
        }
      },
    );
  }

  void _stopTimer({bool reset = true}) {
    if (reset) {
      _resetTimer();
    }
    _timer?.cancel();
  }

  void _resetTimer() {
    _seconds = _maxSeconds;
  }

  Widget _buildTime() {
    return Text(
      '$_seconds',
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 80,
      ),
    );
  }

  Widget _buildButtons() {
    final isRunning = _timer == null ? false : _timer!.isActive;
    return isRunning
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: 'Pause',
                onTap: () {
                  _stopTimer();
                },
              ),
              const SizedBox(width: 12),
              ButtonWidget(
                text: 'Cancel',
                onTap: () {
                  _stopTimer();
                },
              ),
            ],
          )
        : ButtonWidget(
            text: 'Start Timer!',
            color: Colors.black,
            backgroundColor: Colors.white,
            onTap: () {
              _startTime();
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
      ),
      body: GradientWidget(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTime(),
              const SizedBox(height: 80),
              _buildButtons(),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientWidget extends StatelessWidget {
  const GradientWidget({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.purple,
            Colors.pink,
            Colors.red,
            Colors.orange,
            Colors.yellow,
            Colors.green,
          ],
        ),
      ),
      child: child,
    );
  }
}

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onTap,
    this.color = Colors.white,
    this.backgroundColor = Colors.black,
  }) : super(key: key);

  final String text;
  final VoidCallback onTap;
  final Color color;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: ButtonStyle(
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 16,
          ),
        ),
        foregroundColor: MaterialStateProperty.all(color),
        backgroundColor: MaterialStateProperty.all(backgroundColor),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
    );
  }
}
