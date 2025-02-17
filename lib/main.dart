import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe_app/services/auth/auth_service.dart';
import 'package:flutter_recipe_app/ui/cubit/auth_cubit.dart';
import 'package:flutter_recipe_app/ui/splash/onboarding_screen.dart';
import 'package:flutter_recipe_app/services/auth/auth_gate.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final seenOnboarding = prefs.getBool('seenOnboarding') ?? false;

  runApp(MyApp(seenOnboarding: seenOnboarding));
}

class MyApp extends StatelessWidget {
  final bool seenOnboarding;
  const MyApp({super.key, required this.seenOnboarding});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthCubit(AuthService())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: seenOnboarding ? const AuthGate() : const OnboardingScreen(),
      ),
    );
  }
}
