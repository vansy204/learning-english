# 🚀 Quick Start - Using Animations in Your App

## 5-Minute Quick Start

### Import Animations
```dart
import 'package:learn_english/utils/animations.dart';
import 'package:learn_english/widgets/animated_components.dart';
import 'package:learn_english/widgets/animated_home_components.dart';
```

### Basic Examples

#### 1. Fade In Any Widget
```dart
FadeInAnimation(
  child: Text('Hello'),
)
```

#### 2. Scale In (Bounce Effect)
```dart
ScaleInAnimation(
  startScale: 0.5,
  child: Icon(Icons.star),
)
```

#### 3. Slide In from Top
```dart
SlideInAnimation(
  direction: SlideDirection.fromTop,
  child: Container(),
)
```

#### 4. Floating Motion
```dart
FloatingAnimation(
  offset: 15.0,
  child: Icon(Icons.favorite),
)
```

#### 5. Animated Button
```dart
AnimatedElevatedButton(
  onPressed: () => print('Clicked!'),
  child: Text('Click Me'),
)
```

#### 6. Loading Spinner
```dart
AnimatedLoadingSpinner(
  color: Colors.blue,
)
```

#### 7. Page Transition
```dart
Navigator.push(
  context,
  SlidePageRoute(page: NextScreen()),
)
```

#### 8. Stat Card
```dart
AnimatedStatCard(
  icon: Icons.star,
  count: 100,
  label: 'Points',
  color: Colors.blue,
)
```

#### 9. Progress Bar
```dart
AnimatedProgressBar(
  progress: 0.75,
)
```

#### 10. Animated Counter
```dart
AnimatedCounter(
  count: 1500,
  style: TextStyle(fontSize: 24),
)
```

---

## Most Used Animations

### #1 - Fade In (Most Common)
```dart
FadeInAnimation(
  duration: Duration(milliseconds: 500),
  delay: Duration(milliseconds: 200),
  child: Text('Appears with fade'),
)
```

### #2 - Page Transitions
```dart
Navigator.push(
  context,
  SlidePageRoute(page: HomeScreen()), // Slides from right
  // OR
  ScalePageRoute(page: HomeScreen()), // Bounces in
)
```

### #3 - Button Feedback
```dart
AnimatedElevatedButton(
  onPressed: _handleClick,
  child: Text('Click'),
)
```

### #4 - Loading Indicator
```dart
AnimatedLoadingSpinner(
  size: 50,
  color: Colors.blue,
)
```

### #5 - List Items (Stagger)
```dart
AnimatedListView(
  items: yourList,
  itemBuilder: (context, index, item) => ListTile(title: Text(item)),
)
```

---

## Common Patterns

### Pattern 1: Entrance Sequence
```dart
Column(
  children: [
    SlideInAnimation(
      delay: Duration.zero,
      child: Title(),
    ),
    SlideInAnimation(
      delay: Duration(milliseconds: 100),
      child: Subtitle(),
    ),
    FadeInAnimation(
      delay: Duration(milliseconds: 200),
      child: Content(),
    ),
  ],
)
```

### Pattern 2: Interactive Feedback
```dart
AnimatedLiftCard(
  onTap: () => print('Tapped!'),
  child: Card(child: Text('Tap me')),
)
```

### Pattern 3: Loading State
```dart
if (isLoading)
  AnimatedLoadingSpinner()
else
  Content()
```

### Pattern 4: Stats Display
```dart
Row(
  children: [
    AnimatedStatCard(
      icon: Icons.star,
      count: 100,
      label: 'Points',
      color: Colors.blue,
    ),
    AnimatedStatCard(
      icon: Icons.fire,
      count: 5,
      label: 'Streak',
      color: Colors.red,
    ),
  ],
)
```

### Pattern 5: Daily Goal
```dart
AnimatedDailyGoalCard(
  currentXP: 15,
  targetXP: 20,
)
```

---

## Customization

### Change Duration
```dart
FadeInAnimation(
  duration: Duration(milliseconds: 800),
  child: Widget(),
)
```

### Change Delay
```dart
FadeInAnimation(
  delay: Duration(milliseconds: 500),
  child: Widget(),
)
```

### Change Color
```dart
AnimatedStatCard(
  icon: Icons.star,
  count: 100,
  label: 'Points',
  color: Colors.purple, // Any color
)
```

### Change Scale
```dart
ScaleInAnimation(
  startScale: 0.3, // Start very small
  child: Widget(),
)
```

### Change Direction
```dart
SlideInAnimation(
  direction: SlideDirection.fromLeft, // fromRight, fromTop, fromBottom
  child: Widget(),
)
```

---

## Animation Parameters Quick Reference

### FadeInAnimation
- `duration` - How long animation lasts (default: 500ms)
- `delay` - Wait time before starting (default: 0ms)
- `child` - Widget to animate

### SlideInAnimation
- `direction` - fromLeft, fromRight, fromTop, fromBottom
- `delay` - Wait time before starting
- `child` - Widget to animate

### ScaleInAnimation
- `startScale` - Starting size (0.0-1.0)
- `delay` - Wait time before starting
- `child` - Widget to animate

### FloatingAnimation
- `offset` - How far to float (in pixels)
- `duration` - Float cycle duration (default: 3s)
- `child` - Widget to animate

### AnimatedElevatedButton
- `onPressed` - Callback when clicked
- `duration` - Press animation duration
- `child` - Button content

### AnimatedStatCard
- `icon` - Icon to display
- `count` - Number to show
- `label` - Text label
- `color` - Card color
- `delay` - Stagger delay

### AnimatedProgressBar
- `progress` - 0.0 to 1.0
- `height` - Bar height
- `progressColor` - Color of filled part
- `backgroundColor` - Color of empty part

---

## Tips & Tricks

### Tip 1: Stagger Delays
```dart
for (int i = 0; i < items.length; i++) {
  FadeInAnimation(
    delay: Duration(milliseconds: i * 100),
    child: items[i],
  )
}
```

### Tip 2: Combine Animations
```dart
SlideInAnimation(
  child: FadeInAnimation(
    child: ScaleInAnimation(
      child: Widget(),
    ),
  ),
)
```

### Tip 3: Conditional Animations
```dart
isVisible ? FadeInAnimation(child: Widget()) : SizedBox.shrink()
```

### Tip 4: Animation with Callback
```dart
AnimatedElevatedButton(
  onPressed: () {
    // Called after animation completes
    Navigator.push(...);
  },
  child: Text('Click'),
)
```

### Tip 5: Custom Curves
```dart
FadeInAnimation(
  // Uses CustomCurves.easeOutSmooth by default
  // But you can pass custom curves
  child: Widget(),
)
```

---

## Performance Tips

✅ **DO**
- Use `const` widgets when possible
- Dispose controllers properly
- Test on real devices
- Keep animations under 600ms
- Use simple curves

❌ **DON'T**
- Animate every element
- Use very long durations (>2s)
- Stack too many animations
- Use heavy blur effects
- Forget to profile

---

## Common Issues

### Issue: Animation Stutters
**Solution**: Reduce number of simultaneous animations or blur radius

### Issue: Animation Doesn't Show
**Solution**: Check if widget is wrapped correctly and duration is set

### Issue: Animation Restarts on Rebuild
**Solution**: Extract animated widget to separate StatefulWidget

### Issue: Button Feedback Feels Slow
**Solution**: Reduce duration to 200-300ms

### Issue: List Animations Lag
**Solution**: Use `itemBuilder` in AnimatedListView, not manual stagger

---

## Testing Animations

```dart
// In your test widget:
group('Animations', () {
  testWidgets('FadeIn animation displays', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: FadeInAnimation(child: Text('Test')),
        ),
      ),
    );
    
    expect(find.text('Test'), findsOneWidget);
    
    // Wait for animation
    await tester.pumpAndSettle();
    expect(find.text('Test'), findsOneWidget);
  });
});
```

---

## Next Steps

1. ✅ Browse the examples above
2. ✅ Copy/paste into your screens
3. ✅ Run the app to see animations
4. ✅ Customize parameters as needed
5. ✅ Read ANIMATION_GUIDE.md for details

---

## See Also

- `ANIMATION_GUIDE.md` - Complete documentation
- `ANIMATIONS_VISUAL_REFERENCE.md` - Visual examples
- `lib/utils/animations.dart` - Source code
- `lib/widgets/animated_components.dart` - Components code

---

Your app is now AMAZING! 🚀

Generated with ❤️
