import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/settings_page.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  final void Function()? onLogout;
  const MyDrawer({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(child: Icon(Icons.message, size: 64, color: Theme.of(context).colorScheme.primary)),
          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("H O M E"),
              leading: Icon(Icons.home),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("S E T T I N G S"),
              leading: Icon(Icons.settings),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));},
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("L O G O U T"),
              leading: Icon(Icons.logout),
              onTap: onLogout,
            ),
          ),
        ],
      ),
    );
  }
}
