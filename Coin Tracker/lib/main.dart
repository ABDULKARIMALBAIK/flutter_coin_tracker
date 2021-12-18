import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cointracker/Model/Coin.dart';
import 'package:cointracker/Model/Data.dart';
import 'package:connectivity/connectivity.dart';
import 'package:connectivity_widget/connectivity_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coin Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int index = 1;
  List<Data> currentData = [];
  final int increment = 10;
  bool isLoading = false;

  var connectivityResult;
  bool firstTry = true;

  @override
  Widget build(BuildContext context) {


    setupNetwork();

    return Scaffold(
      appBar: AppBar(
        title: Text("Coin Tracker",style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.yellow,
      ),
      body: body()
    );
  }

  Future _loadMore() async {

    setState(() {
      isLoading = true;
    });

    //Delay
    await Future.delayed(Duration(seconds: 5)); //5 Seconds to display animation

    index = index + 10;

    Future<Coin> futureData = fetchCoins();
    futureData.then((Coin newCoin){

      Coin coin = newCoin;
      print("Length of data now is " + newCoin.data.length.toString() + " , index = " + index.toString() + " , currentData = " +  currentData.length.toString());
      for(int i = 0; i < coin.data.length; i++)
        currentData.add(coin.data[i]);
    });

    setState(() {
      isLoading = false;
    });
  }

  void setupNetwork() async{
    connectivityResult = await Connectivity().checkConnectivity();
  }

  Future<bool> checkNetwork() async{

    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }

  }

  Widget body() {

//    return ConnectivityWidget(
//
//      builder: (context , isOnline){
//        if (isOnline){
//          return Center(
//            child: FutureBuilder(
//              future: fetchCoins(),
//              builder: (context,snapshot){
//
//                if (snapshot.hasData){
//
//                  //This condition to avoid load same data when setState work
//                  if (firstTry){
//                    Coin coin = snapshot.data;
//                    print("Length of data now is " + coin.data.length.toString() + " , index = " + index.toString() + " , currentData = " +  currentData.length.toString());
//                    for(int i = 0; i < coin.data.length; i++)
//                      currentData.add(coin.data[i]);
//
//                    firstTry = !firstTry;
//                  }
//
//                  return LazyLoadScrollView(
//                    isLoading: isLoading,
//                    onEndOfPage: () => _loadMore(),
//                    child: RefreshIndicator(
//                      onRefresh: () async{
//                        await Future.delayed(Duration(seconds: 3) , (){
//
//                          setState(() {
//
//                            index = 1;
//                            currentData.clear();
//                            isLoading = false;
//                            Future<Coin> futureData = fetchCoins();
//                            futureData.then((Coin newCoin){
//
//                              Coin coin = newCoin;
//                              print("Length of data now is " + newCoin.data.length.toString() + " , index = " + index.toString() + " , currentData = " +  currentData.length.toString());
//                              for(int i = 0; i < coin.data.length; i++)
//                                currentData.add(coin.data[i]);
//
//                            });
//                          });
//
//                        });
//                      },
//                      child: ListView.builder(
//                          physics: AlwaysScrollableScrollPhysics(),
//                          itemCount: currentData.length,
//                          itemBuilder: (context,position){
//                            if(isLoading && position == currentData.length - 1)
//                              return Center(child: CircularProgressIndicator(),);
//                            else
//                              return _cointItem(context , currentData[position] , position);
//                          }),
//                    ),
//                  );
//                }
//                else if(snapshot.hasError){
//                  return Text("You don't have connection to internet !!!!");
//                }
//
//                return CircularProgressIndicator();
//
//              },
//            ),
//          );
//        }
//        else
//          return Center(
//            child: Text("You are not connected by any network !"),
//          );
//      },
//    );

    if(connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile){print('network is : ${connectivityResult}');
      return Center(
        child: FutureBuilder(
          future: fetchCoins(),
          builder: (context,snapshot){

            if (snapshot.hasData){

              //This condition to avoid load same data when setState work
              if (firstTry){
                Coin coin = snapshot.data;
                print("Length of data now is " + coin.data.length.toString() + " , index = " + index.toString() + " , currentData = " +  currentData.length.toString());
                for(int i = 0; i < coin.data.length; i++)
                  currentData.add(coin.data[i]);

                firstTry = !firstTry;
              }

              return LazyLoadScrollView(
                isLoading: isLoading,
                onEndOfPage: () => _loadMore(),
                child: RefreshIndicator(
                  onRefresh: () async{
                    await Future.delayed(Duration(seconds: 3) , (){

                      setState(() {

                        index = 1;
                        currentData.clear();
                        isLoading = false;
                        Future<Coin> futureData = fetchCoins();
                        futureData.then((Coin newCoin){

                          Coin coin = newCoin;
                          print("Length of data now is " + newCoin.data.length.toString() + " , index = " + index.toString() + " , currentData = " +  currentData.length.toString());
                          for(int i = 0; i < coin.data.length; i++)
                            currentData.add(coin.data[i]);

                        });
                      });

                    });
                  },
                  child: ListView.builder(
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: currentData.length,
                      itemBuilder: (context,position){
                        if(isLoading && position == currentData.length - 1)
                          return Center(child: CircularProgressIndicator(),);
                        else
                          return _cointItem(context , currentData[position] , position);
                      }),
                ),
              );
            }
            else if(snapshot.hasError){
              return Text("You don't have connection to internet !!!!");
            }

            return CircularProgressIndicator();

          },
        ),
      );
    }
    else if(connectivityResult == ConnectivityResult.mobile){
      return Center(
        child: Text("You are not connected by internet !"),
      );
    }
    else if(connectivityResult == ConnectivityResult.none){
      return Center(
        child: Text("You are not connected by any network !"),
      );
    }
    else{
      return Center(
        child: Text(""),
      );
    }
  }

  Widget _cointItem(BuildContext context, Data data , int position) {

    return AnimatedContainer(
      duration: Duration(seconds: 3),
      curve: Curves.easeOut,
      width: double.infinity,
      decoration: BoxDecoration(
          color: position % 2 == 0 ? Colors.white : Colors.grey[100]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
              
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
//                      CachedNetworkImage(
//                        imageUrl: "https://res.cloudinary.com/dxi90ksom/image/upload/" + data.symbol.toString().toLowerCase() + ".png",
//                        fit: BoxFit.cover,
//                        width: 56,
//                        height: 56,
//                        progressIndicatorBuilder: (context,url,downloadProgress) => CircularProgressIndicator(),
//                        errorWidget: (context,url,index){
//                          return Icon(Icons.monetization_on , color: Colors.yellow, size: 60,);
//                        },
//                      ),
                      Image.network(
                        "https://res.cloudinary.com/dxi90ksom/image/upload/" + data.symbol.toString().toLowerCase() + ".png",
                        fit: BoxFit.cover,
                        errorBuilder: (context, object , stackTrack){
                          return Container(
                            width: 56,
                            height: 56,
                            child: Center(
                              child: Icon(Icons.image_not_supported_outlined , size: 30, color: Colors.red,),
                            ),
                          );
                        },
                        width: 56,
                        height: 56,
                      ),
                      Container(
                        height: 56,
                        child: Stack(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  data.symbol.toString() + " | " + (data.name.toString().length > 10 ? data.name.toString().substring(0 , 9) + "..." : data.name.toString()),
                                  style: GoogleFonts.pacifico(fontSize: 15),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    child: Text(
                      data.quote.uSD.price.toString().substring(0 , 7) + " \$",
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.pacifico(fontSize: 14 , color: Colors.orangeAccent),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  data.quote.uSD.percentChange1h.toString() + " %",
                  style: GoogleFonts.pacifico(
                    fontSize: 12,
                    color: data.quote.uSD.percentChange1h.toString().contains("-") ? Colors.red : Colors.green
                  ),
                ),
                Text(
                  data.quote.uSD.percentChange24h.toString() + " %",
                  style: GoogleFonts.pacifico(
                    fontSize: 12,
                    color: data.quote.uSD.percentChange24h.toString().contains("-") ? Colors.red : Colors.green
                  ),
                ),
                Text(
                  data.quote.uSD.percentChange7d.toString() + " %",
                  style: GoogleFonts.pacifico(
                    fontSize: 12,
                    color: data.quote.uSD.percentChange7d.toString().contains("-") ? Colors.red : Colors.green
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Future<Coin> fetchCoins() async{

    final response = await http.get("..............................................................................");
    if(response.statusCode == 200){

      var data = json.decode(response.body);
      print(Coin.fromJson(data).toString());
      return new Coin.fromJson(data);
    }
    else
      return null;

  }

}
