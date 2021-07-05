import 'package:flutter/material.dart';
import 'package:flutter_samples/animations/list_details/character.dart';

class DetailsPage extends StatefulWidget {
  final Character character;

  const DetailsPage({
    Key? key,
    required this.character,
  }) : super(key: key);

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Hero(
          tag: 'background_${widget.character.title}',
          child: Container(color: Color(widget.character.color)),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Color(widget.character.color),
            elevation: 0.0,
            title: Text(widget.character.title),
            leading: CloseButton(),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: "image_${widget.character.title}",
                  child: Image.asset(
                    widget.character.avatar,
                    height: MediaQuery.of(context).size.height / 2,
                  ),
                ),
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, widget) => Transform.translate(
                    transformHitTests: false,
                    offset: Offset.lerp(Offset(0.0, 200.0), Offset.zero,
                        _animationController.value)!,
                    child: widget,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      widget.character.description,
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
