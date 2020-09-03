//Request
import 'package:animese/request/JSON/AnimeListJson/AnimeLittleListJson.dart';
import 'package:animese/request/JSON/CategoryListJson/CategoryListJson.dart';
import 'package:animese/request/Request.dart';
import 'package:animese/screens/AnimeList/AnimeListNv.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
//Json
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
//Widget
import 'package:animese/widgets/Drawer.dart';

//Desing
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:animese/screens/Home/widget/Scroll_vertical.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}


List<String> id2 = ["2175", "333", "346", "1198", "272", "560", "1676", "244", "54", "2065", "113", "1902", "1897", "1432", "1126"];
final List<String> imgList = ["https://cdn-eu.anidb.net/images/main/247176.jpg", "https://cdn-eu.anidb.net/images/main/156912.jpg", "https://cdn-eu.anidb.net/images/main/36637.jpg", "https://cdn-eu.anidb.net/images/main/221330.jpg", "https://cdn-eu.anidb.net/images/main/200745.jpg", "https://cdn-eu.anidb.net/images/main/221076.jpg", "https://cdn-eu.anidb.net/images/main/231369.jpg", "https://cdn-eu.anidb.net/images/main/157430.jpg", "https://cdn-eu.anidb.net/images/main/221536.jpg", "https://cdn-eu.anidb.net/images/main/245046.jpg", "https://cdn-eu.anidb.net/images/main/76654.jpg", "https://cdn-eu.anidb.net/images/main/243721.jpg", "https://cdn-eu.anidb.net/images/main/241329.jpg", "https://cdn-eu.anidb.net/images/main/227312.jpg", "https://cdn-eu.anidb.net/images/main/176068.jpg"];

class _HomePage extends State<HomePage> {
  var lancamento = List<AnimeListJson>();
  var maisAssistidos = List<AnimeListJson>();
  var recentes = List<AnimeListJson>();
  var ultimosAtualizados = List<AnimeListJson>();
  var ultimosFilmes = List<AnimeListJson>();
  var ultimosOvas = List<AnimeListJson>();

  var list = List<LittleListAnimeJson>();
  var animes = List<LittleListAnimeJson>();
  String VERSION;

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _Atualizacao() async{
    ANIMES.Atualizacao().then((response){
      ANIMES.AtualizacaoAnimese().then((VER){
        setState(() {
          VERSION = VER.body.toString();
        });
        if(response.body.toString().contains("2.2.7")){

        }
        else if(VERSION.contains("2.2.6")){


        }
        else if(VERSION.contains("2.2.5")){


        }
        else{
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  backgroundColor: Colors.black.withOpacity(0.8),
                  content: Stack(
                    overflow: Overflow.visible,
                    children: <Widget>[
                      Positioned(
                        right: -40.0,
                        top: -40.0,
                        child: InkResponse(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: CircleAvatar(
                            child: Icon(Icons.close),
                            backgroundColor: Colors.red,
                          ),
                        ),
                      ),
                      Form(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text("Há uma nova versão disponível para download!!\n\nRecomendamos que atualize o seu APP", style: TextStyle(color: Colors.yellow),),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: RaisedButton(
                                color: Colors.green,
                                child: Text("Atualizar"),
                                onPressed: () {
                                  _launchURL("https://play.google.com/store/apps/details?id=com.animese.android");
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              });
        }
      });
    });
  }

  _Message() async{
    ANIMES.Message().then((response){
      print(response.body.toString());
      if(response.body.toString().contains("\"")){
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                content: Stack(
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Positioned(
                      right: -40.0,
                      top: -40.0,
                      child: InkResponse(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: CircleAvatar(
                          child: Icon(Icons.close),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ),
                    Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                              child: Text((response.body).toString().replaceAll("\"", ""), style: TextStyle(color: Colors.yellow),)
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      }else{

      }
    });
  }

  List<String> recent;
  _recentAnimes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    recent = prefs.getStringList('lista');
    if(recent == null){
      recent = [];
    }
  }
  _HomePage(){
    _Message();
    _Atualizacao();
    _recentAnimes();
    _getHome();
    _stateFavorite();
    _stateHistoric();
    _getCategory();
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

    if( favorite == null){

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

  var animeH = List<DescriptionJson>();
  List<String> Historic;

  Future _stateHistoric()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Historic = prefs.getStringList('Historic');

    if( Historic == null){

    }else{
      for(int i = 0;i < Historic.length; i++){
        ANIMES.Description(int.parse(Historic[i]), 'Animes').then((response){
          setState(() {
            Historic = Historic;
            animeH.add(DescriptionJson.fromJson(jsonDecode(response.body)['anime']));
          });
        });
      }
    }
  }

  // ignore: non_constant_identifier_names
  var CategoryListVar = List<CategoryListJson>();
  _getCategory() {
    ANIMES.GetCategory().then((response) {
      Map lista = json.decode(response.body);
      Iterable list = lista['categorias'];
      setState(() {
        CategoryListVar = list.map((model) => CategoryListJson.fromJson(model)).toList();
      });
    });
  }

  final List<Widget> imageSliders = imgList.map((item) => Container(
      margin: EdgeInsets.all(0.0),
      padding: EdgeInsets.all(0),
      child: GestureDetector(
        onTap: () {

        },
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(5.0),),
          child: Image.network(item, fit: BoxFit.fill, width: 1000.0),
        ),
      )
  ),).toList();

  CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: MenuWidget(page: 'Home',),
      appBar:  AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search),
            onPressed: (){
              Navigator.of(context).pushNamed('/AnimeList');
//              showSearch(context: context, delegate: DataSearch(recent.reversed.toList()), );
            },
          ),
        ],
        title: Image.asset('assets/logo/Icon.png', width: MediaQuery.of(context).size.width * 0.09),
        elevation: 5,
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Column(
            children: <Widget>[
              CarouselSlider(
                options: CarouselOptions(
                  autoPlay: true,
                  aspectRatio: 1.7,
                  enlargeCenterPage: true,
                ),
                items: imageSliders,
              ),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  SizedBox(width:  MediaQuery.of(context).size.width*0.03, height: 10,),
                  Text(
                    "Recomendados           ",
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white
                    ),
                  ),
                  SizedBox(width:  MediaQuery.of(context).size.width*0.2, ),
                  GestureDetector(
                      onTap: () {

                        Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeListNv(imgList,id2, "Recomendados","Animes"),),);
                      },
                      child: Text(
                        "Ver todos  >",
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white54,
                        ),
                      )
                  ),
                ],
              ),
          ],),
          SizedBox(height: 30,),
          ContentScrollTemp(),
          Padding(padding: EdgeInsets.only(bottom: 0)),
          ContentScroll(icon: Icons.star, color: Colors.yellow, images: maisAssistidos,      title: 'Top Animes         ', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.26, type: 'Animes',),
          ContentCategory(CategoryListVar),
          ContentScroll(icon: Icons.video_library,color: Colors.deepPurple,images: ultimosAtualizados, title: 'Atualizados        ', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.26, type: 'Animes',),
          ContentScroll(icon: Icons.access_time,color: Colors.brown, images: lancamento, title: 'Lançamentos        ', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.26, type: 'Animes',),
          ContentScroll(icon: Icons.autorenew ,color: Colors.white70,images: recentes, title: 'Recentes          ', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.26, type: 'Animes',),
          ContenScrollFavorite(anime: anime, favorite: favorite, Title: 'Favoritos          ', imageWidth: MediaQuery.of(context).size.width*0.41,imageHeight: MediaQuery.of(context).size.height*0.26,),
          ContenScrollHistoric(anime: animeH, historic: Historic, Title: 'Assistidos anteriormente', imageWidth: MediaQuery.of(context).size.width*0.41,imageHeight: MediaQuery.of(context).size.height*0.30,),
          ContentScroll(icon: Icons.movie, color: Colors.cyanAccent, images: ultimosFilmes, title: 'Últimos Filmes     ', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.26, type: 'Filmes',),
          ContentScroll(icon: Icons.ac_unit,color: Colors.green, images: ultimosOvas, title: 'Últimos Ovas       ', imageWidth: MediaQuery.of(context).size.width*0.41, imageHeight: MediaQuery.of(context).size.height*0.26, type: 'Ovas',),

        ],
      ),
    );
  }
}
//
//class DataSearch extends SearchDelegate<String>{
//  List id;
//  List recent;
//  DataSearch(this.recent);
//  List searchNome = [];
//  List searchSub = [];
//  List searchCap = [];
//
//  saverecent(sugestion) async{
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    List<String> favoritos = prefs.getStringList('lista');
//    if(favoritos == null){ favoritos = [];}
//    if(favoritos.length > 15){favoritos.removeLast();}
//    if(favoritos.contains(sugestion) == true){favoritos.remove(sugestion);}
//
//    favoritos.add(sugestion);
//    prefs.setStringList('lista', favoritos);
//  }
//
//  save(String key, dynamic value) async {
//    final prefs = await SharedPreferences.getInstance();
//    prefs.setStringList(key, value);
//  }
//
//
//
//
//  @override
//  List<Widget> buildActions(BuildContext context) {
//    // action for app bar
//    return [
//      IconButton(
//        icon: Icon(Icons.clear),
//        onPressed: (){
//          query = "";
//        },
//      )
//    ];
//  }
//
//  @override
//  Widget buildLeading(BuildContext context) {
//    // leading icon on the left of the app bar
//    return IconButton(
//      disabledColor: Colors.red,
//      icon: AnimatedIcon(
//        icon: AnimatedIcons.menu_arrow,
//        progress: transitionAnimation,
//      ),
//      onPressed: (){
//        close(context, null);
//      },
//    );
//  }
//
//  @override
//  Widget buildResults(BuildContext context) {
//    //SHow some result based on the selection
//    return null;
//  }
//
//  @override
//  Widget buildSuggestions(BuildContext context) {
//
//    // Show when someone searches for something
//    final suggestionList = query.isEmpty ?recent :searchNome.where((p) => p.toString().toUpperCase().contains(query.toUpperCase())).toList();
//    final subtitleList   = query.isEmpty ?recent :searchSub;
//    final subCapaList   = query.isEmpty ?recent :searchCap;
//
//    ANIMES.AnimeSearch(query).then((response){
//      Iterable lista = json.decode(response.body)['animes']['animes'];
//      if(lista == null){
//
//      }else{
//        List<AnimeListJson> list = lista.map((model) => AnimeListJson.fromJson(model)).toList();
//        searchNome = list.map((f) => f.nome).toList();
//        searchSub = list.map((f) => f.temporada).toList();
//        searchCap = list.map((f) => f.capa).toList();
//        id = list.map((f) => f.id).toList();
//      }
//    });
//
//
//    return ListView.builder(
//      itemBuilder: (context, index) => ListTile(
//        onTap: () async{
//          saverecent(suggestionList[index]);
//          for(int i = 0; i<searchNome.length; i++){
//            if(suggestionList[index].toString() == searchNome[i]){
//              print(suggestionList[index]);
//              print(searchNome[index]);
//              Navigator.push(
//                context,
//                MaterialPageRoute(
//                  builder: (context) => Videoscreen(id[i], ""),
//                ),
//              );
//            }
//          }
//        },
//        contentPadding: EdgeInsets.only(bottom: 3, top: 3, left: 5),
//        leading: CachedNetworkImage(
//          imageUrl: subCapaList[index],
//          imageBuilder: (context, imageProvider) => Image(image: imageProvider,),
//          placeholder: (context, url) => CircularProgressIndicator(),
//          errorWidget: (context, url, error) => Icon(Icons.error, color: Colors.red,),
//        ),
//        subtitle: Text(subtitleList[index], style: TextStyle(
//          color: Colors.white.withOpacity(0.9)
//        ),),
//        title: RichText(
//          text: TextSpan(
//            text: suggestionList[index].substring(0, query.length),
//            style: TextStyle(
//                color: Colors.white,
//                fontWeight: FontWeight.bold
//            ),
//            children: [
//              TextSpan(
//                  text: suggestionList[index].substring(query.length),
//                  style: TextStyle(color: Colors.red.withOpacity(0.8))
//              ),
//            ],
//          ),
//        ),
//      ),
//      itemCount: suggestionList.length,
//    );
//  }
//}


