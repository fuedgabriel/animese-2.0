//Request
import 'package:animese/request/JSON/AnimeListJson/AnimeLittleListJson.dart';
//widget
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//pages
import 'package:animese/screens/Player/Player.dart';
import 'package:animese/screens/Player/PlayerMovieOva.dart';

import '../PosterMovieOva.dart';


// ignore: camel_case_types
class Horizontal_scroll extends StatelessWidget {
  final List<LittleListAnimeJson> images;
  final String title;
  final String type;


  Horizontal_scroll({
    this.images,
    this.title,
    this.type

  });

  @override
  Widget build(BuildContext context) {
    if(images.length == 0){
      return Container();
    }
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 20.0,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 180,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 5,
                color: Colors.black,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      child: CachedNetworkImage(
                        imageUrl: images[index].capa,
                        alignment: Alignment.topCenter,
                        imageBuilder: (context, imageProvider) => Image(
                          image: imageProvider,
//                            height: MediaQuery.of(context).size.height * 0.28,
                          width: MediaQuery.of(context).size.width * 0.27,
                        ),
                        placeholder: (context, url) => Image(image: AssetImage('assets/imgs/loading.gif')),
                        errorWidget: (context, url, error) => Image(image: AssetImage('assets/imgs/loading.gif')),
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerVideoOvaMovie(images[index].id, images[index].nome, 1, 'LEG', 'F'),),);
                      },
                    ),
                    Container(
                      padding: EdgeInsets.all(5),
                      width: 150,
                      child: Text(images[index].nome,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}