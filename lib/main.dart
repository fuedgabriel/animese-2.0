import 'package:flutter/material.dart';
import 'screens/Home/HomePage.dart';
import 'screens/AnimeList/AnimeList.dart';
import 'screens/AnimeList/AnimeListFavorite.dart';
import 'widgets/HexColor.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        '/AnimeList': (BuildContext context) => AnimesList(),
        '/AnimeListFavorite': (BuildContext context) => AnimeListFavorite()
      },

      home: HomePage(),

    );
  }
}



