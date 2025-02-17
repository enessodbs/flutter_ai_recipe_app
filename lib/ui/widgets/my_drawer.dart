import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_recipe_app/ui/cubit/auth_cubit.dart';
import 'package:iconsax/iconsax.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue, // Buraya uygun bir renk verebilirsin
            ),
            child: Row(
              children: [
                const Text(
                  'Drawer Header',
                  style: TextStyle(color: Colors.white, fontSize: 24),
                ),
                IconButton(
                    onPressed: () {
                      context.read<AuthCubit>().signOut();
                    },
                    icon: Icon(Iconsax.logout)),
              ],
            ),
          ),
          const ListTile(
            leading: Icon(Iconsax.setting_2),
            title: Text("Settings"),
          ),
        ],
      ),
    );
  }
}
