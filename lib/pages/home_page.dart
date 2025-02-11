import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_recipe_app/pages/auth/login_page.dart';
import 'package:flutter_recipe_app/services/auth/auth_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime? lastPressed;
  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false, // Varsayılan geri dönüşü engeller
      // ignore: deprecated_member_use
      onPopInvoked: (didPop) {
        final now = DateTime.now();
        if (lastPressed == null || now.difference(lastPressed!) > const Duration(seconds: 2)) {
          lastPressed = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Çıkmak için tekrar basın")),
          );
        } else {
          SystemNavigator.pop(); // Uygulamayı kapat
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          actions: [
            IconButton(
              onPressed: () async {
                //Auth service instance'ını oluşturuyoruz
                 final AuthService auth = AuthService();
                 auth.signOut();
                 Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              icon: Icon(Icons.exit_to_app),
            ),
          ],
        ),  
        
      ),
    );
  }
}