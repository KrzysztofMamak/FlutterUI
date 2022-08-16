import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchTimerPage extends StatefulWidget {
  const StopWatchTimerPage({Key? key}) : super(key: key);

  @override
  _StopWatchTimerPageState createState() => _StopWatchTimerPageState();
}

class _StopWatchTimerPageState extends State<StopWatchTimerPage> {
  static const _countdownDuration = Duration(minutes: 10);
  Duration _duration = const Duration();
  Timer? _timer;
  bool _isCountdown = true;

  @override
  void initState() {
    super.initState();
    _startTimer();
    _reset();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _startTimer({bool resets = true}) {
    if (resets) {
      _reset();
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => _addTime(),
    );
  }

  void _reset() {
    if (_isCountdown) {
      setState(() {
        _duration = _countdownDuration;
      });
    } else {
      setState(() {
        _duration = const Duration();
      });
    }
  }

  void _addTime() {
    final addSeconds = _isCountdown ? -1 : 1;
    setState(() {
      final seconds = _duration.inSeconds + addSeconds;
      if (seconds < 0) {
        _timer?.cancel();
      } else {
        _duration = Duration(seconds: seconds);
      }
    });
  }

  void _stopTimer({bool resets = true}) {
    if (resets) {
      _reset();
    }
    setState(() {
      _timer?.cancel();
    });
  }

  Widget _buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(_duration.inHours);
    final minutes = twoDigits(_duration.inMinutes.remainder(60));
    final seconds = twoDigits(_duration.inSeconds.remainder(60));

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTimeCard(time: hours, header: 'HOURS'),
        const SizedBox(width: 8),
        _buildTimeCard(time: minutes, header: 'MINUTES'),
        const SizedBox(width: 8),
        _buildTimeCard(time: seconds, header: 'SECONDS'),
      ],
    );
  }

  Widget _buildTimeCard({
    required String time,
    required String header,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            time,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 72,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Text(
          header,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildButtons() {
    final isRunning = _timer == null ? false : _timer!.isActive;
    final isCompleted = _duration.inSeconds == 0;
    return isRunning || !isCompleted
        ? Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ButtonWidget(
                text: isRunning ? 'STOP' : 'RESUME',
                onTap: () {
                  if (isRunning) {
                    _stopTimer(resets: false);
                  } else {
                    _startTimer(resets: false);
                  }
                },
              ),
              const SizedBox(width: 12),
              ButtonWidget(
                text: 'CANCEL',
                onTap: _stopTimer,
              ),
            ],
          )
        : ButtonWidget(
            text: 'Start Timer!',
            color: Colors.black,
            backgroundColor: Colors.white,
            onTap: _startTimer,
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stop Watch Timer'),
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Colors.purple,
                Colors.red,
                Colors.orange,
                Colors.green,
              ],
            ),
          ),
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
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.black),
        foregroundColor: MaterialStateProperty.all(Colors.white),
      ),
      onPressed: onTap,
      child: Text(text),
    );
  }
}
