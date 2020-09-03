import 'package:flutter/material.dart';
import 'screens/Home/HomePage.dart';
import 'screens/AnimeList/AnimeList.dart';
import 'screens/AnimeList/AnimeListFavorite.dart';
import 'screens/Category/Category.dart';
import 'widgets/HexColor.dart';
import 'widgets/BottonBar.dart';

//import 'package:firebase_analytics/firebase_analytics.dart';
//import 'package:firebase_analytics/observer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
//  static FirebaseAnalytics analytics = FirebaseAnalytics();
//  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animese',
      theme: ThemeData(
        scaffoldBackgroundColor: HexColor('#080808'),
        primaryColor: HexColor('#000000'),
        fontFamily: 'Georgia',
        textTheme: TextTheme(
          headline: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          title: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/Home': (BuildContext context) => HomePage(),
        '/AnimeList': (BuildContext context) => AnimesList('Animes'),
        '/MovieList': (BuildContext context) => AnimesList('Filmes'),
        '/OvaList': (BuildContext context) => AnimesList('Ovas'),
        '/AnimeListFavorite': (BuildContext context) => AnimeListFavorite(),
        '/Category': (BuildContext context) => Category(),
        '/BottonBar': (BuildContext context) => BottonBar(),
      },
      home: BottonBar(),

    );
  }
}




