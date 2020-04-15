//widget
import 'package:flutter/material.dart';
import 'widget/circular_clipper.dart';
//Request
import 'dart:convert';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
import 'package:animese/request/Request.dart';
//Pages
import 'package:animese/screens/Player/Player.dart';

// ignore: must_be_immutable
class Videoscreen extends StatefulWidget {
  final id;
  Videoscreen(this.id);
  _VideoscreenState createState() => _VideoscreenState();
}

class _VideoscreenState extends State<Videoscreen> {

  _VideoscreenState(){
    print(widget.id);
    _getDescription(widget.id);

  }

  Color iconApp;
  Color nome = Colors.white;
  Color nomeTemp = Colors.white.withOpacity(0.6);
  Color descriptionN = Colors.white70;
  Color descriptionD = Colors.white54;
  IconData _obscureText = Icons.favorite_border;
  IconData __obscureText = Icons.favorite;

  String temporada;
  String categoria;
  DescriptionJson movie;

  _getDescription(id){
    print('iddd');
    print(id);
    ANIMES.Description(widget.id).then((response){
       movie = DescriptionJson.fromJson(jsonDecode(response.body)['anime']);
      if(movie.numTemporada.toString() == ''){
        temporada = '1º temporada';
      }
      else{
        temporada = movie.numTemporada.toString();
      }
      for(int i = 0; i< movie.cat.length; i++){
        categoria = categoria+', '+movie.cat[i].nome;
      }
      setState(() {
        temporada = temporada;
        movie = movie;
        categoria = categoria;
      });
    });
  }
  @override





  @override
  Widget build(BuildContext context) {
    print(widget.id);
    return Scaffold(
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                transform: Matrix4.translationValues(0.0, -50.0, 0.0),
                child: Hero(
                  tag: movie.capa,
                  child: ClipShadowPath(
                    clipper: CircularClipper(),
                    shadow: Shadow(blurRadius: 20.0),
                    child: Image(
                      height: 400.0,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(movie.capa),
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
                    icon: Icon(_obscureText),
                    iconSize: 30.0,
                    color: Colors.red,
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
                      List btn = [movie.btnDub, movie.btnLeg];
                      int ep = movie.epLeg;
                      if(movie.epLeg == 0){
                        movie.epDub = ep;
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayerVideo(movie.id, movie.nome, ep),
                        ),
                      );
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
                  onPressed: () =>{

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
                  movie.nome.toUpperCase(),
                  style: TextStyle(
                    color: nome,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 2.0),
                Text(
                  movie.temporada.toUpperCase(),
                  style: TextStyle(
                    color: nomeTemp,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(categoria.replaceRange(0, 2, ''),
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
                    Text(movie.producao,
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
                          movie.lancamento.substring(0,4),
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
                        Text('   '+movie.epLeg.toString(),
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
                          temporada,
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
                  movie.ds,
                  style: TextStyle(
                      color: descriptionN
                  ),
                ),
              ],
            ),
          ),
//          ContentScroll(
//            images: movie.url,
//            title: 'Screenshots',
//            imageHeight: 200.0,
//            imageWidth: 250.0,
//          ),
        ],
      ),
    );
  }
}
