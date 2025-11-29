import 'package:flutter/material.dart';

/// Advanced Animation Utilities for Learn English App
/// Provides reusable animations, transitions, and tweens

/// ============================================================================
/// CUSTOM CURVES FOR SMOOTH ANIMATIONS
/// ============================================================================

class CustomCurves {
  /// Smooth ease-out curve for entrance animations
  static const Curve easeOutSmooth = Cubic(0.25, 0.46, 0.45, 0.94);

  /// Bouncy curve for playful animations
  static const Curve bouncy = Cubic(0.68, -0.55, 0.265, 1.55);

  /// Smooth ease-in-out curve for transitions
  static const Curve smoothTransition = Cubic(0.4, 0.0, 0.2, 1.0);

  /// Elastic curve for fun UI elements
  static const Curve elastic = Cubic(0.175, 0.885, 0.32, 1.275);

  /// Fast entrance curve
  static const Curve fastEntry = Cubic(0.43, 0.13, 0.23, 0.96);
}

/// ============================================================================
/// PAGE TRANSITION ANIMATIONS
/// ============================================================================

/// Material page transition with slide and fade
class SlidePageRoute<T> extends PageRoute<T> {
  SlidePageRoute({
    required this.page,
    this.duration = const Duration(milliseconds: 500),
    this.curve = CustomCurves.easeOutSmooth,
  });

  final Widget page;
  final Duration duration;
  final Curve curve;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return page;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: curve)),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

/// Scale page transition with bounce effect
class ScalePageRoute<T> extends PageRoute<T> {
  ScalePageRoute({
    required this.page,
    this.duration = const Duration(milliseconds: 600),
  });

  final Widget page;
  final Duration duration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return page;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return ScaleTransition(
      scale: Tween<double>(begin: 0.8, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: CustomCurves.bouncy),
      ),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}

/// Rotate page transition
class RotatePageRoute<T> extends PageRoute<T> {
  RotatePageRoute({
    required this.page,
    this.duration = const Duration(milliseconds: 500),
  });

  final Widget page;
  final Duration duration;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => duration;

  @override
  bool get opaque => false;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return page;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return RotationTransition(
      turns: Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: animation, curve: CustomCurves.easeOutSmooth),
      ),
      child: ScaleTransition(
        scale: animation,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }
}

/// ============================================================================
/// STAGGER ANIMATION HELPERS
/// ============================================================================

/// Helper class for staggered animations on lists
class StaggerAnimation extends StatelessWidget {
  const StaggerAnimation({
    Key? key,
    required this.child,
    required this.animation,
    this.offset = const Offset(0, 50),
    this.delay = Duration.zero,
  }) : super(key: key);

  final Widget child;
  final Animation<double> animation;
  final Offset offset;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animation,
      child: SlideTransition(
        position: Tween<Offset>(begin: offset, end: Offset.zero).animate(
          CurvedAnimation(
            parent: animation,
            curve: const Interval(0.0, 1.0, curve: CustomCurves.easeOutSmooth),
          ),
        ),
        child: child,
      ),
    );
  }
}

/// ============================================================================
/// BOUNCE AND SPRING ANIMATIONS
/// ============================================================================

/// Widget that bounces on tap
class BounceWidget extends StatefulWidget {
  const BounceWidget({
    Key? key,
    required this.child,
    this.onTap,
    this.duration = const Duration(milliseconds: 400),
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;
  final Duration duration;

  @override
  State<BounceWidget> createState() => _BounceWidgetState();
}

class _BounceWidgetState extends State<BounceWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.elasticInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _bounce() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _bounce,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}

/// ============================================================================
/// FLOATING AND PULSING ANIMATIONS
/// ============================================================================

/// Widget that floats up and down continuously
class FloatingAnimation extends StatefulWidget {
  const FloatingAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.offset = 20.0,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final double offset;

  @override
  State<FloatingAnimation> createState() => _FloatingAnimationState();
}

class _FloatingAnimationState extends State<FloatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: widget.offset).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_animation.value),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Widget that pulses (scales up and down)
class PulseAnimation extends StatefulWidget {
  const PulseAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 1500),
    this.scale = 0.1,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final double scale;

  @override
  State<PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.0 + widget.scale).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}

/// ============================================================================
/// SHIMMER LOADING ANIMATION
/// ============================================================================

/// Shimmer loading effect for skeleton screens
class ShimmerAnimation extends StatefulWidget {
  const ShimmerAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  final Widget child;
  final Duration duration;

  @override
  State<ShimmerAnimation> createState() => _ShimmerAnimationState();
}

class _ShimmerAnimationState extends State<ShimmerAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _animation = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return ShaderMask(
          shaderCallback: (bounds) {
            return LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [
                _animation.value - 1,
                _animation.value,
                _animation.value + 1,
              ],
              colors: const [
                Colors.grey,
                Colors.white60,
                Colors.grey,
              ],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// ============================================================================
/// ROTATION ANIMATION
/// ============================================================================

/// Continuous rotation animation
class RotatingAnimation extends StatefulWidget {
  const RotatingAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(seconds: 3),
    this.clockwise = true,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final bool clockwise;

  @override
  State<RotatingAnimation> createState() => _RotatingAnimationState();
}

class _RotatingAnimationState extends State<RotatingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();

    _animation = Tween<double>(
      begin: 0,
      end: widget.clockwise ? 1 : -1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _animation,
      child: widget.child,
    );
  }
}

/// ============================================================================
/// TYPED TEXT ANIMATION
/// ============================================================================

/// Animates text appearing character by character
class TypedTextAnimation extends StatefulWidget {
  const TypedTextAnimation({
    Key? key,
    required this.text,
    this.duration = const Duration(milliseconds: 50),
    this.style,
  }) : super(key: key);

  final String text;
  final Duration duration;
  final TextStyle? style;

  @override
  State<TypedTextAnimation> createState() => _TypedTextAnimationState();
}

class _TypedTextAnimationState extends State<TypedTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration * widget.text.length,
      vsync: this,
    );

    _animation = IntTween(begin: 0, end: widget.text.length).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Text(
          widget.text.substring(0, _animation.value),
          style: widget.style,
        );
      },
    );
  }
}

/// ============================================================================
/// SLIDE IN ANIMATION
/// ============================================================================

/// Widget that slides in from a direction
class SlideInAnimation extends StatefulWidget {
  const SlideInAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 600),
    this.direction = SlideDirection.fromLeft,
    this.delay = Duration.zero,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final SlideDirection direction;
  final Duration delay;

  @override
  State<SlideInAnimation> createState() => _SlideInAnimationState();
}

enum SlideDirection { fromLeft, fromRight, fromTop, fromBottom }

class _SlideInAnimationState extends State<SlideInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    final offset = switch (widget.direction) {
      SlideDirection.fromLeft => const Offset(-1.0, 0.0),
      SlideDirection.fromRight => const Offset(1.0, 0.0),
      SlideDirection.fromTop => const Offset(0.0, -1.0),
      SlideDirection.fromBottom => const Offset(0.0, 1.0),
    };

    _animation = Tween<Offset>(begin: offset, end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: CustomCurves.easeOutSmooth),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animation,
      child: widget.child,
    );
  }
}

/// ============================================================================
/// FADE IN ANIMATION
/// ============================================================================

/// Widget that fades in
class FadeInAnimation extends StatefulWidget {
  const FadeInAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration delay;

  @override
  State<FadeInAnimation> createState() => _FadeInAnimationState();
}

class _FadeInAnimationState extends State<FadeInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: widget.child,
    );
  }
}

/// ============================================================================
/// SCALE ANIMATION
/// ============================================================================

/// Widget that scales in
class ScaleInAnimation extends StatefulWidget {
  const ScaleInAnimation({
    Key? key,
    required this.child,
    this.duration = const Duration(milliseconds: 500),
    this.delay = Duration.zero,
    this.startScale = 0.0,
  }) : super(key: key);

  final Widget child;
  final Duration duration;
  final Duration delay;
  final double startScale;

  @override
  State<ScaleInAnimation> createState() => _ScaleInAnimationState();
}

class _ScaleInAnimationState extends State<ScaleInAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = Tween<double>(begin: widget.startScale, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: CustomCurves.bouncy),
    );

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.child,
    );
  }
}
