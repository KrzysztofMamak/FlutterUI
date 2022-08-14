import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SpeedDialPage extends StatefulWidget {
  const SpeedDialPage({Key? key}) : super(key: key);

  @override
  _SpeedDialPageState createState() => _SpeedDialPageState();
}

class _SpeedDialPageState extends State<SpeedDialPage> {
  final _isDialOpen = ValueNotifier(false);

  Future _showToast(String message) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(
      msg: message,
      fontSize: 18,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_isDialOpen.value) {
          _isDialOpen.value = false;
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Speed Dial'),
        ),
        backgroundColor: Colors.amber,
        floatingActionButton: SpeedDial(
          // icon: Icons.share,
          animatedIcon: AnimatedIcons.menu_close,
          backgroundColor: Colors.black,
          overlayColor: Colors.black,
          spacing: 12,
          spaceBetweenChildren: 12,
          closeManually: true,
          onOpen: () => _showToast('Opened...'),
          onClose: () => _showToast('Closed...'),
          openCloseDial: _isDialOpen,
          children: [
            SpeedDialChild(
              label: 'Mail',
              backgroundColor: Colors.red,
              onTap: () => _showToast('Selected mail...'),
              child: Icon(Icons.mail),
            ),
            SpeedDialChild(
              label: 'Copy',
              backgroundColor: Colors.green,
              onTap: () => _showToast('Selected copy...'),
              child: Icon(Icons.copy),
            ),
          ],
        ),
      ),
    );
  }
}
