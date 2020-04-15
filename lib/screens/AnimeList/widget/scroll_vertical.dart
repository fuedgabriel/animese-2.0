//pages
import 'package:animese/screens/AnimePoster/Poster.dart';
//widget
import 'package:flutter/material.dart';
//request
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:animese/request/Request.dart';
import 'dart:convert';

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
                        width: MediaQuery.of(context).size.width * 0.3,
                        height: MediaQuery.of(context).size.height * 0.2,
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
                            ANIMES.Description(images[index].id).then((response){
                              final DescriptionJson movie = DescriptionJson.fromJson(jsonDecode(response.body)['anime']);
                              String temporada;
                              if(movie.numTemporada.toString() == ''){
                                temporada = '1º temporada';
                              }
                              else{
                                temporada = movie.numTemporada.toString();
                              }
                              String categoria = '';
                              for(int i = 0; i< movie.cat.length; i++){
                                categoria = categoria+', '+movie.cat[i].nome;
                              }
//                              Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                  builder: (context) => Videoscreen(movie, temporada, categoria),
//                                ),
//                              );
                            });
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
//                    Container(margin: EdgeInsets.symmetric(horizontal: 3.0, vertical: 3.0)),
                ],
              )
          );
        },
      ),
    );

  }
}