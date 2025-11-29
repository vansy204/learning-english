import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../features/auth/services/auth_service.dart';
import '../features/auth/services/pin_security_service.dart';
import '../utils/animations.dart';
import 'login_screen.dart';
import 'home_screen.dart';
import 'pin_verification_screen.dart';

/// AuthWrapper tự động chuyển đổi giữa Login và Home screen
/// dựa trên auth state
class AuthWrapper extends StatefulWidget {
  const AuthWrapper({Key? key}) : super(key: key);

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> with WidgetsBindingObserver {
  bool _userDataLoaded = false;
  bool _isPinVerified = false;
  final _pinService = PinSecurityService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Reset PIN verification when app goes to background
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.inactive) {
      setState(() {
        _isPinVerified = false;
      });
    }
  }

  Future<void> _checkAndShowPinVerification() async {
    final pinEnabled = await _pinService.isPinEnabled();
    if (pinEnabled && !_isPinVerified && mounted) {
      final result = await Navigator.push<bool>(
        context,
        MaterialPageRoute(
          builder: (context) => const PinVerificationScreen(),
          fullscreenDialog: true,
        ),
      );

      if (result == true && mounted) {
        setState(() {
          _isPinVerified = true;
        });
      } else if (mounted) {
        // PIN verification failed or cancelled - keep showing verification
        _checkAndShowPinVerification();
      }
    } else {
      setState(() {
        _isPinVerified = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return StreamBuilder<User?>(
      stream: authService.authStateChanges,
      builder: (context, snapshot) {
        // Đang loading - with animated loading indicator
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingAnimation(
                    offset: 20.0,
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5EB1FF).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Color(0xFF5EB1FF)),
                          strokeWidth: 4,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FadeInAnimation(
                    delay: const Duration(milliseconds: 300),
                    child: Text(
                      'Loading your learning journey...',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color(0xFF94A3B8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        // Đã đăng nhập
        if (snapshot.hasData && snapshot.data != null) {
          // Load user data from Firestore if not loaded yet
          if (!_userDataLoaded) {
            _userDataLoaded = true;
            // Load asynchronously without blocking UI
            WidgetsBinding.instance.addPostFrameCallback((_) {
              authService.loadUserData();
            });
          }

          // Check PIN authentication
          if (!_isPinVerified) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _checkAndShowPinVerification();
            });
          }

          // Show HomeScreen with animation (PIN verification will overlay if needed)
          return FadeInAnimation(
            child: const HomeScreen(),
          );
        }

        // Reset flags when user logs out
        _userDataLoaded = false;
        _isPinVerified = false;

        // Chưa đăng nhập
        return const LoginScreen();
      },
    );
  }
}
