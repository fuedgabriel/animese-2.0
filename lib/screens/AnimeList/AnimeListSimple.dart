import 'package:flutter/material.dart';
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'widget/scroll_vertical.dart';

// ignore: must_be_immutable
class AnimeListSimple extends StatefulWidget {
  List<AnimeListJson> animes;
  String title;
  String type;
  AnimeListSimple(this.animes, this.title, this.type);
  @override
  _AnimeListSimpleState createState() => _AnimeListSimpleState();
}

class _AnimeListSimpleState extends State<AnimeListSimple> {
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
      body: ContentScroll(images: widget.animes, controller: ScrollController(), type: widget.type,),
    );
  }
}
