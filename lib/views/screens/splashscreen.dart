import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/homescreen.dart';
import 'dart:async';

import '../../models/user.dart';

class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
  // TODO: implement createState

}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    super.initState();
    User user = User(
        id: "0",
        name: "Unregistered",
        email: "Unregistered",
        phone: "01234567890",
        address: "NA",
        regdate: "0",
        otp: "0", password: null);
    Timer(
        const Duration(seconds: 5),
        () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => homeScreen(
                      user: user,
                    ))));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/homestay.png'),
                    fit: BoxFit.cover))),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              SizedBox(height: 150),
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(height: 50),
              Text("Version 0.1.1", style: TextStyle(color: Colors.white))
            ],
          ),
        ),
      ],
    ));
  }
}
