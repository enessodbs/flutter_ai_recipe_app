import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/data/onboard_data/model/onboarding_item.dart';

class ContentTemplate extends StatelessWidget {
  const ContentTemplate({
    required this.item,
    super.key,
  });

  final OnboardingItemModel item;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        // Görsel
        Image.asset(
          item.image,
          fit: BoxFit.cover, // Görselin düzgün görünmesini sağlar
        ),
        SizedBox(height: size.height * 0.05),

        // Başlık
        Text(
          item.title,
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
        ),
        SizedBox(height: size.height * 0.01),

        // Alt başlık
        Text(
          item.subtitle,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: Colors.black,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
