import 'package:flutter/material.dart';
import 'package:learn_english/utils/animations.dart';
import 'package:learn_english/core/theme/app_theme.dart';
import 'package:learn_english/widgets/animated_components.dart';

/// ============================================================================
/// ANIMATED STAT CARD
/// ============================================================================

/// Beautiful animated stat card showing statistics with counter
class AnimatedStatCard extends StatelessWidget {
  const AnimatedStatCard({
    Key? key,
    required this.icon,
    required this.count,
    required this.label,
    required this.color,
    this.delay = Duration.zero,
  }) : super(key: key);

  final IconData icon;
  final int count;
  final String label;
  final Color color;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: delay,
      child: ScaleInAnimation(
        delay: delay,
        startScale: 0.7,
        duration: const Duration(milliseconds: 600),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              // Icon with background circle
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: PulseAnimation(
                    scale: 0.08,
                    duration: const Duration(milliseconds: 2000),
                    child: Icon(icon, color: color, size: 30),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Count with animation
              AnimatedCounter(
                count: count,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
              const SizedBox(height: 8),
              // Label
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.textGrey,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// ANIMATED DAILY GOAL CARD
/// ============================================================================

/// Beautiful daily goal progress card with animated progress bar
class AnimatedDailyGoalCard extends StatelessWidget {
  const AnimatedDailyGoalCard({
    Key? key,
    required this.currentXP,
    required this.targetXP,
    this.delay = Duration.zero,
  }) : super(key: key);

  final int currentXP;
  final int targetXP;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    final progress = (currentXP / targetXP).clamp(0.0, 1.0);

    return FadeInAnimation(
      delay: delay,
      child: SlideInAnimation(
        direction: SlideDirection.fromTop,
        delay: delay,
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryBlue.withValues(alpha: 0.1),
                AppTheme.primaryBlue.withValues(alpha: 0.05),
              ],
            ),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: AppTheme.primaryBlue.withValues(alpha: 0.2),
              width: 1.5,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Daily Goal',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Keep your streak going! 🔥',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: AppTheme.textGrey,
                        ),
                      ),
                    ],
                  ),
                  PulseAnimation(
                    scale: 0.15,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.accentYellow.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.local_fire_department,
                        color: Colors.red,
                        size: 28,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Progress info
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Progress',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  AnimatedCounter(
                    count: currentXP,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                  Text(
                    '/$targetXP XP',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textGrey,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Progress bar
              AnimatedProgressBar(
                progress: progress,
                height: 12,
                progressColor: AppTheme.primaryBlue,
                backgroundColor: AppTheme.paleBlue,
                borderRadius: 6,
              ),
              const SizedBox(height: 16),
              // Status message
              SlideInAnimation(
                direction: SlideDirection.fromBottom,
                delay: delay + const Duration(milliseconds: 200),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: progress >= 1.0
                        ? AppTheme.successGreen.withValues(alpha: 0.15)
                        : AppTheme.accentYellow.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        progress >= 1.0
                            ? Icons.check_circle
                            : Icons.info_outline,
                        color: progress >= 1.0
                            ? AppTheme.successGreen
                            : AppTheme.accentYellow,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          progress >= 1.0
                              ? '🎉 Goal completed! Great work!'
                              : '${((1 - progress) * targetXP).toInt()} more XP to complete today\'s goal',
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: progress >= 1.0
                                ? AppTheme.successGreen
                                : AppTheme.textDark,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// ANIMATED LESSON CARD
/// ============================================================================

/// Beautiful animated lesson card for vocabulary items
class AnimatedLessonCard extends StatelessWidget {
  const AnimatedLessonCard({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.onTap,
    this.delay = Duration.zero,
  }) : super(key: key);

  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final VoidCallback? onTap;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: delay,
      child: SlideInAnimation(
        direction: SlideDirection.fromBottom,
        delay: delay,
        child: GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.1),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Icon container
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Icon(icon, color: color, size: 32),
                  ),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        description,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppTheme.textGrey,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // Arrow icon
                Icon(
                  Icons.arrow_forward_ios,
                  color: color,
                  size: 16,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// ANIMATED ACHIEVEMENT BADGE
/// ============================================================================

/// Beautiful animated achievement badge
class AnimatedAchievementBadge extends StatefulWidget {
  const AnimatedAchievementBadge({
    Key? key,
    required this.emoji,
    required this.title,
    required this.description,
    this.isUnlocked = false,
    this.delay = Duration.zero,
  }) : super(key: key);

  final String emoji;
  final String title;
  final String description;
  final bool isUnlocked;
  final Duration delay;

  @override
  State<AnimatedAchievementBadge> createState() =>
      _AnimatedAchievementBadgeState();
}

class _AnimatedAchievementBadgeState extends State<AnimatedAchievementBadge> {
  late bool _isHovered;

  @override
  void initState() {
    super.initState();
    _isHovered = false;
  }

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: widget.delay,
      child: ScaleInAnimation(
        delay: widget.delay,
        startScale: 0.6,
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: widget.isUnlocked ? Colors.white : Colors.grey.shade200,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: widget.isUnlocked
                    ? AppTheme.accentYellow.withValues(alpha: 0.3)
                    : Colors.grey.shade300,
                width: 2,
              ),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: AppTheme.accentYellow.withValues(alpha: 0.2),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ]
                  : [],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Emoji badge
                ScaleTransition(
                  scale: AlwaysStoppedAnimation(_isHovered ? 1.2 : 1.0),
                  child: Text(
                    widget.emoji,
                    style: const TextStyle(fontSize: 40),
                  ),
                ),
                const SizedBox(height: 8),
                // Title
                Text(
                  widget.title,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: widget.isUnlocked
                        ? AppTheme.textDark
                        : Colors.grey.shade600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 4),
                // Description
                Text(
                  widget.description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: widget.isUnlocked
                        ? AppTheme.textGrey
                        : Colors.grey.shade500,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.isUnlocked)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Icon(
                      Icons.check_circle,
                      color: AppTheme.successGreen,
                      size: 20,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// ANIMATED STREAK DISPLAY
/// ============================================================================

/// Beautiful animated streak counter with flame icon
class AnimatedStreakDisplay extends StatelessWidget {
  const AnimatedStreakDisplay({
    Key? key,
    required this.streak,
    this.delay = Duration.zero,
  }) : super(key: key);

  final int streak;
  final Duration delay;

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: delay,
      child: ScaleInAnimation(
        delay: delay,
        duration: const Duration(milliseconds: 700),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.orange.withValues(alpha: 0.2),
                Colors.red.withValues(alpha: 0.2),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.red.withValues(alpha: 0.3),
              width: 2,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              PulseAnimation(
                scale: 0.15,
                child: const Icon(
                  Icons.local_fire_department,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 8),
              AnimatedCounter(
                count: streak,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'day streak',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.red.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// ============================================================================
/// ANIMATED EMPTY STATE
/// ============================================================================

/// Beautiful empty state animation
class AnimatedEmptyState extends StatelessWidget {
  const AnimatedEmptyState({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.actionLabel,
    this.onAction,
  }) : super(key: key);

  final IconData icon;
  final String title;
  final String subtitle;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeInAnimation(
        child: ScaleInAnimation(
          duration: const Duration(milliseconds: 800),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated icon
              FloatingAnimation(
                duration: const Duration(seconds: 3),
                offset: 20.0,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Icon(
                      icon,
                      size: 50,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Title
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              // Subtitle
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              if (actionLabel != null && onAction != null) ...[
                const SizedBox(height: 24),
                AnimatedElevatedButton(
                  onPressed: onAction!,
                  child: Text(actionLabel!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
