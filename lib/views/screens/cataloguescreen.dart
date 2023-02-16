import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/screens/loginscreen.dart';
import 'package:flutter_application_1/views/screens/registrationscreen.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ndialog/ndialog.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../config.dart';
import '../../models/homestay.dart';
import '../../models/user.dart';
import '../shared/mainmenuwidget.dart';
import 'newhomestayscreen.dart';

class catalogueScreen extends StatefulWidget {
  final User user;
  const catalogueScreen({super.key, required this.user});

  @override
  State<catalogueScreen> createState() => _catalogueScreenState();
  // TODO: implement createState

}

class _catalogueScreenState extends State<catalogueScreen> {
  late Position position;
  List<homestay> homestayList = <homestay>[];
  String titlecenter = "loading";
  late double screenHeight, screenWidth, resWidth;
  int rowCount = 2;

  @override
  void dispose() {
    super.initState();
    _loadhomestay();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth <= 600) {
      resWidth = screenWidth;
      rowCount = 3;
    }
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Catalogue"),
          actions: [
            IconButton(
                onPressed: registrationForm,
                icon: const Icon(Icons.app_registration)),
            IconButton(
              onPressed: loginForm,
              icon: const Icon(Icons.login),
            ),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  const PopupMenuItem<int>(
                    value: 0,
                    child: Text("Add New Homestay"),
                  ),
                  const PopupMenuItem<int>(
                    value: 1,
                    child: Text("My Order"),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 0) {
                  _gotoNewHomestay();
                } else if (value == 1) {
                  print("My Order already selected");
                }
              },
            ),
          ],
        ),
        body: homestayList.isEmpty
            ? Center(
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold)))
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      "Your current homestay(${homestayList.length} found)",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: rowCount,
                      children: List.generate(homestayList.length, (index) {
                        return Card(
                          elevation: 0,
                          child: InkWell(
                            onTap: () {},
                            onLongPress: () {},
                            child: Column(children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Flexible(
                                flex: 5,
                                child: CachedNetworkImage(
                                  width: resWidth / 2,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${Config.server}/assets/homestayImage/${homestayList[index].hsId}-1.png",
                                  placeholder: (context, url) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                              Flexible(
                                  flex: 4,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Text(
                                          truncateString(
                                              homestayList[index]
                                                  .prname
                                                  .toString(),
                                              15),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                            "RM ${double.parse(homestayList[index].prprice.toString()).toStringAsFixed(2)}"),
                                      ],
                                    ),
                                  ))
                            ]),
                          ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
        drawer: MainMenuWidget(user: widget.user),
      ),
    );
  }

  void registrationForm() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const registrationScreen()));
  }

  void loginForm() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => loginScreen()));
  }

  Future<void> _gotoNewHomestay() async {
    ProgressDialog progressDialog = ProgressDialog(
      context,
      blur: 10,
      message: const Text("Searching your current location"),
      title: null,
    );
    progressDialog.show();
    if (widget.user.id == "0") {
      Fluttertoast.showToast(
          msg: "Please login/register to add new homestay",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      progressDialog.dismiss();
      return;
    }
    if (await _checkPermissionGetLoc()) {
      progressDialog.dismiss();
      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (content) =>
                  NewHomestayScreen(user: widget.user, position: position, placemarks: [],)));
      _loadhomestay();
    } else {
      Fluttertoast.showToast(
          msg: "Please allow the app to access the location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      progressDialog.dismiss();
    }
  }

  Future<bool> _checkPermissionGetLoc() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
            msg: "Please allow the app to access the location",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            fontSize: 14.0);
        Geolocator.openLocationSettings();
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(
          msg: "Please allow the app to access the location",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      Geolocator.openLocationSettings();
      return false;
    }
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best);
    return true;
  }

  void _loadhomestay() {
    http
        .get(
      Uri.parse(
          "${Config.server}/php/load_homestay.php?userid=${widget.user.id}"),
    )
        .then((response) {
      if (response.statusCode == 200) {
        var jsondata = json.decode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          if (extractdata['homestay'] != null) {
            homestayList = <homestay>[];
            extractdata['homestay'].forEach((v) {
              homestayList.add(homestay.fromJson(v));
            });
            titlecenter = "Found";
          } else {
            titlecenter = "No Homestay Available";
            homestayList.clear();
          }
        }
      } else {
        titlecenter = "No Homestay Available";
        homestayList.clear();
      }
      setState(() {});
    });
  }

  String truncateString(String str, int size) {
    if (str.length > size) {
      str = str.substring(0, size);
      return "$str...";
    } else {
      return str;
    }
  }
}
