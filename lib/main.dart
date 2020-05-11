import 'package:flutter/material.dart';
import 'screens/Home/HomePage.dart';
import 'screens/AnimeList/AnimeList.dart';
import 'screens/AnimeList/AnimeListFavorite.dart';
import 'screens/Category/Category.dart';
import 'widgets/HexColor.dart';
import 'package:firebase_admob/firebase_admob.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FirebaseAdMob.instance.initialize(appId: 'ca-app-pub-4835344368909970~9613087096');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Animese',
      theme: ThemeData(
        scaffoldBackgroundColor: HexColor('#212121'),
        primaryColor: HexColor('#263238'),
//        accentColor: Colors.deepPurpleAccent[600],
//        backgroundColor: HexColor.fromHex('#5a0089'),
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
      },


      home: HomePage(),

    );
  }
}




