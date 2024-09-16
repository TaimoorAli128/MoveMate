import 'package:flutter/material.dart';
import 'package:corider/screens/root.dart';
import 'package:corider/screens/login/login.dart';
import 'package:corider/providers/user_state.dart';

class SplashScreen extends StatefulWidget {
  final UserState userState;

  const SplashScreen({Key? key, required this.userState}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();

    // Navigate to the appropriate screen after 1 second
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => widget.userState.currentUser == null
              ? LoginScreen(userState: widget.userState)
              : RootNavigationView(userState: widget.userState),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF00C9FF), Color(0xFF92FE9D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Logo with fade-in and scale-up animation
          Center(
            child: FadeTransition(
              opacity: _animation,
              child: ScaleTransition(
                scale: _animation,
                child: Image.asset(
                  'assets/images/carpool (1).png', // Replace with your logo asset
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
