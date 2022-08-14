import 'package:flutter/material.dart';

class AwaitingButtonPage extends StatefulWidget {
  const AwaitingButtonPage({Key? key}) : super(key: key);

  @override
  State<AwaitingButtonPage> createState() => _AwaitingButtonPageState();
}

enum ButtonState {
  init,
  loading,
  done,
}

class _AwaitingButtonPageState extends State<AwaitingButtonPage> {
  ButtonState _state = ButtonState.init;
  bool _isLoading = false;
  bool _isAnimating = true;

  Widget _buildButton() {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: StadiumBorder(),
        side: BorderSide(
          width: 2,
          color: Colors.indigo,
        ),
      ),
      onPressed: () async {
        setState(() {
          _state = ButtonState.loading;
        });
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          _state = ButtonState.done;
        });
        await Future.delayed(const Duration(seconds: 3));
        setState(() {
          _state = ButtonState.init;
        });
      },
      child: Text(
        'SUBMIT',
        style: TextStyle(
          fontSize: 24,
          color: Colors.indigo,
          letterSpacing: 1.5,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildSmallButton(bool isDone) {
    final color = isDone ? Colors.green : Colors.indigo;
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: isDone
            ? Icon(Icons.done, size: 52, color: Colors.white)
            : CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isStretched = _isAnimating || _state == ButtonState.init;
    final isDone = _state == ButtonState.done;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Awaiting Button'),
      ),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
              width: _state == ButtonState.init ? width : 70,
              onEnd: () => setState(() => _isAnimating = !_isAnimating),
              height: 70,
              child: isStretched ? _buildButton() : _buildSmallButton(isDone),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 24),
                minimumSize: Size.fromHeight(72),
                shape: StadiumBorder(),
              ),
              child: _isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.white),
                        const SizedBox(width: 24),
                        const Text('Please wait'),
                      ],
                    )
                  : const Text('Login'),
              onPressed: () async {
                if (_isLoading) {
                  return;
                }
                setState(() {
                  _isLoading = true;
                });
                await Future.delayed(const Duration(seconds: 3));
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
