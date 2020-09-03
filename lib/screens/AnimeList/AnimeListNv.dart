import 'package:flutter/material.dart';
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'widget/scroll_vertical.dart';

// ignore: must_be_immutable
class AnimeListNv extends StatefulWidget {
  List<String> image;
  List<String> id;
  String title;
  String type;
  AnimeListNv(this.image,this.id, this.title, this.type);
  @override
  _AnimeListSimpleState createState() => _AnimeListSimpleState();
}

class _AnimeListSimpleState extends State<AnimeListNv> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title),),
        elevation: 5,
      ),
      body: ContentScrollNv(images: widget.image, id: widget.id, controller: ScrollController(), type: widget.type,),
    );
  }
}
