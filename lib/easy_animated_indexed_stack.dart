library easy_animated_indexed_stack;

import 'package:flutter/material.dart';

/// A custom [IndexedStack] widget that animates transitions between screens.
class EasyAnimatedIndexedStack extends StatefulWidget {
  /// Creates an instance of [EasyAnimatedIndexedStack].
  ///
  /// The `index` property specifies which child widget to display initially.
  const EasyAnimatedIndexedStack({
    super.key,
    this.alignment = AlignmentDirectional.topStart,
    this.textDirection,
    this.clipBehavior = Clip.hardEdge,
    this.sizing = StackFit.loose,
    this.index = 0,
    this.children = const <Widget>[],
    this.duration = const Duration(milliseconds: 200),
    this.curve = Curves.easeInOut,
    this.animationBuilder,
  });

  /// How to align the non-positioned and partially-positioned children in the
  /// stack.
  ///
  /// Defaults to [AlignmentDirectional.topStart].
  ///
  /// See [Stack.alignment] for more information.
  final AlignmentGeometry alignment;

  /// The text direction with which to resolve [alignment].
  ///
  /// Defaults to the ambient [Directionality].
  final TextDirection? textDirection;

  /// {@macro flutter.material.Material.clipBehavior}
  ///
  /// Defaults to [Clip.hardEdge].
  final Clip clipBehavior;

  /// How to size the non-positioned children in the stack.
  ///
  /// Defaults to [StackFit.loose].
  ///
  /// See [Stack.fit] for more information.
  final StackFit sizing;

  /// The index of the child to show.
  ///
  /// If this is null, none of the children will be shown.
  final int? index;

  /// The child widgets of the stack.
  ///
  /// Only the child at index [index] will be shown.
  ///
  /// See [Stack.children] for more information.
  final List<Widget> children;

  /// The duration of each transition animation (default: 200ms).
  final Duration duration;

  /// The curve used for transitioning between screens (default: easeInOut).
  final Curve curve;

  /// An optional custom animation builder function.
  final AnimationBuilder? animationBuilder;

  @override
  State<EasyAnimatedIndexedStack> createState() =>
      _EasyAnimatedIndexedStackState();
}

class _EasyAnimatedIndexedStackState extends State<EasyAnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  /// The current index of the IndexedStack.
  late int? _currentIndex = widget.index;

  /// An animation controller used to animate transitions between screens.
  late final AnimationController _animationController;

  /// A tween animation object that drives the transition animation.
  late final Animation<double> _animation;

  @override
  void initState() {
    // Initialize the animation controller with a duration based on
    // widget.duration.
    _animationController = AnimationController(
      vsync: this,
      duration: widget.duration,
    );

    // Create a tween animation object that starts from opacity 1 (fully
    // visible) and ends at opacity 0 (fully invisible).
    _animation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: widget.curve,
      ),
    );

    super.initState();
  }

  @override
  void didUpdateWidget(covariant EasyAnimatedIndexedStack oldWidget) {
    // If the index of the IndexedStack has changed, animate a transition to the
    // new index.
    if (oldWidget.index != widget.index) {
      _animationController.animateTo(1).then((_) {
        // Animate the child widgets out by setting their opacity to 0.
        setState(() => _currentIndex = widget.index);

        // Once the animation has completed, animate the new child widget in.
        _animationController.animateTo(0);
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        // Use the custom animation builder function if provided; otherwise use
        // the default primary animation builder.
        return widget.animationBuilder?.call(context, _animation, child) ??
            _defaultAnimationBuilder(context, _animation, child);
      },
      child: IndexedStack(
        alignment: widget.alignment,
        clipBehavior: widget.clipBehavior,
        sizing: widget.sizing,
        textDirection: widget.textDirection,
        index: _currentIndex,
        children: widget.children,
      ),
    );
  }
}

/// A callback function that takes a custom animation builder.
typedef AnimationBuilder = Widget Function(
  BuildContext context, // the build context
  Animation<double> animation, // the current animation progress (0.0 to 1.0)
  Widget? child, // the child widget to animate
);

/// The default animation builder used when no custom animation builder is
/// provided.
AnimationBuilder _defaultAnimationBuilder = (_, animation, child) {
  return Opacity(
    opacity: animation.value,
    child: Transform.translate(
      offset: Offset(0, (1 - animation.value) * 10),
      child: child,
    ),
  );
};
