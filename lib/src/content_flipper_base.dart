import 'dart:math';

import 'package:flutter/material.dart';

/// Defines which side of the [ContentFlipper] is initially visible.
enum FlipSide { front, back }

/// A professional-grade, highly customizable widget that flips content in 3D space.
///
/// Use [ContentFlipper] to create card-like interfaces, interactive toggles,
/// or 3D rotation effects with minimal boilerplate.

/// A professional-grade, highly customizable widget that flips content in 3D space.
///
/// Use it to create interactive cards, toggles, or 3D effects.
///
/// Example:
/// ```dart
/// ContentFlipper(
///   front: MyFrontWidget(),
///   back: MyBackWidget(),
/// )
/// ```
class ContentFlipper extends StatefulWidget {
  /// The widget to display on the front side.
  final Widget front;

  /// The widget to display on the back side.
  final Widget back;

  /// The duration of the flip animation. Defaults to 700ms.
  final Duration duration;

  /// The total amount of rotation in radians. Defaults to [pi] (180 degrees).
  final double totalRotation;

  /// The axis around which the widget flips. Defaults to [Axis.horizontal].
  final Axis axis;

  /// If true, inverts the rotation direction.
  final bool isReverseFlip;

  /// The side that should be visible when the widget is first built.
  final FlipSide initialSide;

  /// Whether to use the internal flip logic (auto-mirroring and side switching).
  /// Set to false if you want to control the transformation entirely via [customTransform].
  final bool useDefaultFlipLogic;

  /// A custom matrix transformation function.
  /// Provides full control over the 3D projection if [useDefaultFlipLogic] is false.
  final Matrix4 Function(double animationValue)? customTransform;

  /// Callback triggered when the front side is tapped.
  final VoidCallback? onFrontTap;

  /// Callback triggered when the back side is tapped.
  final VoidCallback? onBackTap;

  const ContentFlipper({
    super.key,
    required this.front,
    required this.back,
    this.duration = const Duration(milliseconds: 700),
    this.totalRotation = pi,
    this.axis = Axis.horizontal,
    this.isReverseFlip = false,
    this.initialSide = FlipSide.front,
    this.useDefaultFlipLogic = true,
    this.customTransform,
    this.onFrontTap,
    this.onBackTap,
  }) : assert(
         !(customTransform != null && useDefaultFlipLogic),
         "If you provide a customTransform, set useDefaultFlipLogic to false.",
       );

  @override
  ContentFlipperState createState() => ContentFlipperState();
}

class ContentFlipperState extends State<ContentFlipper>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _showFront = true;

  @override
  void initState() {
    super.initState();
    _showFront = widget.initialSide == FlipSide.front;

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
      value: _showFront ? 0.0 : 1.0,
    );

    _controller.addListener(() {
      if (widget.useDefaultFlipLogic) {
        if (_controller.value >= 0.5 && _showFront) {
          setState(() => _showFront = false);
        } else if (_controller.value < 0.5 && !_showFront) {
          setState(() => _showFront = true);
        }
      }
    });
  }

  /// Manually triggers the flip animation.
  void flip() {
    if (_controller.isAnimating) return;

    if (_showFront) {
      widget.onFrontTap?.call();
      _controller.forward();
    } else {
      widget.onBackTap?.call();
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: flip,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          Matrix4 transform;
          final double direction = widget.isReverseFlip ? -1.0 : 1.0;
          final double rotationAngle =
              _controller.value * widget.totalRotation * direction;

          if (widget.customTransform != null) {
            transform = widget.customTransform!(_controller.value);
          } else {
            transform = Matrix4.identity()..setEntry(3, 2, 0.001);
            if (widget.axis == Axis.horizontal) {
              transform.rotateY(rotationAngle);
            } else {
              transform.rotateX(rotationAngle);
            }
          }

          if (!widget.useDefaultFlipLogic) {
            return Transform(
              alignment: Alignment.center,
              transform: transform,
              child: child,
            );
          }

          final isUnder = _controller.value > 0.5;
          final mirror = widget.isReverseFlip ? -pi : pi;

          return Transform(
            alignment: Alignment.center,
            transform: transform,
            child: isUnder
                ? Transform(
                    alignment: Alignment.center,
                    transform: widget.axis == Axis.horizontal
                        ? Matrix4.rotationY(mirror)
                        : Matrix4.rotationX(mirror),
                    child: child,
                  )
                : child,
          );
        },
        child: _showFront ? widget.front : widget.back,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
