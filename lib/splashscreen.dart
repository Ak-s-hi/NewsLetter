import 'dart:convert';

import 'package:flutter/material.dart';
import "package:flutter_spinkit/flutter_spinkit.dart";
import 'package:intl/intl.dart';
import 'newslistpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double width = 0;
  double height = 0;
  String dtpDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  int progress = 1;
  String loginstatus = "0";
  String url = "";
  int daysscount = 0;
  @override
  void initState() {

    startup();
    super.initState();
  }

  Future startup() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const NewsListPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white24,
                    image: DecorationImage(
                      image: AssetImage('assets/Newsletterlogo.png'),
                      // fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SpinKitChasingDots(
                      color: Colors.deepOrange,
                      size: 35.0,
                    ),
                    const SizedBox(height: 20.0),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
