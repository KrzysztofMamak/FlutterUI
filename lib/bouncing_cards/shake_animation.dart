import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';

// TODO -> maybe make it more smooth

class LeftRightShake extends AnimatorWidget {
  LeftRightShake({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
          key: key,
          child: child,
          definition: ShakeAnimation(
            preferences: preferences,
            first: -5,
            second: 5,
          ),
        );
}

class RightLeftShake extends AnimatorWidget {
  RightLeftShake({
    Key? key,
    required Widget child,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(
          key: key,
          child: child,
          definition: ShakeAnimation(
            preferences: preferences,
            first: 8,
            second: -2,
          ),
        );
}

class ShakeAnimation extends AnimationDefinition {
  ShakeAnimation({
    required this.first,
    required this.second,
    AnimationPreferences preferences = const AnimationPreferences(),
  }) : super(preferences: preferences);

  final double first;
  final double second;

  @override
  Widget build(BuildContext context, Animator animator, Widget child) {
    return AnimatedBuilder(
      animation: animator.controller!,
      builder: (context, child) {
        return Transform(
          alignment: FractionalOffset(0.5, 0.5),
          transform: Matrix4.translationValues(
            animator.get('translateX')?.value ?? 0,
            0,
            0,
          ),
          child: child,
        );
      },
      child: child,
    );
  }

  @override
  Map<String, TweenList> getDefinition({
    Size? screenSize,
    Size? widgetSize,
  }) {
    const origin = 0.0;

    return {
      "translateX": TweenList<double>(
        [
          TweenPercentage(percent: 0, value: origin),
          TweenPercentage(percent: 20, value: first),
          TweenPercentage(percent: 80, value: second),
          TweenPercentage(percent: 100, value: origin),
        ],
      ),
    };
  }
}
