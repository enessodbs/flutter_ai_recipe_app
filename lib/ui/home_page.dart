import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_recipe_app/ui/screens/favorites_screen.dart';
import 'package:flutter_recipe_app/ui/screens/meal_plans_screen.dart';
import 'package:flutter_recipe_app/ui/screens/profile_screen.dart';
import 'package:flutter_recipe_app/ui/widgets/my_bottom_navigator.dart';
import 'package:flutter_recipe_app/ui/widgets/my_drawer.dart';
import 'package:flutter_recipe_app/ui/screens/home_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;
  late final List<Widget> screens;

  @override
  void initState() {
    screens = [
      const HomeScreen(),
      const FavoritesScreen(),
      const MealPlansScreen(),
      const ProfileScreen(),
    ];
    super.initState();
  }

  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        final now = DateTime.now();
        if (lastPressed == null ||
            now.difference(lastPressed!) > const Duration(seconds: 2)) {
          lastPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Çıkmak için tekrar basın")),
          );
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: MyBottomNavigator(
          selectedIndex: selectedIndex,
          onItemSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
        body: screens[selectedIndex],
      ),
    );
  }
}
