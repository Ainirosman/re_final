// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/registrationscreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../models/user.dart';
import 'homescreen.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  final TextEditingController _emailEditingController = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  var screenHeight, screenWidth, cardwitdh;
  
  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      cardwitdh = screenWidth;
    } else {
      cardwitdh = screenWidth;
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
          child: SingleChildScrollView(
              child: SizedBox(
        width: screenWidth,
        child: Column(
          children: [
            const SizedBox(
              height: 20,),
            Card(elevation: 8,
                margin: const EdgeInsets.all(8),
                child: Container(padding: const EdgeInsets.all(16),
                    child: Form(key: _formKey,
                      child: Column(children: [
                        TextFormField(
                            controller: _emailEditingController,
                            keyboardType: TextInputType.emailAddress,
                            validator: (val) => val!.isEmpty ||
                                    !val.contains("@") ||
                                    !val.contains(".")
                                ? "enter a valid email"
                                : null,
                            decoration: const InputDecoration(
                                labelText: 'Email',
                                labelStyle: TextStyle(),
                                icon: Icon(Icons.email),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(width: 1.0),
                                ))),
                        TextFormField(
                            controller: _passwordEditingController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(),
                              icon: Icon(Icons.password),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(width: 1.0),
                              ),
                            )),
                        const SizedBox(height: 5,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Checkbox(
                              value: _isChecked,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked = value!;
                                  saveremovepref(value);
                                });
                              },
                            ),
                            Flexible(
                              child: GestureDetector(
                                onTap: null,
                                child: const Text('Remember Me',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    )),
                              ),
                            ),
                            MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                              minWidth: 100,
                              height: 40,
                              elevation: 8,
                              onPressed: _loginUser,
                              color: Theme.of(context).colorScheme.primary,
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                      ]),
                    ))),
            GestureDetector(
              onTap: _goLogin,
              child: const Text(
                "Create a new account",
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            GestureDetector(
              onTap: _goHome,
              child: const Text("Home", style: TextStyle(fontSize: 18)),
            )
          ],
        ),
      ))),
    );
  }

  void _loginUser() {
    if (!_formKey.currentState!.validate()) {
      Fluttertoast.showToast(
          msg: "Login with your email and password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }

    String email = _emailEditingController.text;
    String password = _passwordEditingController.text;
    http.post(Uri.parse("http://10.19.60.44/homestay/php/login_user.php"),
        body: {
          "email": email, 
          "password": password})
          .then((response) {
      print(response.body);
      if(response.statusCode == 200){
        var jsonResponse = json.decode(response.body);
        print(jsonResponse);
        User user = User(
        id: jsonResponse['id'], 
        name: jsonResponse['name'], 
        email: jsonResponse['email'], 
        password: jsonResponse['password'], 
        address: "", 
        phone: "", 
        regdate: "", otp: '');
        Navigator.push(
          context, MaterialPageRoute(
            builder: (content) => homeScreen(user: user)));
      }else{
        Fluttertoast.showToast(msg: "Login Fails",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 14);
      }});}
      

  void _goHome() {
   User user = User(
        id: "0",
        email: "ainirosmn@gmail.com",
        name: "Aini",
        address: "na",
        phone: "0123456789",
        regdate: "0", 
        password: '', otp: '');
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (content) => homeScreen(
                  user: user,
                )));
  }

  void _goLogin() {
    Navigator.push(context,
        MaterialPageRoute(builder: (content) => const registrationScreen()));
  }

  void saveremovepref(bool value) async {
    String email = _emailEditingController.text;
    String password = _passwordEditingController.text;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (value) {
      if (!_formKey.currentState!.validate()) {
        Fluttertoast.showToast(
            msg: "Please fill in the login credentials",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        _isChecked = false;
        return;
      }
      await prefs.setString('email', email);
      await prefs.setString('password', password);
      Fluttertoast.showToast(
          msg: "Preference Stored",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    } else {
      //delete preference
      await prefs.setString('email', '');
      await prefs.setString('password', '');
      setState(() {
        _emailEditingController.text = '';
        _passwordEditingController.text = '';
        _isChecked = false;
      });
      Fluttertoast.showToast(
          msg: "Preference Removed",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
    }
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    String password = (prefs.getString('password')) ?? '';
    if (email.isNotEmpty) {
      setState(() {
        _emailEditingController.text = email;
        _passwordEditingController.text = password;
        _isChecked = true;
      });
    }
  }
}