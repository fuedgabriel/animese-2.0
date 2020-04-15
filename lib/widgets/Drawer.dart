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
            height: 200,
            width: double.infinity,
            child: Card(
              elevation: 0,
              margin: EdgeInsets.all(0),
              clipBehavior: Clip.antiAlias,
              color: Color.fromRGBO(38, 50, 56, 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(100), bottomRight: Radius.circular(0), topLeft: Radius.circular(10), topRight: Radius.circular(10)
                ),
              ),
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
                if (widget.page == 'AnimeList') {
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
            title: Text('Perguntas'),
            onTap: () {
              if (widget.page == 'Questions and Answers') {
                Navigator.pop(context);
              }
              else{
                if(widget.page == 'Home'){
                  Navigator.pop(context);
                  Navigator.of(context).pushNamed('/Questions');
                }
                else{
                  Navigator.pop(context);
                  Navigator.of(context).pushReplacementNamed('/Questions');
                }
              }
            },
          ),
          Divider(),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.report_problem),
              title: Text("Suporte"),
              onTap: ()  {
                if (widget.page == 'Suporte') {
                  Navigator.pop(context);
                }
                else{
                  if(widget.page == 'Inicio'){
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/Suporte');
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/Suporte');
                  }
                }
              },
            ),
          ),
          Divider(),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: ListTile(
              leading: Icon(Icons.settings),
              title: Text('Configurações'),
              onTap: ()
              {
                if (widget.page == 'Config') {
                  Navigator.pop(context);
                }
                else{
                  if(widget.page == 'Inicio'){
                    Navigator.pop(context);
                    Navigator.of(context).pushNamed('/Config');
                  }
                  else{
                    Navigator.pop(context);
                    Navigator.of(context).pushReplacementNamed('/Config');
                  }
                }
              },
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}



