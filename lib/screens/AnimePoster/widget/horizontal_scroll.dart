//Request
import 'package:animese/request/JSON/AnimeListJson/AnimeLittleListJson.dart';
//widget
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//pages
import 'package:animese/screens/Player/Player.dart';


// ignore: camel_case_types
class Horizontal_scroll extends StatelessWidget {
  final List<LittleListAnimeJson> images;
  final String title;


  Horizontal_scroll({
    this.images,
    this.title
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
          height: MediaQuery.of(context).size.height * 0.38,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                padding: EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.34,
                height: MediaQuery.of(context).size.height * 0.35,
                child: Card(
                  elevation: 5,
                  color: Colors.white.withOpacity(0.4),
                  child: ListView(
                    padding: EdgeInsets.all(0),
                    children: <Widget>[
                      GestureDetector(
                        child: CachedNetworkImage(
                          imageUrl: images[index].capa,
                          alignment: Alignment.topCenter,
                          imageBuilder: (context, imageProvider) => Image(
                            image: imageProvider,
                            height: MediaQuery.of(context).size.height * 0.28,
                            width: MediaQuery.of(context).size.width * 0.27,
                          ),
                          placeholder: (context, url) => Image(image: AssetImage('assets/imgs/loading.gif')),
                          errorWidget: (context, url, error) => Image(image: AssetImage('assets/imgs/loading.gif')),
                        ),
                        onTap: (){
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                              builder: (context) => PlayerVideo(images[index].id, images[index].nome, 1, 'LEG', ['HD']),
                          ),);
                        },
                      ),
                      Text(images[index].nome,
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.8),
                          fontWeight: FontWeight.bold
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}