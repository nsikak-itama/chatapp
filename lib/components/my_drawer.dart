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
              title: Text("Home", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              leading: Icon(Icons.home, color: Theme.of(context).colorScheme.inversePrimary,),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));},
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 25),
            child: ListTile(
              title: Text("Settings", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              leading: Icon(Icons.settings, color: Theme.of(context).colorScheme.inversePrimary,),
              onTap: () {Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsPage()));},
            ),
          ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(left: 25, bottom: 45),
            child: ListTile(
              title: Text("logout", style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
              leading: Icon(Icons.logout, color: Theme.of(context).colorScheme.inversePrimary),
              onTap: onLogout,
            ),
          ),
        ],
      ),
    );
  }
}
