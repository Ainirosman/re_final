// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../shared/mainmenuwidget.dart';

class homeScreen extends StatefulWidget {
  final User user;
  const homeScreen({super.key, required this.user});

  @override
  State<homeScreen> createState() => _homeScreenState();
  // ignore: todo
  // TODO: implement createState

}

class _homeScreenState extends State<homeScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Home"),
          ),
          body: const Center(
            child: Text("home"),
          ),
          drawer: MainMenuWidget(user: widget.user),
        ));
  }
}
