import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

import 'HexColor.dart';

// ignore: must_be_immutable
class MenuWidget extends StatefulWidget{
  String page;

  MenuWidget({
    this.page,
  });

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

_launchURL(url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
class _MenuWidgetState extends State<MenuWidget> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(

      child: Container(color: HexColor('#080808'),child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Colors.black,
            margin: EdgeInsets.all(0),
            height: 150,
            width: double.infinity,
            child: Image(
              image: AssetImage('assets/logo/NameIcon.png'),
            ),
          ),
          ListTile(
              leading: Icon(Icons.home, color: Colors.deepPurple,),
              title: Text('Início', style: TextStyle(
                color: Colors.white70
              ),),
              onTap: () {
                if (widget.page == 'Home') {
                  Navigator.pop(context);
                }
                else{
                  Navigator.of(context).pushNamedAndRemoveUntil('/BottonBar', (Route<dynamic> route) => false);
                }
              }
          ),
          Divider(color: Colors.white10,),
          ListTile(
              leading: Icon(Icons.pageview, color: Colors.white,),
              title: Text('Animes', style: TextStyle(color: Colors.white70),),
              onTap: ()  {
                if (widget.page == 'Animes') {
                  Navigator.pop(context);
                }
                else{
                  if(widget.page == 'Home'){
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/AnimeList');
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/AnimeList');
                  }
                }
              }
          ),
          Divider(color: Colors.white10,),
          ListTile(
            leading: Icon(Icons.favorite, color: Colors.deepOrange,),
            title: Text('Favoritos', style: TextStyle(color: Colors.white70),),
            onTap: () {
              if (widget.page == 'Favorite') {
                Navigator.pop(context);
              }
              else{
                if(widget.page == 'Home'){
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/AnimeListFavorite');
                }
                else{
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/AnimeListFavorite');
                }
              }
            },
          ),
          Divider(color: Colors.white10,),
          ListTile(
              leading: Icon(Icons.insert_photo, color: Colors.green,),
              title: Text('Categorias', style: TextStyle(color: Colors.white70),),
              onTap: ()  {
                if (widget.page == 'Category') {
                  Navigator.pop(context);
                }
                else{
                  if(widget.page == 'Home'){
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/Category');
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/Category');
                  }
                }
              }
          ),
          Divider(color: Colors.white10,),
          ListTile(
              leading: Icon(Icons.movie, color: Colors.cyan,),
              title: Text('Filmes', style: TextStyle(color: Colors.white70),),
              onTap: ()  {
                if (widget.page == 'Filmes') {
                  Navigator.pop(context);
                }
                else{
                  if(widget.page == 'Home'){
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/MovieList');
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/MovieList');
                  }
                }
              }
          ),
          Divider(color: Colors.white10,),
          ListTile(
              leading: Icon(Icons.insert_photo, color: Colors.yellow,),
              title: Text('Ovas',style: TextStyle(color: Colors.white70),),
              onTap: ()  {
                if (widget.page == 'Ovas') {
                  Navigator.pop(context);
                }
                else{
                  if(widget.page == 'Home'){
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/OvaList');
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/OvaList');
                  }
                }
              }
          ),
          Divider(color: Colors.white10,),
          Padding(padding: EdgeInsets.all(10)),
          ListTile(
              leading: Image.network('https://miro.medium.com/max/512/0*E3Nphq-iyw_gsZFH.png'),
              title: Text('Acesse o nosso Discord', style: TextStyle(color: Colors.white70),),
              onTap: ()  {
                _launchURL('https://discord.gg/G3he5Sc');
              }
          ),
        ],
      ))
    );
  }
}



