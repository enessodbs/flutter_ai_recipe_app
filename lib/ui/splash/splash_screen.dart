import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/ui/splash/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
_controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));

    _animation =
        CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    _animation.addListener(() {
      if (mounted) setState(() {});
    });
    _controller.forward();

    Future.delayed(const Duration(seconds: 2))
        // ignore: use_build_context_synchronously
        .then((value) => Navigator.push(context, MaterialPageRoute(builder: (_) => const OnboardingScreen())));

    super.initState();
 
  }


  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Image.asset(
                'assets/images/splash_1.png',
                height: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
