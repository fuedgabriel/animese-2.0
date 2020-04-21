//pages
import 'package:animese/screens/AnimePoster/Poster.dart';
//widget
import 'package:flutter/material.dart';
//request
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';


// ignore: must_be_immutable
class ContentScroll extends StatelessWidget {
  final List<AnimeListJson> images;
  var controller = ScrollController();
  ContentScroll({
    this.images,
    this.controller
  });

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height+100,
      alignment: Alignment.bottomLeft,
      child: GridView.builder(
        controller: controller,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, childAspectRatio: 0.9 ),
        scrollDirection: Axis.vertical,
        itemCount: images.length,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
        itemBuilder: (BuildContext context, int index) {
          if(images[index].nome == null){
            images[index].nome = '';
          }
          return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: NetworkImage(images[index].capa)
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          color: Colors.white12

                        ),
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Videoscreen(images[index].id),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              images[index].capa,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5.0,
                        right: 5.0,
                        bottom: 5.0,
                        child: Container(
                          width: 250.0,
                          child: Text(
                            images[index].nome.toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          );
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class ContentScrollFavorite extends StatelessWidget {
  List id;
  List name;
  List capa;
  var controller = ScrollController();
  ContentScrollFavorite({
    this.id,
    this.name,
    this.capa,
    this.controller
  });

  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height+100,
      alignment: Alignment.bottomLeft,
      child: GridView.builder(
        controller: controller,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, mainAxisSpacing: 8, childAspectRatio: 0.9 ),
        scrollDirection: Axis.vertical,
        itemCount: id.length,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
        itemBuilder: (BuildContext context, int index) {
          if(name[index]== null){
            name[index] = '';
          }
          return Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height * 0.30,
                        width: MediaQuery.of(context).size.width * 0.30,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.contain,
                                image: NetworkImage(capa[index])
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(10.0)),
                            color: Colors.white12

                        ),
                        child: GestureDetector(
                          onTap: () async {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Videoscreen(id[index]),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(
                              capa[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 5.0,
                        right: 5.0,
                        bottom: 5.0,
                        child: Container(
                          width: 250.0,
                          child: Text(
                            name[index].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              )
          );
        },
      ),
    );
  }
}