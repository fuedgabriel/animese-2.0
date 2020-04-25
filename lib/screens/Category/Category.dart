//widget
import 'package:flutter/material.dart';
import 'package:animese/widgets/Drawer.dart';
//request
import 'package:animese/request/Request.dart';
import 'dart:convert';
import 'package:animese/request/JSON/CategoryListJson/CategoryListJson.dart';
//pages
import 'CategoryList.dart';

class Category extends StatefulWidget {
  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  var CategoryListVar = List<CategoryListJson>();

  _CategoryState(){
    _getCategory();
  }

  _getCategory() {
    ANIMES.GetCategory().then((response) {
      Map lista = json.decode(response.body);
      Iterable list = lista['categorias'];
      setState(() {
        CategoryListVar = list.map((model) => CategoryListJson.fromJson(model)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MenuWidget(
          page: 'Category',
        ),
        appBar: AppBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
                top: Radius.circular(0), bottom: Radius.circular(40)),
          ),
          title: Center(
            child: Text('Categorias         '),
          ),
          elevation: 5,
        ),
        body: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: CategoryListVar.length,
            padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 50,
                width: 0,
                child: GestureDetector(
                  child: Card(
                    color: Colors.grey[400],
                    child: Center(
                      child: GestureDetector(
                        child: Text(
                          CategoryListVar[index].nome,
                          style: TextStyle(
                            fontWeight: FontWeight.w600
                          ),
                        ),
                        onTap: (){
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CategoryList(CategoryListVar[index].id.toString(), CategoryListVar[index].nome),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                )
              );
            }));
  }
}
