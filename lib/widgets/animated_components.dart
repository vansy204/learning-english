import 'package:flutter/material.dart';
import 'dart:math';
import 'package:learn_english/utils/animations.dart';
import 'package:learn_english/core/theme/app_theme.dart';

/// ============================================================================
/// ANIMATED BUTTONS
/// ============================================================================

/// Elevated button with scale animation on press
class AnimatedElevatedButton extends StatefulWidget {
  const AnimatedElevatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final VoidCallback onPressed;
  final Widget child;
  final Duration duration;

  @override
  State<AnimatedElevatedButton> createState() => _AnimatedElevatedButtonState();
}

class _AnimatedElevatedButtonState extends State<AnimatedElevatedButton>
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

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown() async {
    await _controller.forward();
  }

  void _onTapUp() async {
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _onTapDown(),
      onTapUp: (_) => _onTapUp(),
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ElevatedButton(
          onPressed: () {},
          child: widget.child,
        ),
      ),
    );
  }
}

/// Animated icon button with ripple effect
class AnimatedIconButton extends StatefulWidget {
  const AnimatedIconButton({
    Key? key,
    required this.icon,
    required this.onPressed,
    this.color = Colors.blue,
    this.backgroundColor,
    this.size = 50.0,
  }) : super(key: key);

  final IconData icon;
  final VoidCallback onPressed;
  final Color color;
  final Color? backgroundColor;
  final double size;

  @override
  State<AnimatedIconButton> createState() => _AnimatedIconButtonState();
}

class _AnimatedIconButtonState extends State<AnimatedIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _opacityAnimation = Tween<double>(begin: 1.0, end: 0.6).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTap() async {
    await _controller.forward();
    await _controller.reverse();
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: GestureDetector(
        onTap: _onTap,
        child: Container(
          width: widget.size,
          height: widget.size,
          decoration: BoxDecoration(
            color: widget.backgroundColor ?? AppTheme.paleBlue,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(widget.icon, color: widget.color, size: 24),
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// ANIMATED CARDS
/// ============================================================================

/// Card that lifts on hover/tap
class AnimatedLiftCard extends StatefulWidget {
  const AnimatedLiftCard({
    Key? key,
    required this.child,
    this.onTap,
    this.elevation = 8.0,
    this.duration = const Duration(milliseconds: 300),
  }) : super(key: key);

  final Widget child;
  final VoidCallback? onTap;
  final double elevation;
  final Duration duration;

  @override
  State<AnimatedLiftCard> createState() => _AnimatedLiftCardState();
}

class _AnimatedLiftCardState extends State<AnimatedLiftCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _elevationAnimation;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _elevationAnimation = Tween<double>(begin: 0, end: widget.elevation).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _offsetAnimation = Tween<Offset>(begin: Offset.zero, end: const Offset(0, -0.05))
        .animate(
          CurvedAnimation(parent: _controller, curve: Curves.easeOut),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onEnter() {
    _controller.forward();
  }

  void _onExit() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => _onEnter(),
      onExit: (_) => _onExit(),
      child: GestureDetector(
        onTap: () {
          _onEnter();
          Future.delayed(const Duration(milliseconds: 100), () {
            _onExit();
            widget.onTap?.call();
          });
        },
        child: AnimatedBuilder(
          animation: _elevationAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0, _offsetAnimation.value.dy * 20),
              child: Card(
                elevation: _elevationAnimation.value,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: child,
              ),
            );
          },
          child: widget.child,
        ),
      ),
    );
  }
}

/// ============================================================================
/// ANIMATED LOADING INDICATORS
/// ============================================================================

/// Beautiful animated loading spinner
class AnimatedLoadingSpinner extends StatelessWidget {
  const AnimatedLoadingSpinner({
    Key? key,
    this.size = 50.0,
    this.color = Colors.blue,
    this.strokeWidth = 4.0,
  }) : super(key: key);

  final double size;
  final Color color;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: RotatingAnimation(
        duration: const Duration(seconds: 2),
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

/// Animated dots loading indicator
class DotsLoadingIndicator extends StatefulWidget {
  const DotsLoadingIndicator({
    Key? key,
    this.dotSize = 12.0,
    this.color = Colors.blue,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  final double dotSize;
  final Color color;
  final Duration duration;

  @override
  State<DotsLoadingIndicator> createState() => _DotsLoadingIndicatorState();
}

class _DotsLoadingIndicatorState extends State<DotsLoadingIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final double animValue =
                (_controller.value - (index * 0.1)) % 1.0;
            final double scale = 1.0 + (sin(animValue * 3.14159) * 0.3);

            return Transform.scale(
              scale: scale,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: widget.dotSize,
                height: widget.dotSize,
                decoration: BoxDecoration(
                  color: widget.color.withValues(
                    alpha: (sin(animValue * 3.14159) + 1) / 2,
                  ),
                  shape: BoxShape.circle,
                ),
              ),
            );
          },
        );
      }),
    );
  }
}

/// ============================================================================
/// ANIMATED PROGRESS INDICATORS
/// ============================================================================

/// Animated progress bar
class AnimatedProgressBar extends StatefulWidget {
  const AnimatedProgressBar({
    Key? key,
    required this.progress,
    this.height = 8.0,
    this.backgroundColor,
    this.progressColor = Colors.blue,
    this.borderRadius = 4.0,
    this.duration = const Duration(milliseconds: 800),
  }) : super(key: key);

  final double progress; // 0.0 to 1.0
  final double height;
  final Color? backgroundColor;
  final Color progressColor;
  final double borderRadius;
  final Duration duration;

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );
  }

  @override
  void didUpdateWidget(AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _controller.forward(from: 0.0);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          child: LinearProgressIndicator(
            value: widget.progress,
            minHeight: widget.height,
            backgroundColor: widget.backgroundColor ?? Colors.grey.shade300,
            valueColor: AlwaysStoppedAnimation<Color>(widget.progressColor),
          ),
        );
      },
    );
  }
}

/// ============================================================================
/// ANIMATED TEXT
/// ============================================================================

/// Animated counter for displaying numbers
class AnimatedCounter extends StatefulWidget {
  const AnimatedCounter({
    Key? key,
    required this.count,
    this.style,
    this.duration = const Duration(milliseconds: 600),
  }) : super(key: key);

  final int count;
  final TextStyle? style;
  final Duration duration;

  @override
  State<AnimatedCounter> createState() => _AnimatedCounterState();
}

class _AnimatedCounterState extends State<AnimatedCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _animation;
  late int _previousCount;

  @override
  void initState() {
    super.initState();
    _previousCount = widget.count;
    _setupAnimation();
  }

  void _setupAnimation() {
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _animation = IntTween(
      begin: _previousCount,
      end: widget.count,
    ).animate(
      CurvedAnimation(parent: _controller, curve: CustomCurves.easeOutSmooth),
    );

    _controller.forward();
  }

  @override
  void didUpdateWidget(AnimatedCounter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.count != widget.count) {
      _controller.dispose();
      _previousCount = oldWidget.count;
      _setupAnimation();
    }
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
          _animation.value.toString(),
          style: widget.style,
        );
      },
    );
  }
}

/// ============================================================================
/// ANIMATED LIST
/// ============================================================================

/// Animated list that staggered items as they appear
class AnimatedListView extends StatelessWidget {
  const AnimatedListView({
    Key? key,
    required this.items,
    required this.itemBuilder,
    this.staggerDelay = const Duration(milliseconds: 100),
  }) : super(key: key);

  final List<dynamic> items;
  final Widget Function(BuildContext, int, dynamic) itemBuilder;
  final Duration staggerDelay;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return SlideInAnimation(
          direction: SlideDirection.fromBottom,
          delay: staggerDelay * index,
          child: FadeInAnimation(
            delay: staggerDelay * index,
            child: itemBuilder(context, index, items[index]),
          ),
        );
      },
    );
  }
}

/// ============================================================================
/// ANIMATED DIALOG
/// ============================================================================

/// Shows an animated dialog
Future<T?> showAnimatedDialog<T>({
  required BuildContext context,
  required Widget dialog,
  Duration duration = const Duration(milliseconds: 400),
}) {
  return showDialog<T>(
    context: context,
    builder: (context) => ScaleInAnimation(
      duration: duration,
      child: dialog,
    ),
  );
}

/// ============================================================================
/// ANIMATED SNACKBAR
/// ============================================================================

/// Shows an animated snackbar
void showAnimatedSnackBar(
  BuildContext context, {
  required String message,
  Duration duration = const Duration(seconds: 4),
  Color? backgroundColor,
  IconData? icon,
}) {
  final snackBar = SnackBar(
    content: Row(
      children: [
        if (icon != null) ...[
          Icon(icon, color: Colors.white),
          const SizedBox(width: 16),
        ],
        Expanded(
          child: Text(message),
        ),
      ],
    ),
    duration: duration,
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(16),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

/// ============================================================================
/// ANIMATED BADGE
/// ============================================================================

/// Animated badge widget
class AnimatedBadge extends StatefulWidget {
  const AnimatedBadge({
    Key? key,
    required this.child,
    required this.label,
    this.backgroundColor = Colors.red,
    this.position = BadgePosition.topRight,
  }) : super(key: key);

  final Widget child;
  final String label;
  final Color backgroundColor;
  final BadgePosition position;

  @override
  State<AnimatedBadge> createState() => _AnimatedBadgeState();
}

enum BadgePosition { topLeft, topRight, bottomLeft, bottomRight }

class _AnimatedBadgeState extends State<AnimatedBadge>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.1).animate(
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
    final (top, right, bottom, left) = switch (widget.position) {
      BadgePosition.topRight => (0.0, 0.0, null, null),
      BadgePosition.topLeft => (0.0, null, null, 0.0),
      BadgePosition.bottomRight => (null, 0.0, 0.0, null),
      BadgePosition.bottomLeft => (null, null, 0.0, 0.0),
    };

    return Stack(
      clipBehavior: Clip.none,
      children: [
        widget.child,
        Positioned(
          top: top,
          right: right,
          bottom: bottom,
          left: left,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: widget.backgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                widget.label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
