import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../screens/cataloguescreen.dart';
import '../screens/homescreen.dart';
import '../screens/profilescreen.dart';

class MainMenuWidget extends StatefulWidget {
  final User user;
  const MainMenuWidget({super.key, required this.user});

  @override
  State<MainMenuWidget> createState() => _MainMenuWidgetState();
  // ignore: todo
  // TODO: implement createState

}

class _MainMenuWidgetState extends State<MainMenuWidget> {
  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return Drawer(
      width: 250,
      elevation: 15,
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(widget.user.name.toString()),
            accountEmail: Text(widget.user.email.toString()),
            currentAccountPicture: const CircleAvatar(
              radius: 30,
            ),
          ),
          ListTile(
            title: const Text("Home"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => homeScreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text("Profile"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) => profileScreen(user: widget.user)));
            },
          ),
          ListTile(
            title: const Text("Catalogue"),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (content) =>
                          catalogueScreen(user: widget.user)));
            },
          ),
        ],
      ),
    );
  }
}
