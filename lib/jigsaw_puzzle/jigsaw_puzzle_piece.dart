import 'dart:math' as math;

import 'package:flutter/material.dart';

class JigsawPuzzlePiece extends StatefulWidget {
  const JigsawPuzzlePiece({
    Key? key,
    required this.image,
    required this.imageSize,
    required this.row,
    required this.col,
    required this.maxRow,
    required this.maxCol,
    required this.bringToTop,
    required this.sendToBack,
  }) : super(key: key);

  final Image image;
  final Size imageSize;
  final int row;
  final int col;
  final int maxRow;
  final int maxCol;
  final Function(Widget) bringToTop;
  final Function(Widget) sendToBack;

  @override
  _JigsawPuzzlePieceState createState() => _JigsawPuzzlePieceState();
}

class _JigsawPuzzlePieceState extends State<JigsawPuzzlePiece> {
  double? top;
  double? left;
  bool _isMovable = true;

  @override
  Widget build(BuildContext context) {
    final imageWidth = MediaQuery.of(context).size.width;
    final imageHeight = MediaQuery.of(context).size.height *
        MediaQuery.of(context).size.width /
        widget.imageSize.width;
    final pieceWidth = imageWidth / widget.maxCol;
    final pieceHeight = imageHeight / widget.maxRow;
    if (top == null) {
      top =
          math.Random().nextInt((imageHeight - pieceHeight).ceil()).toDouble();
      top = top! - widget.row * pieceHeight;
    }
    if (left == null) {
      left = math.Random().nextInt((imageWidth - pieceWidth).ceil()).toDouble();
      left = left! - widget.col * pieceWidth;
    }
    return Positioned(
      top: top,
      left: left,
      width: imageWidth,
      child: GestureDetector(
        onTap: () {
          if (_isMovable) {
            widget.bringToTop(widget);
          }
        },
        onPanStart: (_) {
          if (_isMovable) {
            widget.bringToTop(widget);
          }
        },
        onPanUpdate: (details) {
          if (_isMovable) {
            setState(() {
              top = top! + details.delta.dy;
              left = left! + details.delta.dx;

              if (-10 < top! && top! < 10 && -10 < left! && left! < 10) {
                top = 0;
                left = 0;
                _isMovable = false;
                widget.sendToBack(widget);
              }
            });
          }
        },
        child: ClipPath(
          clipper: _JigsawPuzzlePieceClipper(
            row: widget.row,
            col: widget.col,
            maxRow: widget.maxRow,
            maxCol: widget.maxCol,
          ),
          child: CustomPaint(
            foregroundPainter: _JigsawPuzzlePiecePainter(
              row: widget.row,
              col: widget.col,
              maxRow: widget.maxRow,
              maxCol: widget.maxCol,
            ),
            child: widget.image,
          ),
        ),
      ),
    );
  }
}

class _JigsawPuzzlePieceClipper extends CustomClipper<Path> {
  _JigsawPuzzlePieceClipper({
    required this.row,
    required this.col,
    required this.maxRow,
    required this.maxCol,
  });

  final int row;
  final int col;
  final int maxRow;
  final int maxCol;

  @override
  Path getClip(Size size) {
    return _getPiecePath(
      size: size,
      row: row,
      col: col,
      maxRow: maxRow,
      maxCol: maxCol,
    );
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _JigsawPuzzlePiecePainter extends CustomPainter {
  _JigsawPuzzlePiecePainter({
    required this.row,
    required this.col,
    required this.maxRow,
    required this.maxCol,
  });

  final int row;
  final int col;
  final int maxRow;
  final int maxCol;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0x80FFFFFF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;
    canvas.drawPath(
      _getPiecePath(
        size: size,
        row: row,
        col: col,
        maxRow: maxRow,
        maxCol: maxCol,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

Path _getPiecePath({
  required Size size,
  required int row,
  required int col,
  required int maxRow,
  required int maxCol,
}) {
  final width = size.width / maxCol;
  final height = size.height / maxRow;
  final offsetX = col * width;
  final offsetY = row * height;
  final bumpSize = height / 4;

  var path = Path();
  path.moveTo(offsetX, offsetY);

  if (row == 0) {
    path.lineTo(offsetX + width, offsetY);
  } else {
    path.lineTo(offsetX + width / 3, offsetY);
    path.cubicTo(
      offsetX + width / 6,
      offsetY - bumpSize,
      offsetX + width / 6 * 5,
      offsetY - bumpSize,
      offsetX + width / 3 * 2,
      offsetY,
    );
    path.lineTo(offsetX + width, offsetY);
  }

  if (col == maxCol - 1) {
    path.lineTo(offsetX + width, offsetY + height);
  } else {
    path.lineTo(offsetX + width, offsetY + height / 3);
    path.cubicTo(
      offsetX + width - bumpSize,
      offsetY + height / 6,
      offsetX + width - bumpSize,
      offsetY + height / 6 * 5,
      offsetX + width,
      offsetY + height / 3 * 2,
    );
    path.lineTo(offsetX + width, offsetY + height);
  }

  if (row == maxRow - 1) {
    path.lineTo(offsetX, offsetY + height);
  } else {
    path.lineTo(offsetX + width / 3 * 2, offsetY + height);
    path.cubicTo(
        offsetX + width / 6 * 5,
        offsetY + height - bumpSize,
        offsetX + width / 6,
        offsetY + height - bumpSize,
        offsetX + width / 3,
        offsetY + height);
    path.lineTo(offsetX, offsetY + height);
  }

  if (col == 0) {
    path.close();
  } else {
    path.lineTo(offsetX, offsetY + height / 3 * 2);
    path.cubicTo(
      offsetX - bumpSize,
      offsetY + height / 6 * 5,
      offsetX - bumpSize,
      offsetY + height / 6,
      offsetX,
      offsetY + height / 3,
    );
    path.close();
  }

  return path;
}
