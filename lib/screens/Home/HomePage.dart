//Request
import 'package:animese/request/Request.dart';
import 'package:animese/screens/Home/widget/Scroll_vertical.dart';
import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
//Json
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
//Json HomePage

//Widget
import 'package:cached_network_image/cached_network_image.dart';
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
    _stateFavorite();
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

  var anime = List<DescriptionJson>();
  List<String> favorite;
  Future _stateFavorite()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    favorite = prefs.getStringList('favorite');
    for(int i = 0;i < favorite.length; i++){
      ANIMES.Description(int.parse(favorite[i])).then((response){
        setState(() {
          favorite = favorite;
          anime.add(DescriptionJson.fromJson(jsonDecode(response.body)['anime']));
        });
      });
    }
  }

//  buildContainer() {
//    return Container(
//        child: FutureBuilder(
//            future: _stateFavorite(),
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                return ContenScrollFavorite(anime,'Favoritos', MediaQuery.of(context).size.width*0.41, MediaQuery.of(context).size.height*0.36,);
//              } else {
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              }
//            }));
//  }
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
          ContentScroll(images: maisAssistidos, title: 'Mais assistidos', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScroll(images: lancamento, title: 'Lançamentos', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScroll(images: recentes, title: 'Recentes', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContenScrollFavorite(anime: anime, favorite: favorite, Title: 'Favoritos', imageWidth: MediaQuery.of(context).size.width*0.41,imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScroll(images: ultimosAtualizados, title: 'Últimos atualizados', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScroll(images: ultimosFilmes, title: 'Últimos Filmes', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),
          ContentScroll(images: ultimosOvas, title: 'Últimos Ova\'s', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.36,),

        ],
      ),
    );
  }
}

class DataSearch extends SearchDelegate<String>{
  List id;
  List recent;
  DataSearch(this.recent);
  List searchNome = [];
  List searchSub = [];
  List searchCap = [];

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
    final subtitleList   = query.isEmpty ?recent :searchSub;
    final subCapaList   = query.isEmpty ?recent :searchCap;

    ANIMES.AnimeSearch(query).then((response){
      Iterable lista = json.decode(response.body)['animes']['animes'];
      List<AnimeListJson> list = lista.map((model) => AnimeListJson.fromJson(model)).toList();
      searchNome = list.map((f) => f.nome).toList();
      searchSub = list.map((f) => f.temporada).toList();
      searchCap = list.map((f) => f.capa).toList();
      id = list.map((f) => f.id).toList();

    });
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () async{
          saverecent(suggestionList[index]);
          for(int i = 0; i<searchNome.length; i++){
            if(suggestionList[index].toString() == searchNome[i]){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Videoscreen(id[i]),
                ),
              );
            }
          }
        },

        contentPadding: EdgeInsets.only(bottom: 3, top: 3, left: 5),

        leading: CachedNetworkImage(
          imageUrl: subCapaList[index],
          imageBuilder: (context, imageProvider) => Image(image: imageProvider,),
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
        ),
        subtitle: Text(subtitleList[index], style: TextStyle(
          color: Colors.white.withOpacity(0.9)
        ),),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold
            ),
            children: [
              TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: TextStyle(color: Colors.white10.withOpacity(0.8))
              ),
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}