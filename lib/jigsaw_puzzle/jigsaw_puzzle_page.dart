import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_samples/jigsaw_puzzle/jigsaw_puzzle_piece.dart';
import 'package:image_picker/image_picker.dart';

// TODO -> add possibility to change number of puzzle pieces

class JigsawPuzzlePage extends StatefulWidget {
  const JigsawPuzzlePage({Key? key}) : super(key: key);

  @override
  _JigsawPuzzlePageState createState() => _JigsawPuzzlePageState();
}

class _JigsawPuzzlePageState extends State<JigsawPuzzlePage> {
  File? _image;
  List<Widget> _pieces = [];
  final int _rows = 4;
  final int _cols = 4;

  Future _loadImage(ImageSource source) async {
    final imagePath = (await ImagePicker().pickImage(source: source))?.path;
    if (imagePath != null) {
      setState(() {
        _image = File(imagePath);
        _pieces.clear();
      });
      _splitImage(Image.file(_image!));
    }
  }

  Future<Size> _getImageSize(Image image) async {
    final completer = Completer<Size>();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (info, _) {
          completer.complete(
            Size(
              info.image.width.toDouble(),
              info.image.height.toDouble(),
            ),
          );
        },
      ),
    );
    final imageSize = await completer.future;
    return imageSize;
  }

  void _splitImage(Image image) async {
    final imageSize = await _getImageSize(image);
    for (var x = 0; x < _rows; x++) {
      for (var y = 0; y < _cols; y++) {
        setState(() {
          _pieces.add(
            JigsawPuzzlePiece(
              key: GlobalKey(),
              image: image,
              imageSize: imageSize,
              row: x,
              col: y,
              maxRow: _rows,
              maxCol: _cols,
              bringToTop: _bringToTop,
              sendToBack: _sendToBack,
            ),
          );
        });
      }
    }
  }

  void _bringToTop(Widget widget) {
    setState(() {
      _pieces.remove(widget);
      _pieces.add(widget);
    });
  }

  void _sendToBack(Widget widget) {
    setState(() {
      _pieces.remove(widget);
      _pieces.insert(0, widget);
    });
  }

  void _onCameraTileTap(BuildContext context) {
    _loadImage(ImageSource.camera);
    Navigator.pop(context);
  }

  void _onGalleryTileTap(BuildContext context) {
    _loadImage(ImageSource.gallery);
    Navigator.pop(context);
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera),
                title: const Text('Camera'),
                onTap: () => _onCameraTileTap(context),
              ),
              ListTile(
                leading: const Icon(Icons.image),
                title: const Text('Gallery'),
                onTap: () => _onGalleryTileTap(context),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Jigsaw Puzzle'),
      ),
      body: SafeArea(
        child: Center(
          child: _image == null
              ? Text('No image selected')
              : Stack(
                  children: _pieces,
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'New image',
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
