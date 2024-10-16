import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'newslistpage.dart';




// import 'package:karkuvelayyanar/Excel/excel_example.dart' as exl;
// import 'dart:async';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Homemobile extends StatefulWidget {

  const Homemobile({Key? key}) : super(key: key);

  @override
  _HomemobileState createState() => _HomemobileState();
}

class _HomemobileState extends State<Homemobile> {
  bool progress = false;

  @override
  void initState() {
    startup();
    super.initState();
  }

  Future startup() async {
    setState(() {
      progress = true;
    });
  }

  Future<bool> _onBackPressed() async {
return false;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            appBar: AppBar(
                title: SizedBox(
                  height: height * 0.05,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text('Dash Board',
                          style: TextStyle(
                            color: Colors.yellow,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Alatsi',
                            fontSize: 25.00,
                          )),
                    ],
                  ),
                ),
                iconTheme: IconThemeData(color: Colors.yellow),
                actions: <Widget>[
                ]),

            body: progress == true
                ? Center(
                    child: Container(
                      width: 300.0,
                      height: 250.0,
                   child: ElevatedButton(
                     child: Text("News"),
                     onPressed: (){
                       Navigator.push(context,
                           MaterialPageRoute(builder: (context) => const NewsListPage()));
                     },
                   ),
                   /*   decoration: BoxDecoration(
                        color: Colors.white24,
                        image: DecorationImage(
                          image: AssetImage('assets/Newsletterlogo.png'),
                          colorFilter: ColorFilter.mode(
                            Colors.white.withOpacity(
                                0.5), // Set your desired opacity here
                            BlendMode.dstATop,
                          ),
                          //   fit: BoxFit.scaleDown,
                        ),
                      ),*/
                    ),
                  )
                : Container()));
  }
}
