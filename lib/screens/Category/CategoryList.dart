//Widget
import 'dart:convert';
import '../AnimeList/widget/scroll_vertical.dart';
import 'package:flutter/material.dart';
//Request
import 'package:animese/request/Request.dart';
import 'package:animese/request/JSON/AnimeListJson/AnimeLittleListJson.dart';
//Pages





// ignore: must_be_immutable
class CategoryList extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String Title;
  String id;
  CategoryList(this.id, this.Title);
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int pag = 1;
  var list = List<LittleListAnimeJson>();
  var animes = List<LittleListAnimeJson>();
  var controller = ScrollController();

  _getListCategory(id , page){
    ANIMES.GetCategoryList(id, page).then((response){
      Map lista = json.decode(response.body);
      Iterable listaa = lista['categoria']['animes'];
      setState(() {
        if(listaa == null){
          pag = pag +1;
          _getListCategory(id, pag);
        }else{
          list = listaa.map((model) => LittleListAnimeJson.fromJson(model)).toList();
          animes.addAll(list.map((f) => f).toList());
        }
      });
    });
  }


  @override
  void initState() {
    controller.addListener(() {
      if(mounted) {
        if(controller.position.pixels == controller.position.maxScrollExtent){
          pag = pag +1;
          _getListCategory(widget.id, pag);
        }
      }
    });
    super.initState();
    _getListCategory(widget.id, 1);
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:  AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(40)),
          ),
          title: Center(child: Text(widget.Title,),),
          elevation: 5,
        ),
        body: ContentScrollCategory(controller: controller,anime:animes,)
    );
  }
}
