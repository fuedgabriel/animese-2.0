import 'package:flutter/material.dart';
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'widget/scroll_vertical.dart';

class AnimeListFavorite extends StatefulWidget {
  List id;
  List name;
  List capa;
  String title;
  AnimeListFavorite(this.id, this.name, this.capa, this.title);
  @override
  _AnimeListFavoriteState createState() => _AnimeListFavoriteState();
}

class _AnimeListFavoriteState extends State<AnimeListFavorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(40)),
        ),
        title: Center(child: Text(widget.title),),
        elevation: 5,
      ),
      body: ContentScrollFavorite(id: widget.id, name: widget.name, capa: widget.capa, controller: ScrollController(),),
    );
  }
}
