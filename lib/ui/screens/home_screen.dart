import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe_app/constant/color.dart';
import 'package:flutter_recipe_app/ui/cubit/auth_cubit.dart';
import 'package:flutter_recipe_app/ui/widgets/my_banner.dart';
import 'package:flutter_recipe_app/ui/widgets/my_drawer.dart';
import 'package:flutter_recipe_app/ui/widgets/my_icon_button.dart';
import 'package:iconsax/iconsax.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(),
                _buildSearchBar(),
                MyBanner(),
              ],
            ),
          )
        ],
      )),
    );
  }

  Padding _buildSearchBar() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 22),
      child: CupertinoSearchTextField(
        backgroundColor: searchBarColor,
        placeholder: "Search any recipes",
        placeholderStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return BlocBuilder<AuthCubit, void>(
      builder: (context, state) {
        // Kullanıcı adı verisini almak için cubit çağırılır
        final authCubit = context.read<AuthCubit>();
        return FutureBuilder<String?>(
          future: authCubit.getUserName(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading...");
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (!snapshot.hasData) {
              return Text("No username found");
            } else {
              final username = snapshot.data!;
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Hello, $username!",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        "What are you\ncooking today?",
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            height: 1),
                      ),
                    ],
                  ),
                  MyIconButton(
                    icon: Iconsax.notification,
                    onPressed: () {},
                  ),
                ],
              );
            }
          },
        );
      },
    );
  }
}
