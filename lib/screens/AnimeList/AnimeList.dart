//Widget
import 'dart:convert';
import 'package:animese/widgets/Drawer.dart';
import 'widget/scroll_vertical.dart';
import 'package:flutter/material.dart';
//Request
import 'package:animese/request/Request.dart';
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
//Pages





class AnimesList extends StatefulWidget {
  @override
  _AnimesListState createState() => _AnimesListState();
}

class _AnimesListState extends State<AnimesList> {
  int pag = 1;
  var animes = List<AnimeListJson>();
  var list = List<AnimeListJson>();
  var controller = ScrollController();


  _get(int pag){
    ANIMES.AnimeList(pag).then((response){
      setState(() {
        Map decoded = json.decode(response.body);
        Iterable lista = decoded['animes']['animes'];
        list = lista.map((model) => AnimeListJson.fromJson(model)).toList();
        animes.addAll(list.map((f) => f).toList());

      });
    });
  }


  
  @override
  // ignore: must_call_super
  @override
  void initState() {
    controller.addListener(() {
      if(mounted) {
        if(controller.position.pixels == controller.position.maxScrollExtent){
          pag = pag +1;
          _get(pag);
        }
      }
    });
    super.initState();
    _get(1);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
//
//  buildContainer() {
//    return Container(
//        child: FutureBuilder(
//            future: ANIMES.AnimeList(pag).then((response){
//              Map decoded = json.decode(response.body);
//              Iterable lista = decoded['animes']['animes'];
//              list = lista.map((model) => AnimeListJson.fromJson(model)).toList();
//              animes.addAll(list.map((f) => f).toList());
//              return '';
//            }),
//            builder: (context, snapshot) {
//              if (snapshot.hasData) {
//                return ContentScroll(images: animes, controller: controller,);
//              } else {
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              }
//            }));
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(page: 'AnimeList',),
      appBar:  AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(40)),
        ),
        title: Center(child: Text('Lista de animes          '),),
        elevation: 5,
      ),
      body: ContentScroll(controller: controller,images: animes,)

    );
  }
}
