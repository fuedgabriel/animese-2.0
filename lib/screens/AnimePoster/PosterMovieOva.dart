//widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animese/widgets/HexColor.dart';
import 'package:url_launcher/url_launcher.dart';
import 'widget/circular_clipper.dart';
import 'package:cached_network_image/cached_network_image.dart';
//Request
import 'dart:convert';
import 'package:animese/request/JSON/AnimeListJson/JsonOvaMovie.dart';
import 'package:animese/request/Request.dart';

//Pages
import 'package:animese/screens/Player/PlayerMovieOva.dart';


// ignore: must_be_immutable
class VideoscreenMovieOva extends StatefulWidget {
  final id;
  String type;
  VideoscreenMovieOva(this.id, this.type);
  _VideoscreenMovieOvaState createState() => _VideoscreenMovieOvaState(id, type);
}

class _VideoscreenMovieOvaState extends State<VideoscreenMovieOva> {
  Color iconApp;
  Color nome = Colors.white;
  Color nomeTemp = Colors.white.withOpacity(0.6);
  Color descriptionN = Colors.white70;
  Color descriptionD = Colors.white54;


  String urlImage = 'https://i.pinimg.com/originals/42/a8/d4/42a8d4625aeb088c45eba5a84ca36325.gif';
  String releases = '.....';
  String season = 'Carregando...';
  String description = 'Carregando...';
  String name = 'Carregando...';
  ListJsonOvaMovie anime;




  _VideoscreenMovieOvaState(id, type){
    _getDescription(id, type);
  }

  _getDescription(id, type){
    ANIMES.Description(id, type).then((response){
      setState(() {
        if(type == 'Filmes'){
          anime = ListJsonOvaMovie.fromJson(jsonDecode(response.body)['filme']);
        }else{
          anime = ListJsonOvaMovie.fromJson(jsonDecode(response.body)['ova']);
          print("aaaaa");
        }
        releases = anime.lancamento;
        if(urlImage == null){
          urlImage = anime.capa;
        }
        description = anime.ds;
        name = anime.nome;

      });
    });
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
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
                    icon: Icon(Icons.favorite),
                    iconSize: 30.0,
                    color: Colors.transparent,
                    onPressed: ()
                    {
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
                      String end = '';
                      if(widget.type == 'Filmes'){
                        end = 'F';
                      }else{
                        end = 'O';
                      }
                      if(anime.btnDub == true && anime.btnLeg == true){
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
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerVideoOvaMovie(anime.id, anime.nome, 1, 'LEG', end),),);
                                        }),
                                        FlatButton(child: Text('Dublado', style: TextStyle(color: Colors.white),),onPressed: (){
                                          Navigator.pop(context);
                                          Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerVideoOvaMovie(anime.id, anime.nome, 1, 'DUB', end),),);
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
                      else if(anime.btnLeg == true){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerVideoOvaMovie(anime.id, anime.nome, 1, 'LEG', end),),);
                      }
                      else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerVideoOvaMovie(anime.id, anime.nome, 1, 'DUB', end),),);
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
                SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                  ],
                ),
                SizedBox(height: 25.0),
                Text(
                  description,
                  style: TextStyle(
                      color: descriptionN
                  ),
                ),
                SizedBox(height: 10.0),
                ListTile(
                  leading: Image.network('https://i.imgur.com/uDWENxE.jpg'),
                  title: Text('Organize seus animes', style: TextStyle(color: Colors.white),),
                  subtitle: Image.network('https://i.imgur.com/mJ5Nzxs.png'),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                  onTap: () {
                    _launchURL('https://myanimelist.net/');
                  },
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10))
        ],
      ),
    );
  }
}
