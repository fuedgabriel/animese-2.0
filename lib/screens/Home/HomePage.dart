//Request
import 'dart:async';

import 'package:animese/request/Request.dart';
import 'package:animese/screens/Home/widget/Scroll_vertical.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
//Json
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
//Json HomePage
//import 'package:animese/request/JSON/HomeJson/HomeJson.dart';
//import 'package:animese/request/JSON/HomeJson/HomeLancamentoJson.dart';
//Widget
import 'package:animese/widgets/Drawer.dart';
//Desing
//import 'package:swipe_button/swipe_button.dart';
import 'package:flutter/material.dart';
//pages
import 'package:animese/screens/AnimePoster/Poster.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  var lancamento = List<AnimeListJson>();
  var maisAssistidos = List<AnimeListJson>();
  var recentes = List<AnimeListJson>();
  var ultimosAtualizados = List<AnimeListJson>();
  var ultimosFilmes = List<AnimeListJson>();
  var ultimosOvas = List<AnimeListJson>();


  List<String> recent;
  _recentAnimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recent = prefs.getStringList('lista');
    if(recent == null){
      recent = [];
    }
  }
  _HomePage(){
    _recentAnimes();
    _getHome();
  }

  _getHome(){
    Duration(seconds: 3);
    ANIMES.HomePage().then((response){
      setState(() {
        Iterable listaL = json.decode(response.body)['lancamentos'];
        Iterable listaM = json.decode(response.body)['maisAssistidos'];
        Iterable listaR = json.decode(response.body)['recentes'];
        Iterable listaUA = json.decode(response.body)['ultimosAtualizados'];
        Iterable listaUF = json.decode(response.body)['ultimosFilmes'];
        Iterable listaUO = json.decode(response.body)['ultimosOvas'];
        lancamento = listaL.map((model) => AnimeListJson.fromJson(model)).toList();
        maisAssistidos = listaM.map((model) => AnimeListJson.fromJson(model)).toList();
        recentes = listaR.map((model) => AnimeListJson.fromJson(model)).toList();
        ultimosAtualizados = listaUA.map((model) => AnimeListJson.fromJson(model)).toList();
        ultimosFilmes = listaUF.map((model) => AnimeListJson.fromJson(model)).toList();
        ultimosOvas = listaUO.map((model) => AnimeListJson.fromJson(model)).toList();
      });
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(page: 'Home',),
      appBar:  AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
            onPressed: (){
              showSearch(context: context, delegate: DataSearch(recent.reversed.toList()), );
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(40)),
        ),
        title: Center(child: Image.asset('assets/logo/NameRe.png', width: MediaQuery.of(context).size.width * 0.7),),
        elevation: 5,
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(bottom: 10)),
          ContentScrollFavorite(images: maisAssistidos, title: 'Mais assistidos', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScrollFavorite(images: lancamento, title: 'Lançamentos', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScrollFavorite(images: recentes, title: 'Recentes', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScrollFavorite(images: ultimosAtualizados, title: 'Últimos atualizados', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScrollFavorite(images: ultimosFilmes, title: 'Últimos Filmes', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScrollFavorite(images: ultimosOvas, title: 'Últimos Ova\'s', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),

        ],
      ),
    );
  }
}
//ListView(
//children: <Widget>[
//Padding(padding: EdgeInsets.only(bottom: 10)),
//ContentScrollFavorite(images: maisAssistidos, title: 'Mais assistidos', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
//ContentScrollFavorite(images: lancamento, title: 'Lançamentos', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
//ContentScrollFavorite(images: recentes, title: 'Recentes', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
//ContentScrollFavorite(images: ultimosAtualizados, title: 'Últimos atualizados', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
//ContentScrollFavorite(images: ultimosFilmes, title: 'Últimos Filmes', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
//ContentScrollFavorite(images: ultimosOvas, title: 'Últimos Ova\'s', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
//
//],
//),

class DataSearch extends SearchDelegate<String>{
  List id;
  List recent;
  DataSearch(this.recent);
  List searchNome = [];

  saverecent(sugestion) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritos = prefs.getStringList('lista');
    if(favoritos == null){ favoritos = [];}
    if(favoritos.length > 15){favoritos.removeLast();}
    if(favoritos.contains(sugestion) == true){favoritos.remove(sugestion);}

    favoritos.add(sugestion);
    prefs.setStringList('lista', favoritos);
  }

  get(num) async{
    ANIMES.Description(id[num]).then((response){
      final json = jsonDecode(response.body);
      return DescriptionJson.fromJson(json);
    });
  }

  save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(key, value);
  }




  @override
  List<Widget> buildActions(BuildContext context) {
    // action for app bar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: (){
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // leading icon on the left of the app bar
    return IconButton(
      disabledColor: Colors.red,
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: (){
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    //SHow some result based on the selection
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Show when someone searches for something
    final suggestionList = query.isEmpty ?recent :searchNome.where((p) => p.toString().toUpperCase().contains(query.toUpperCase())).toList();


    ANIMES.AnimeSearch(query).then((response){
      Iterable lista = json.decode(response.body)['animes']['animes'];
      List<AnimeListJson> list = lista.map((model) => AnimeListJson.fromJson(model)).toList();
      searchNome = list.map((f) => f.nome).toList();
      id = list.map((f) => f.id).toList();

    });
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () async{
          saverecent(suggestionList[index]);
          for(int i = 0; i<searchNome.length; i++){
            if(suggestionList[index].toString() == searchNome[i]){
              ANIMES.Description(id[i]).then((response){
                final DescriptionJson movie = DescriptionJson.fromJson(jsonDecode(response.body)['anime']);
                String temporada;
                if(movie.numTemporada.toString() == ''){
                  temporada = '1º temporada';
                }
                else{
                  temporada = movie.numTemporada.toString();
                }
                String categoria = '';
                for(int i = 0; i< movie.cat.length; i++){
                  categoria = categoria+', '+movie.cat[i].nome;
                }
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(
//                    builder: (context) => Videoscreen(movie, temporada, categoria),
//                  ),
//                );
              });
            }
          }
        },

        contentPadding: EdgeInsets.only(bottom: 3, top: 3, left: 5),
        leading: Image.asset('assets/logo/Icon.png',height: 24,),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold
            ),
            children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.white.withOpacity(0.8))
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}