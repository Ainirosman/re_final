import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../shared/mainmenuwidget.dart';

class profileScreen extends StatefulWidget {
  final User user;
  const profileScreen({super.key, required this.user});

  @override
  State<StatefulWidget> createState() => _profileScreenState();
  // TODO: implement createState

}

class _profileScreenState extends State<profileScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: const Center(
          child: Text("profile"),
        ),
        drawer: MainMenuWidget(user: widget.user),
      ),
    );
  }
}
