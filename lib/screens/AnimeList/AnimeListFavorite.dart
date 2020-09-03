import 'package:flutter/material.dart';
import 'widget/scroll_vertical.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
import 'package:animese/request/Request.dart';
import 'dart:convert';
import 'package:animese/widgets/Drawer.dart';
class AnimeListFavorite extends StatefulWidget {

  @override
  _AnimeListFavoriteState createState() => _AnimeListFavoriteState();
}

class _AnimeListFavoriteState extends State<AnimeListFavorite> {

  _AnimeListFavoriteState(){
    _stateFavorite();
  }
  List<String> favorite;
  var anime = List<DescriptionJson>();
  Future _stateFavorite()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favorite = prefs.getStringList('favorite');
    if(favorite == null ){

    }else{
      for(int i = 0;i < favorite.length; i++){
        ANIMES.Description(int.parse(favorite[i]), 'Animes').then((response){
          setState(() {
            favorite = favorite;
            anime.add(DescriptionJson.fromJson(jsonDecode(response.body)['anime']));
          });
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(page: 'Favorite',),
      appBar: AppBar(
        title: Center(child: Text('Favoritos'),),
        elevation: 5,
      ),
      body: ContentScrollFavorite(anime: anime, favorite: favorite, controller: ScrollController(),),
    );
  }
}
