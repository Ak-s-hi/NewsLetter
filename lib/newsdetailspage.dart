import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

class NewsDetailsPage extends StatefulWidget {
  List<Map<String, dynamic>> NewsDetailsList =[];
  String title="";
  String ImageUrl="";
  String publishedAt="";
  String content="";
  // NewsDetailsPage({Key? key}) : super(key: key);
   NewsDetailsPage({Key? key, required this.title, required this.ImageUrl, required this.publishedAt, required this.content}) : super(key: key);

  @override
  _NewsDetailsPageState createState() => _NewsDetailsPageState();
}

class _NewsDetailsPageState extends State<NewsDetailsPage>with TickerProviderStateMixin {


  @override
  void initState() {

    super.initState();

  }

  @override
  void dispose() {

    super.dispose();
  }
  String formatDateToGMT(String dateTimeString) {
    DateTime parsedDate = DateTime.parse(dateTimeString).toUtc();  // Convert to UTC for GMT
    String formattedDate = DateFormat('EEE, dd MMM yyyy HH:mm').format(parsedDate) + ' GMT';

    return formattedDate;
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child:Column( children:[

            Expanded(
                flex: 1,
                child:Padding(padding: EdgeInsets.only(left:15,right: 15),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment
                          .spaceBetween,
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .center,
                      children: <Widget>[
                        TextButton.icon(onPressed: (){
                          setState(() {
Navigator.pop(context);
                          });

                        },
                          icon: Icon(
                            Icons.arrow_back_ios,
                            size: 20,
                          ),
                          label: Text("Back",style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),

                        ),

                      ],
                    ))),
              Expanded(
              flex: 6,
              child:  Hero(tag:'hero-tag', child:
            Container(
              height: height * 0.25,
              width: double.infinity,
              margin: EdgeInsets.only(left: 15,right: 15,top:5,bottom: 5),
              decoration: BoxDecoration(

                borderRadius:
                BorderRadius.circular(7),
                border: Border.all( color: Colors.transparent, width: 4.0), // Circular border
                image: DecorationImage(
                   // image: CachedNetworkImageProvider("https://picsum.photos/250?image=9"),
                image: CachedNetworkImageProvider( widget.ImageUrl),
                  fit: BoxFit.cover,
                ),
              ),

              // child: Image.network('https://picsum.photos/250?image=9'),
            ))),
          Expanded(
              flex: 2,
              child:Padding(padding: EdgeInsets.only(left:15,right: 15),child:Text(
              widget.title,
              overflow:
              TextOverflow
                  .ellipsis,
              maxLines: 5,
              textAlign:
              TextAlign
                  .left,

              style: GoogleFonts
                  .andikaNewBasic(
                textStyle: const TextStyle(

                    fontWeight:
                    FontWeight
                        .bold,
                    fontSize:
                    20,
                    letterSpacing:
                    0.3),
              ),
            ),)),
            Expanded(
                flex: 1,
                child:Padding(padding: EdgeInsets.only(left:15,right: 15),
                    child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween,
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .center,
                  children: <Widget>[
                    Expanded(
                        flex: 1,
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.grey,
                          size: 20,
                        )
                    ),
                    Expanded(
                      flex: 12,
                      child: Container(
                        padding:
                        const EdgeInsets
                            .only(
                            left: 5),
                        child: Text(
                          formatDateToGMT(widget.publishedAt),
                          overflow:
                          TextOverflow
                              .ellipsis,
                          maxLines: 1,
                          textAlign:
                          TextAlign
                              .left,

                          style: GoogleFonts
                              .andikaNewBasic(
                            textStyle: const TextStyle(
                              fontSize:
                              12,
                              letterSpacing:
                              0.3,
                              color: Colors.grey,),
                          ),
                        ),
                      ),
                    ),
                  ],
                ))),
            Expanded(
                flex: 11,
                child:Padding(padding: EdgeInsets.only(left:15,right: 15),
                  child:Text(
                    widget.content,
                    overflow:
                    TextOverflow
                        .ellipsis,
                    maxLines: 20,
                    textAlign:
                    TextAlign
                        .left,

                    style: GoogleFonts
                        .andikaNewBasic(
                      textStyle: const TextStyle(

                          fontSize:
                          14,
                          letterSpacing:
                          0.3),
                    ),
                  ),)
            ),

          ])),
    );
  }
}