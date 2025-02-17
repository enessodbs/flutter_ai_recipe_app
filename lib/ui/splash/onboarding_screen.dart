import 'package:flutter/material.dart';
import 'package:flutter_recipe_app/data/onboard_data/onboard_data.dart';
import 'package:flutter_recipe_app/ui/auth/login_page.dart';
import 'package:flutter_recipe_app/ui/splash/components/content_template.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int selectedIndex = 0;
  late PageController controller;

  @override
  void initState() {
    controller = PageController(initialPage: 0, keepPage: true, viewportFraction: 1);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('seenOnboarding', true); // Onboarding tamamlandığını kaydet
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            style: TextButton.styleFrom(
              textStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('SKIP'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                onPageChanged: (value) => setState(() => selectedIndex = value),
                itemCount: OnboardData.onboardingItemList.length,
                itemBuilder: (context, index) {
                  return ContentTemplate(item: OnboardData.onboardingItemList[index]);
                },
              ),
            ),
            SizedBox(height: size.height * 0.05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    ...List.generate(
                      OnboardData.onboardingItemList.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                        width: selectedIndex == index ? 24 : 8,
                        height: 8,
                        margin: const EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: selectedIndex == index ? Colors.orange : Colors.grey[500],
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    if (selectedIndex < OnboardData.onboardingItemList.length - 1) {
                      controller.animateToPage(
                        selectedIndex + 1,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    } else {
                      completeOnboarding(); // Son sayfadaysa onboarding tamamlandı olarak işaretle
                    }
                  },
                  child: const CircleAvatar(
                    radius: 35,
                    backgroundColor: Colors.orange,
                    child: Icon(
                      Icons.arrow_forward,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: size.height * 0.05),
          ],
        ),
      ),
    );
  }
}
