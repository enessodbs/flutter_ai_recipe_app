import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/constant/color.dart';
import 'package:iconsax/iconsax.dart';

class MyBottomNavigator extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const MyBottomNavigator({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      elevation: 0,
      iconSize: 28,
      currentIndex: selectedIndex,
      selectedItemColor: primaryColor,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      unselectedLabelStyle: const TextStyle(fontSize: 14),
      onTap: onItemSelected,
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(selectedIndex == 0 ? Iconsax.home5 : Iconsax.home_1),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(selectedIndex == 1 ? Iconsax.heart5 : Iconsax.heart),
          label: "Favorites",
        ),
        BottomNavigationBarItem(
          icon: Icon(selectedIndex == 2 ? Iconsax.calendar5 : Iconsax.calendar),
          label: "Meal Plan",
        ),
        BottomNavigationBarItem(
          icon: Icon(selectedIndex == 3
              ? Iconsax.profile_circle5
              : Iconsax.profile_circle),
          label: "Profile",
        ),
      ],
    );
  }
}
