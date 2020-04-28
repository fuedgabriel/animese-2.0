//Widget
import 'dart:convert';
import 'package:animese/widgets/Drawer.dart';
import 'widget/scroll_vertical.dart';
import 'package:flutter/material.dart';

//Request
import 'package:animese/request/Request.dart';
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';




// ignore: must_be_immutable
class AnimesList extends StatefulWidget {
  String list;
  AnimesList(this.list);
  @override
  _AnimesListState createState() => _AnimesListState();
}

class _AnimesListState extends State<AnimesList> {
  int pag = 1;
  var animes = List<AnimeListJson>();
  var list = List<AnimeListJson>();
  var controller = ScrollController();


  _getListAnime(int pag){
    ANIMES.AnimeList(pag).then((response){
      setState(() {
        Map decoded = json.decode(response.body);
        Iterable lista = decoded['animes']['animes'];
        list = lista.map((model) => AnimeListJson.fromJson(model)).toList();
        animes.addAll(list.map((f) => f).toList());
      });
    });
  }
  _getListFilmes(int pag){
    ANIMES.MovieList(pag).then((response){
      setState(() {
        Map decoded = json.decode(response.body);
        Iterable lista = decoded['filmes']['filmes'];
        list = lista.map((model) => AnimeListJson.fromJson(model)).toList();
        animes.addAll(list.map((f) => f).toList());
      });
    });
  }
  _getListOvas(int pag){
    ANIMES.OvaList(pag).then((response){
      setState(() {
        Map decoded = json.decode(response.body);
        Iterable lista = decoded['ovas']['ovas'];
        list = lista.map((model) => AnimeListJson.fromJson(model)).toList();
        animes.addAll(list.map((f) => f).toList());
      });
    });
  }

  _searchAnime(name){
    ANIMES.AnimeSearch(name).then((response){
      setState(() {
        Map decoded = json.decode(response.body);
        print(decoded);
        Iterable lista = decoded['animes']['animes'];
        animes = lista.map((model) => AnimeListJson.fromJson(model)).toList();
      });
    });
  }
  _searchMovie(name){
    ANIMES.MovieSearch(name).then((response){
      setState(() {
        Map decoded = json.decode(response.body);
        Iterable lista = decoded['filmes']['filmes'];
        animes = lista.map((model) => AnimeListJson.fromJson(model)).toList();
      });
    });
  }
  _searchOva(name){
    ANIMES.OvaSearch(name).then((response){
      setState(() {
        Map decoded = json.decode(response.body);
        Iterable lista = decoded['ovas']['ovas'];
        animes = lista.map((model) => AnimeListJson.fromJson(model)).toList();
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
          if(widget.list == 'Animes'){
            _getListAnime(pag);
          }
          else if(widget.list == 'Filmes'){
            _getListFilmes(pag);
          }
          else{
            _getListOvas(pag);
          }
        }
      }
    });
    super.initState();
    if(widget.list == 'Animes'){
      _getListAnime(1);
    }
    else if(widget.list == 'Filmes'){
      _getListFilmes(1);
    }
    else{
      _getListOvas(1);
    }
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(page: widget.list,),
      appBar:  AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(40)),
        ),
        title: Center(
          child: TextFormField(
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500
            ),
            cursorColor: Colors.white,
            autofocus: true,
            decoration: InputDecoration.collapsed(
              hintText: 'Digite seu anime',
              border: InputBorder.none,
              hintStyle: TextStyle(
                color: Colors.white.withOpacity(0.5)
              )
            ),
            onChanged: (value){
              setState(() {
                if(value == ''){
                  value = 'all';
                }
                if(widget.list == 'Animes'){
                  _searchAnime(value);
                }else if(widget.list == 'Filmes'){
                  _searchMovie(value);
                }else{
                  _searchOva(value);
                }
              });
            },
          ),
        ),
        elevation: 5,
      ),
      body: ContentScroll(controller: controller,images: animes,type: widget.list,)

    );
  }
}
