import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/constant/color.dart';

class MyIconButton extends StatelessWidget {
  final IconData icon;
  final Function() onPressed;
  const MyIconButton({super.key, required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      style: IconButton.styleFrom(
        backgroundColor: backgroundColor,
        fixedSize: const Size(50, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
