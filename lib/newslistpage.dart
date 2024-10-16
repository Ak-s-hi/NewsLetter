import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import 'newsdetailspage.dart';

class NewsListPage extends StatefulWidget {
  const NewsListPage({Key? key}) : super(key: key);

  @override
  _NewsListPageState createState() => _NewsListPageState();
}

class _NewsListPageState extends State<NewsListPage>with TickerProviderStateMixin {

   late final TabController _tabController;
   List<dynamic> newslist=[];
   List<dynamic> favslist=[];
   int NewsFavsView = 0 ;
   bool loadPage = false;
  @override
  void initState() {
    Loaddata();
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    setState(() {
      loadPage=true;
    });
  }

   @override
   void dispose() {
     _tabController.dispose();
     super.dispose();
   }
   String formatDateToGMT(String dateTimeString) {
     DateTime parsedDate = DateTime.parse(dateTimeString).toUtc();  // Convert to UTC for GMT
     String formattedDate = DateFormat('EEE, dd MMM yyyy HH:mm').format(parsedDate) + ' GMT';

     return formattedDate;
   }
   Future<void> Loaddata() async {
     setState(() {
       loadPage = false;
     });
    if(NewsFavsView==0) {
      var api = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=aaac6f2ec69d4d7397c3a7d098368d34";

      http.Response result =
      await http.get(Uri.parse(api));
      var decodedData = jsonDecode(result.body);
      if (decodedData is Map<String, dynamic>) {
        newslist = decodedData['articles'];
      }
    }
    else {
      newslist= favslist;
    }
    setState(() {
      loadPage = true;
    });
    }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
          child:Column( children:[
          Container(

        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

                TextButton.icon(onPressed: (){
                  setState(() {
                    NewsFavsView = 0;
                  });
                  Loaddata();
                },
                  icon: Icon(
                    Icons.list
                ),
                    label: Text("News",style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25
                ),), style: TextButton.styleFrom(
                    primary: Colors.black,// Text color
                      backgroundColor:NewsFavsView == 1 ? Colors.transparent : Color(0xBFAFD7DE)
                  ),

                ),
                TextButton.icon(onPressed: (){
                  setState(() {
                    NewsFavsView = 1;
                  });
                  Loaddata();
                },
                  icon: Icon(
                    Icons.favorite,color:Colors.redAccent,
                ),
                  label: Text("Favs",
                  style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25
                ),
                ),
                  style: TextButton.styleFrom(
                  primary: Colors.black, // Text color
                    backgroundColor:NewsFavsView == 0 ? Colors.transparent : Color(0xBFAFD7DE)
                ),)


          ],
        ),
      ),
            loadPage ?   newslist.isNotEmpty ?  Container(
            height: height * 0.88,
            width: width * 0.99,
            padding: EdgeInsets.all(7),
            child: ListView.builder(
                itemCount: newslist.length,
                itemBuilder: (BuildContext context, int index) {
                  return Dismissible(
                      key: Key(newslist[index]['author']),
                      direction: DismissDirection.endToStart,
                      background: Container(
                  decoration: BoxDecoration(
                    color: Color(0x5CF1929B),
                  borderRadius:
                  BorderRadius.circular(7),
                  border: Border.all( color: Colors.transparent, width: 4.0), ),// Circular border

                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child:NewsFavsView==0? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite, color: Colors.red,size: 35,),
                            Text("Add to"),
                            Text("Favorite")
                          ],
                        ):Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.delete_forever_outlined, color: Colors.grey,size: 35,),
                          Text("Remove from"),
                          Text("Favorite")
                        ],
                      )
                      ),
                      onDismissed: (direction){
                        setState(() {
                          if(NewsFavsView ==0){
                          favslist.add(newslist[index]);
                         newslist.removeAt(index);
                          }
                          else{
                            newslist.removeAt(index);
                            favslist.removeAt(index);
                          }
                        });
                       Loaddata();
                      },
                      child: InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) =>  NewsDetailsPage(title :newslist[index]['title'],ImageUrl :newslist[index]['urlToImage'] ,publishedAt :newslist[index]['publishedAt'] ,content :newslist[index]['content'])));
                      },
                      child: SizedBox(
                        height: height * 0.14,
                        child: Card(
                            margin: const EdgeInsets.only(
                                right: 5.0,
                                left: 5.0,
                                top: 1,
                                bottom: 10),
                            elevation: 10.0,
                            borderOnForeground: true,
                            semanticContainer: true,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                color: Colors.transparent,
                                  width: 1),
                              borderRadius:
                              BorderRadius.circular(5),
                            ),
                            child:Row(
                              children: [
                                Expanded(flex: 1,
                                    child:     Hero(tag:'hero-tag', child:  Container(
                                       height: 100,
                                        width: 100,
                                      margin: EdgeInsets.all(7),
                                      decoration: BoxDecoration(

                                        borderRadius:
                                        BorderRadius.circular(5),
                                        border: Border.all( color: Colors.transparent, width: 4.0), // Circular border
                                        image: DecorationImage(
                                        //  image: CachedNetworkImageProvider("https://picsum.photos/250?image=9"),
                                          image: CachedNetworkImageProvider( newslist[index]["urlToImage"]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                     // child: Image.network('https://picsum.photos/250?image=9'),
                                    ))),
                                Expanded(flex: 2,
                                    child:Column(
                                      children: [
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: <Widget>[

                                                Expanded(
                                                  flex: 10,
                                                  child: Container(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 5),
                                                    child: Text(
                                                      newslist[index]["title"],
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      maxLines: 2,
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
                                                            14,
                                                            letterSpacing:
                                                            0.3),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: <Widget>[

                                                Expanded(
                                                  flex: 10,
                                                  child: Container(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 5),
                                                    child: Text(
                                                      newslist[index]["description"],
                                                      overflow:
                                                      TextOverflow
                                                          .ellipsis,
                                                      maxLines: 2,
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
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            )),
                                        Expanded(
                                            flex: 1,
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment
                                                  .center,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Icon(
                                                    Icons.calendar_month_outlined,
                                                    color: Colors.grey,
                                                    size: 20,
                                                  )
                                                ),
                                                Expanded(
                                                  flex: 10,
                                                  child: Container(
                                                    padding:
                                                    const EdgeInsets
                                                        .only(
                                                        left: 5),
                                                    child: Text(
                                                      formatDateToGMT(newslist[index]["publishedAt"]),
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
                                            )),
                                      ],
                                    ), ),

                              ],
                            )

                        ),
                      )));
                })) :
            Center(
              heightFactor: height * 0.06,
              child: Text("Oops !! No record ."),):
            Center(
              heightFactor: height * 0.025,
              child: SpinKitChasingDots(
                color: Colors.deepOrange,
                size: 35.0,
              ),)
          ])),
    );
  }
}