import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


// ignore: must_be_immutable
class MenuWidget extends StatefulWidget{
  String page;

  MenuWidget({
    this.page,
  });

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}


class _MenuWidgetState extends State<MenuWidget> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(0),
            height: 150,
            width: double.infinity,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAlias,
              color: Color.fromRGBO(38, 50, 56, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(0), topLeft: Radius.circular(0), topRight: Radius.circular(0)
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(bottom: 20, left: 20),
                child: Image(
                  image: AssetImage('assets/logo/NameIcon.png'),
                ),
              )
            ),
          ),
          ListTile(
              leading: Icon(Icons.home),
              title: Text('Início'),
              onTap: () {
                if (widget.page == 'Home') {
                  Navigator.pop(context);
                }
                else{
                  Navigator.of(context).pushNamedAndRemoveUntil('/Home', (Route<dynamic> route) => false);
                }
              }
          ),
          Divider(),
          ListTile(
              leading: Icon(Icons.pageview),
              title: Text('Animes'),
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
          Divider(),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('Favoritos'),
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
          Divider(),
          ListTile(
              leading: Icon(Icons.insert_photo),
              title: Text('Categorias'),
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
          Divider(),
          ListTile(
              leading: Icon(Icons.movie),
              title: Text('Filmes'),
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
          Divider(),
          ListTile(
              leading: Icon(Icons.insert_photo),
              title: Text('Ovas'),
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
          Divider(),
        ],
      ),
    );
  }
}



