# 🎬 Animation Visual Reference Guide

## Quick Visual Examples

This guide shows what each animation looks like when used.

---

## 📍 Location: Login Screen

```
┌─────────────────────────────────────┐
│                                     │
│     ✨ FLOATING MASCOT              │  ← Bounces up/down gently
│        🎓 (floats)                  │     Duration: 4 seconds
│       /   \                          │     Offset: 15px
│      / 📖 \                          │
│     /       \  ✏️                    │  ← Small emojis float
│                                     │
├─────────────────────────────────────┤
│                                     │
│  Welcome Back! ↓ slides from top    │  ← Entrance: SlideInAnimation
│  Sign in to continue  ↓             │     from top, 700ms
│                                     │
├─────────────────────────────────────┤
│                                     │
│  [Email Field] ↓ fades in           │  ← Appears with delay
│  [Password Field] ↓ fades in        │     300ms, 450ms
│  [Login Button] ↓ press shrinks     │  ← Scale 0.92 on press
│                                     │
│  [Sign Up Link] ↓ fades in          │  ← 750ms delay
│  [Quote Box] ↓ fades in             │  ← 900ms delay
│                                     │
└─────────────────────────────────────┘
```

---

## 🎯 Button Press Animation

### Before Press
```
┌──────────────────┐
│  [  Sign In   ]  │  Scale: 1.0
└──────────────────┘
```

### During Press (100ms)
```
┌────────────────┐
│ [ Sign In ]    │  Scale: 0.95 (shrinks slightly)
└────────────────┘
```

### After Release
```
┌──────────────────┐
│  [  Sign In   ]  │  Scale: 1.0 (bounces back with elastic effect)
└──────────────────┘
```

---

## 📊 Loading Screen Animation

```
Loading State → Shows:

      ┌───────────────────┐
      │    ↻ Loading ↺    │  ← Rotating spinner
      │   (Floating up    │     Floats: 20px offset
      │    and down)      │     Duration: 3 seconds
      │                   │
      │ Loading your      │  ← Text fades in
      │ learning journey  │     After 300ms delay
      └───────────────────┘
```

---

## 🏆 Stat Cards Animation

```
Timeline of Appearance:

T=0ms   ┌─────────────┐
        │ Card 1: ⭐  │  ← ScaleInAnimation (0.7 → 1.0)
        │ 1500 XP    │     with FadeInAnimation
        │ Total XP   │     Duration: 600ms
        └─────────────┘

T=150ms ┌─────────────┐
        │ Card 2: 🔥  │  ← Starts 150ms after Card 1
        │ 12 Days    │
        │ Streak     │
        └─────────────┘

T=300ms ┌─────────────┐
        │ Card 3: 🎯  │  ← Starts 300ms after Card 1
        │ 25 Lessons │
        │ Completed  │
        └─────────────┘
```

### Inside Each Stat Card
```
┌─────────────────────────┐
│  ◯ ✨ (pulsing icon)    │  ← PulseAnimation (1.0 → 1.1)
│     Every 1.5 seconds   │     Scale bounce
│                         │
│       1500 XP ↨        │  ← AnimatedCounter
│    (counts from 0)      │     Smooth number animation
│                         │
│    Total XP             │
└─────────────────────────┘
```

---

## 📈 Daily Goal Progress Card

```
┌────────────────────────────────────┐
│  Daily Goal            🔥 (pulsing)│
│  Keep your streak going!           │
│                                    │
│  Progress     15 / 20 XP           │
│  ████████░░░░░░░░░░░░░░  75%      │  ← AnimatedProgressBar
│                                    │
│  ✨ 5 more XP to complete          │  ← Slides up from bottom
│     today's goal                   │
│                                    │
└────────────────────────────────────┘
```

---

## 📚 Lesson Card Hover Effect

### Normal State
```
┌──────────────────────────────────┐
│ [Book] Lesson 1: Grammar Basics  │
│        Learn basic rules → →      │
└──────────────────────────────────┘
Elevation: 0, Shadow: none
```

### On Hover/Tap
```
┌──────────────────────────────────┐  ↑
│ [Book] Lesson 1: Grammar Basics  │  │ Lifts up
│        Learn basic rules → →      │  │ by 20px
└──────────────────────────────────┘  ↓
Elevation: 8px, Shadow: increased
Shadow opacity: 0.2
```

---

## 🏅 Achievement Badge Animation

### Locked State
```
┌──────────────┐
│     🏆       │  Greyed out
│   Master     │  Opacity: 0.5
│ 100 lessons  │  No hover effect
└──────────────┘
```

### Unlocked State (Hover)
```
┌──────────────┐
│ 🏆 (enlarged)│  ScaleTransition
│ 🏆 → 1.2x    │  Color: Full opacity
│   Master     │  Glowing shadow
│ 100 lessons  │
│ ✓ Unlocked   │  Green checkmark
└──────────────┘
```

---

## 🔥 Streak Counter Animation

```
Continuous Pulsing Animation:

Time:  0ms  200ms  400ms  600ms  800ms  1000ms
       │     │      │      │      │       │
Scale: 1.0─→1.15─→1.1─→1.0─→ 0.95→1.0
       │     │      │      │      │       │
       ●     ●      ●      ●      ●       ●

🔥 12 day streak
├─ Fire icon pulses every 1.5 seconds
└─ Text animates with counter
```

---

## ↔️ Page Transitions

### Slide Transition (Left → Right)
```
Screen A                 Transition                  Screen B

[Home]                                             [Profile]
[   ]                                                  [  ]
[   ]   →  Slides over from right  →              [  ]
[   ]      Fades in simultaneously                [  ]
[   ]      Duration: 500ms                        [  ]
[   ]                                             [  ]
```

### Scale Transition (Bounce)
```
Screen A                 Transition                  Screen B

[Home]                                             [Profile]
[   ]                                                  [  ]
[   ]   →  Grows from 0.8x scale  →              [  ]
[   ]      With elastic/bouncy curve               [  ]
[   ]      Duration: 600ms                        [  ]
[   ]                                             [  ]
```

### Rotate Transition (Spin)
```
Current Screen          During Transition         Next Screen

[Home] (0°)        →   [Rotating]  →       [Profile] (360°)
[   ]                   (↻ Spinning)       [  ]
[   ]                   (+ Scaling)        [  ]
[   ]                   (+ Fading)         [  ]
```

---

## 🔘 Animated Button States

### State Machine
```
NORMAL → (press) → PRESSED → (release) → NORMAL

     Scale: 1.0           Scale: 0.92
     │                    │
     ├─ (100ms) ─────────►├─ (Instant)
     │                    │
     Text: visible        Text: visible
     Shadow: normal       Shadow: enhanced
```

---

## 🎬 Empty State Animation

```
┌─────────────────────────────────┐
│                                 │
│      🚀 (floating)              │
│      (up/down 20px)             │
│      Every 3 seconds            │
│                                 │
│    No lessons yet!              │
│  Start learning today!          │
│                                 │
│   [Start Now Button]            │
│   (animated press feedback)      │
│                                 │
└─────────────────────────────────┘
```

---

## 📋 Staggered List Animation

```
Item 1: │░░░░░│─────────────────────────  (delay: 0ms)
        └─ appears at 0ms

Item 2:     │░░░░░│─────────────────────  (delay: 100ms)
            └─ appears at 100ms

Item 3:         │░░░░░│─────────────────  (delay: 200ms)
                └─ appears at 200ms

Item 4:             │░░░░░│─────────────  (delay: 300ms)
                    └─ appears at 300ms

Each item: Fades in + Slides up from bottom
```

---

## 🌊 Floating Animation (Continuous)

```
Position over time:

Y = 0   ────────────────────────────────
         \                        /
Y = -10   \                      /
           \                    /
Y = -20     ✨ ────────────── ✨      ← Offset: ±20px
           /                    \
Y = -10   /                      \
         /                        \
Y = 0   ────────────────────────────────
        0s        2s        4s        6s

Duration: 4 seconds (full cycle)
Curve: easeInOut (smooth acceleration)
```

---

## 💫 Pulse Animation (Icon)

```
Scale over time:

1.15  ┌─┐
      │ │     ┌─┐
      │ │     │ │    ┌─┐
1.0   │ └─┐   │ └─┐  │ └─┐
      │   │   │   │  │   │  Repeating
      │   └─┐ │   └──┘   │
      │     │ │
0.85  └─────┘ └───────────

      └──── 1.5 seconds ────┘

Scale: 1.0 → 1.1 → 1.0 (repeat)
Curve: easeInOut
```

---

## 📝 Typed Text Animation

```
Time:    0ms  50ms  100ms  150ms  200ms
         │    │    │     │     │
Text:    │    │    │     │     │
         H    HE   HEL   HELL  HELLO

Each character appears after 50ms
Character speed: 20 chars/second
Used for: Headlines, titles, messages
```

---

## 🎨 Loading Dots Animation

```
Dot 1:  ● ─── ● ─── ●
Dot 2:      ● ─── ● ─── ●
Dot 3:          ● ─── ● ─── ●

Each dot:
- Scale: 1.0 → 1.3 → 1.0
- Opacity: 0.5 → 1.0 → 0.5
- Offset: 100ms between each
- Total duration: 800ms
```

---

## ⚡ Press Feedback Timeline

```
Timeline of a button press:

T=0ms:      User touches button
            └─ Scale animation starts: 1.0 → 0.92

T=50ms:     Button shrinks
            └─ Haptic feedback (optional)

T=100ms:    Release detected
            └─ Scale animation reverses: 0.92 → 1.0
            └─ onPressed() callback executed

T=200ms:    Animation complete
            └─ Button ready for next press

Total feedback time: 200ms (feels responsive)
```

---

## 🎯 Animation Timing Overview

```
Fast Animations (200-300ms)
├─ Button press feedback
├─ Icon toggle
└─ Quick transitions

Medium Animations (400-600ms)
├─ Page transitions
├─ Card entrances
└─ Fade in/out

Slow Animations (2-4+ seconds)
├─ Floating motion
├─ Continuous rotations
└─ Loading spinners
```

---

## 📊 Performance Impact

```
Animation Type          FPS Impact    Recommended
────────────────────────────────────────────────
Fade/Scale             < 1%          Use freely
Slide transitions      < 2%          Use freely
Bounce effects         < 3%          Use freely
Floating animations    < 1%          Use freely
Rotating spinners      < 2%          Use freely
Shimmer effects        < 3%          Use carefully
Blur/Glass effects     5-10%         Use sparingly

Target: 60 FPS on modern devices
Fallback: 30 FPS on budget devices
```

---

## 🔗 Animation Chains

### Login Flow with Animations
```
1. Screen appears (0ms)
   └─ FadeInAnimation

2. Mascot scales in (0ms)
   └─ ScaleInAnimation (800ms)

3. Mascot floats (0ms)
   └─ FloatingAnimation (continuous)

4. Title slides down (0ms)
   └─ SlideInAnimation (700ms)

5. Subtitle slides down (150ms delay)
   └─ SlideInAnimation (700ms)

6. Email field fades in (300ms delay)
   └─ FadeInAnimation

7. Password field fades in (450ms delay)
   └─ FadeInAnimation

8. Login button fades in (600ms delay)
   └─ FadeInAnimation
   └─ Responds to press

9. Sign-up text fades in (750ms delay)
   └─ FadeInAnimation

10. Quote fades in (900ms delay)
    └─ FadeInAnimation
```

Total visual sequence: ~2 seconds of polished entrance

---

## ✅ Checklist for Using Animations

When adding animations, ensure:

- [ ] Animation duration 200-600ms for most interactions
- [ ] Use appropriate curve (easeOutSmooth for most)
- [ ] Dispose controllers after use
- [ ] Test on real devices
- [ ] Verify 60fps performance
- [ ] Keep animations subtle (not distracting)
- [ ] Use delays for cascade/stagger effects
- [ ] Provide haptic feedback (vibration) on presses
- [ ] Test with animations disabled on low-end devices
- [ ] Document animation behavior in code comments

---

This visual guide helps you understand exactly what each animation does!

Generated with ❤️ for Learn English App
