// ignore_for_file: camel_case_types, unused_field, prefer_final_fields, no_leading_underscores_for_local_identifiers, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/cataloguescreen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';
import '../../models/user.dart';

class registrationScreen extends StatefulWidget {
  const registrationScreen({super.key});

  @override
  State<registrationScreen> createState() => _registrationScreenState();
}

class _registrationScreenState extends State<registrationScreen> {
  void iniState(){
    super.initState();
  }

  final TextEditingController _nameEditingController     = TextEditingController();
  final TextEditingController _emailEditingController    = TextEditingController();
  final TextEditingController _passwordEditingController = TextEditingController();
  final TextEditingController _phoneEditingController    = TextEditingController();

  bool _isChecked = false;
  bool _passwordVisible = false;
  final _formKey        = GlobalKey <FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(" Registration Form")),
      body: Center(
        child: SingleChildScrollView(
          child: Card(
          elevation: 8, 
          margin: const EdgeInsets.all(8),
          child: Container(padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(children: [
              TextFormField(
                controller: _nameEditingController,
                keyboardType: TextInputType.text,
                validator: (val) => val!.isEmpty || (val.length < 3)
                 ? "name must be at least 3 characters"
                 : null,
                decoration: const InputDecoration(
                labelText: "Name",
                labelStyle: TextStyle(),
                icon: Icon(Icons.person),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0),
            ))),
              TextFormField(
                controller: _emailEditingController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                labelText: "Email",
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
                labelText: "Password",
                labelStyle: TextStyle(),
                icon: Icon(Icons.password),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0),
            ))),
            TextFormField(
                controller: _phoneEditingController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                labelText: "Phone",
                labelStyle: TextStyle(),
                icon: Icon(Icons.phone),
                focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1.0),
            ))),
            MaterialButton(
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5)),
                minWidth: 115,
                height: 50,
                elevation: 10,
                onPressed: _registerAccountDialog,
                color: Theme.of(context).colorScheme.primary,
                child: const Text("Register"),
            )
            ]),
          ),
        ),
      ),
    )));
  }
  
String? validatePassword(String value){
   String pattern = r'^(?= *?[a-z])(?=.*?[0-9]).{6,}$';
   RegExp regex = RegExp(pattern);
   if(value.isEmpty){
     return "Please enter a password";
   }else{

   if(!regex.hasMatch(value)){
     return "Enter a password";
    }else{
     return null;
    }
  }
}
  void _registerAccountDialog() {

    String _name = _nameEditingController.text;
    String _email = _emailEditingController.text;
    String _password = _passwordEditingController.text;
    String _phone = _phoneEditingController.text;

    if(!_formKey.currentState!.validate()){
    Fluttertoast.showToast(
      msg: "Please complete Registration Form",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      fontSize: 14);
    return;
  }

  showDialog(
   context: context,
   builder: (BuildContext context){
     return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))),
        title: const Text("Register new Account",
        style: TextStyle(),
        ),
        content: const Text("Are you sure?", style: TextStyle()),
        actions: <Widget>[
          TextButton(child: const Text("Yes",style: TextStyle(),
          ),
          onPressed: (){
            Navigator.of(context).pop();
            _registerUser(_name, _email, _password, _phone);
          },
        ),
        TextButton(child: const Text("No", style: TextStyle(),
        ),
        onPressed: (){
          Navigator.of(context).pop();
        })]);
  });
}

  void _registerUser(String name, String email, String password, String phone) {
     try {
      http.post(Uri.parse("${Config.server}/php/register_user.php"),
        body: {
          "name":name, 
          "email":email,
          "password":password,
          "phone":phone, 
          'register': "register"})
        .then((response){
        if (response.statusCode == 200) {
          Fluttertoast.showToast(
              msg: "Registration Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 1,
              fontSize: 14.0);
          User user = User(
              id: "0",
              name: "Unregistered",
              email: "Unregistered",
              phone: "0123456789",
              address: "NA",
              regdate: "0",
              otp: "0",
              credit: "0");
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (content) => catalogueScreen(
                        user: user,
                      )));
            
          }else{
            Fluttertoast.showToast(msg: "Failed register",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14);
            return;
          }
        });
     }catch(e){
      print(e.toString());
     }
  }
}