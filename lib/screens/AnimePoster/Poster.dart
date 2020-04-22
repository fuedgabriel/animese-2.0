//widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animese/widgets/HexColor.dart';
import 'widget/horizontal_scroll.dart';
import 'widget/circular_clipper.dart';
import 'package:cached_network_image/cached_network_image.dart';
//Request
import 'package:animese/request/JSON/AnimeListJson/AnimeLittleListJson.dart';
import 'dart:convert';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
import 'package:animese/request/Request.dart';
import 'package:shared_preferences/shared_preferences.dart';
//Pages
import 'package:animese/screens/Player/Player.dart';


// ignore: must_be_immutable
class Videoscreen extends StatefulWidget {
  final id;
  Videoscreen(this.id);
  _VideoscreenState createState() => _VideoscreenState(id);
}

class _VideoscreenState extends State<Videoscreen> {
  Color iconApp;
  Color nome = Colors.white;
  Color nomeTemp = Colors.white.withOpacity(0.6);
  Color descriptionN = Colors.white70;
  Color descriptionD = Colors.white54;


  String urlImage = '';
  String releases = '.....';
  String season = 'Carregando...';
  String category = '.....';
  String description = 'Carregando...';
  String temp = '...';
  String status = '...';
  String name = 'Carregando...';
  String nameTemp = 'Carregando...';
  String espisodes = '...';
  DescriptionJson anime;
  var ova = List<LittleListAnimeJson>();
  var movie = List<LittleListAnimeJson>();

  IconData favoriteIcon = Icons.favorite_border;

  _saveFavorite() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritos = prefs.getStringList('favorite');
    if(favoritos == null){ favoritos = [];}
    favoritos.add(widget.id.toString());
    prefs.setStringList('favorite', favoritos);
  }

  _removeFavorite() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favoritos = prefs.getStringList('favorite');
    favoritos.remove(widget.id.toString());
    prefs.setStringList('favorite', favoritos);
  }

  _stateFavorite()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favorite = prefs.getStringList('favorite');
    if(favorite == null){
      favorite = [];
    }
    else if(favorite.contains(widget.id.toString())== true) {
      setState(() {
        favoriteIcon = Icons.favorite;
      });
    }
  }


  void _favorite() {
    setState(() {
      if(favoriteIcon == Icons.favorite_border){
        favoriteIcon = Icons.favorite;
        _saveFavorite();
      }
      else{
        favoriteIcon = Icons.favorite_border;
        _removeFavorite();
      }
    });
  }


  _VideoscreenState(id){
    _getDescription(id);
    _stateFavorite();
  }
  _getDescription(id){
    ANIMES.Description(id).then((response){
      setState(() {
        anime = DescriptionJson.fromJson(jsonDecode(response.body)['anime']);
        movie = anime.filmes.map((model) => LittleListAnimeJson.fromJson(model.toJson())).toList();
        ova = anime.ovas.map((model) => LittleListAnimeJson.fromJson(model.toJson())).toList();
        if(anime.numTemporada.toString() == ''){
          temp = '1º temporada';
        }
        else{
          temp = anime.numTemporada.toString();
        }
        category = '';
        for(int i = 0; i< anime.cat.length; i++){
          category = category +', '+anime.cat[i].nome;
        }
        season = anime.temporada;
        espisodes = anime.epLeg.toString();
        releases = anime.lancamento;
        urlImage = anime.capa;
        description = anime.ds;
        name = anime.nome;
        nameTemp = anime.temporada;
        status = anime.producao;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: 'Animese',
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: CachedNetworkImage(
                      imageUrl: urlImage,
                      imageBuilder: (context, imageProvider) => Container(
                        height: 400,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Image(image: AssetImage('assets/imgs/loading.gif')),
                      errorWidget: (context, url, error) => Image(image: AssetImage('assets/imgs/loading.gif')),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    padding: EdgeInsets.only(left: 30.0),
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.arrow_back),
                    iconSize: 30.0,
                    color: Colors.red,
                  ),
                  Image(
                    image: AssetImage('assets/logo/NameRe.png'),
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: MediaQuery.of(context).size.width * 0.7,
                  ),
                  IconButton(
                    icon: Icon(favoriteIcon),
                    iconSize: 30.0,
                    color: Colors.red,
                    onPressed: ()
                    {
                      _favorite();
                    },

                  ),
                ],
              ),
              Positioned.fill(
                bottom: 10.0,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: RawMaterialButton(
                    padding: EdgeInsets.all(10.0),
                    elevation: 12.0,
                    onPressed: ()
                    {
                      int ep;
                      if(anime.btnDub == true){
                        showGeneralDialog(
                            barrierColor: Colors.black.withOpacity(0.5),
                            transitionBuilder: (context, a1, a2, widget) {
                              return Transform.scale(
                                scale: a1.value,
                                child: Opacity(
                                  opacity: a1.value,
                                  child: AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(20)),
                                    ),
                                    backgroundColor: HexColor('#212121'),
                                    title: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        FlatButton(child: Text('Legendado', style: TextStyle(color: Colors.white),), onPressed: (){
                                          ep = anime.epLeg;
                                          print(ep);
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PlayerVideo(anime.id, anime.nome, ep, 'LEG'),
                                            ),
                                          );
                                        }),
                                        FlatButton(child: Text('Dublado', style: TextStyle(color: Colors.white),),onPressed: (){
                                          ep = anime.epDub;
                                          print(ep);
                                          Navigator.pop(context);
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PlayerVideo(anime.id, anime.nome, ep, 'DUB'),
                                            ),
                                          );
                                        }),
                                      ],
                                    ),
                                    ),
                                  ),
                              );
                            },
                            transitionDuration: Duration(milliseconds: 200),
                            barrierDismissible: true,
                            barrierLabel: '',
                            context: context,
                            pageBuilder: (context, animation1, animation2) {var a; return a; });
                      }
                      else{
                        if(anime.epDub != 0){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerVideo(anime.id, anime.nome, anime.epDub, 'LEG'),
                            ),
                          );
                        }
                        else if(anime.epLeg != 0){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlayerVideo(anime.id, anime.nome, anime.epLeg, 'DUB'),
                            ),
                          );
                        }
                        else{
                          showGeneralDialog(
                              barrierColor: Colors.black.withOpacity(0.5),
                              transitionBuilder: (context, a1, a2, widget) {
                                return Transform.scale(
                                  scale: a1.value,
                                  child: Opacity(
                                    opacity: a1.value,
                                    child: AlertDialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(20)),
                                      ),
                                      backgroundColor: HexColor('#212121'),
                                      title: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text('Nenhum episódio disponível')
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              transitionDuration: Duration(milliseconds: 200),
                              barrierDismissible: true,
                              barrierLabel: '',
                              context: context,
                              pageBuilder: (context, animation1, animation2) {var a; return a; });
                        }
                      }
                    },
                    shape: CircleBorder(),
                    fillColor: Colors.black,
                    child: Icon(
                      Icons.play_arrow,
                      size: 60.0,
                      color: Colors.redAccent,
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 0.0,
                left: 20.0,
                child: IconButton(
                  onPressed: () {
                    _stateFavorite();
                  },
                  icon: Icon(Icons.assistant_photo),
                  iconSize: 35.0,
//                  color: Colors.white,
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 25.0,
                child: IconButton(
                  onPressed: () {
                    showGeneralDialog(
                        barrierColor: Colors.black.withOpacity(0.5),
                        transitionBuilder: (context, a1, a2, widget) {
                          return Transform.scale(
                            scale: a1.value,
                            child: Opacity(
                              opacity: a1.value,
                              child: AlertDialog(
                                shape: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                                title: Text('Está função estará diponível em breve.',
                                  style: TextStyle(
                                    fontSize: 15.6,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        transitionDuration: Duration(milliseconds: 500),
                        barrierDismissible: true,
                        barrierLabel: '',
                        context: context,
                        pageBuilder: (context, animation1, animation2) {var a; return a; });
                    Future.delayed(const Duration(milliseconds: 1200), () {
                      Navigator.of(context).pop();
                    });
                  },
                  icon: Icon(Icons.share),
                  iconSize: 35.0,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  name,
                  style: TextStyle(
                    color: nome,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.0),
                Text(
                  season.toUpperCase(),
                  style: TextStyle(
                    color: nomeTemp,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(category.replaceRange(0, 2, ''),
                  style: TextStyle(
                    color: descriptionN,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('Status: ',
                      style: TextStyle(fontSize: 16, fontWeight:FontWeight.w500, color: descriptionN,),),
                    Text(status,
                      style: TextStyle(fontSize: 16, fontWeight:FontWeight.w700, color: descriptionD, ),),
                  ],
                ),
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'Ano',
                          style: TextStyle(
                            color: descriptionN,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          releases.substring(0,4),
                          style: TextStyle(
                            color: descriptionD,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          '      Episódios',
                          style: TextStyle(
                            color: descriptionN,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(espisodes, //anime.epLeg.toString()
                          style: TextStyle(
                            color: descriptionD,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'Temporada',
                          style: TextStyle(
                            color: descriptionN,
                            fontSize: 16.0,
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          temp,
                          style: TextStyle(
                            color: descriptionD,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 25.0),
                Text(
                  description,
                  style: TextStyle(
                      color: descriptionN
                  ),
                ),
              ],
            ),
          ),
          Horizontal_scroll(images: movie,title: 'Filmes :',),
          Horizontal_scroll(images: ova,title: 'Ova\'s :',),
          Padding(padding: EdgeInsets.all(10))


        ],
      ),
    );
  }
}
