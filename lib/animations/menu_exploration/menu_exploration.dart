import 'package:flutter/material.dart';

const kXOffsetContainer = 10.0;

class MenuExploration extends StatefulWidget {
  final List<String> options;
  final double height;
  final double width;
  final ValueChanged<String> onChanged;
  final String selectedValue;

  const MenuExploration({
    Key? key,
    required this.options,
    required this.height,
    required this.width,
    required this.onChanged,
    required this.selectedValue,
  }) : super(key: key);

  @override
  _MenuExplorationState createState() => _MenuExplorationState();
}

class _MenuExplorationState extends State<MenuExploration>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation _animationContainer;
  late final PageController _pageController;
  int _currentIndex = 0;

  void _onTap() {
    _animationController
        .forward(from: 0.0)
        .whenComplete(() => _animationController.reverse());
    _pageController.animateToPage(
      _currentIndex++,
      duration: const Duration(milliseconds: 1100),
      curve: Curves.elasticOut,
    );
  }

  int _getRealIndex(int index) => (index >= widget.options.length)
      ? _getRealIndex(index - widget.options.length)
      : index;

  @override
  void initState() {
    super.initState();
    final index = widget.options.indexWhere(
        (item) => item.toLowerCase() == widget.selectedValue.toLowerCase());
    if (index >= 0) _currentIndex = index;

    _pageController = PageController(initialPage: _currentIndex);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animationContainer = Tween(
      begin: 0.0,
      end: kXOffsetContainer,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInSine,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(12.0);
    return Center(
      child: AnimatedBuilder(
        animation: _animationController,
        child: Material(
          borderRadius: radius,
          child: InkWell(
            borderRadius: radius,
            onTap: _onTap,
            child: SizedBox(
              height: widget.height,
              width: widget.width,
              child: PageView.builder(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  widget.onChanged(widget.options[_getRealIndex(index)]);
                },
                itemBuilder: (_, index) {
                  final value = widget.options[_getRealIndex(index)];
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            value,
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20.0,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 20.0,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_animationContainer.value, 0.0),
            child: child,
          );
        },
      ),
    );
  }
}
