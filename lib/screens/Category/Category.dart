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
  // ignore: non_constant_identifier_names
  var CategoryListVar = List<CategoryListJson>();
  var controller = ScrollController();

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
  List<Color> cor = [Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.black54,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        drawer: MenuWidget(
          page: 'Category',
        ),
        appBar: AppBar(
          title: Center(
            child: Text('Categorias         '),
          ),
          elevation: 5,
        ),
        body: GridView.builder(
          controller: controller,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, childAspectRatio: 0.9 ),
          scrollDirection: Axis.vertical,
          itemCount: CategoryListVar.length,
          padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryList(CategoryListVar[index].id.toString(), CategoryListVar[index].nome),
                  ),
                );
              },
              child: Card(
                color: cor[index],
                child: Container(
                  alignment: Alignment.center,
                  width: 200,
                  child: Text(CategoryListVar[index].nome,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                    ),),
                ),
              ),
            );
          },
        ),
    );
  }
}
