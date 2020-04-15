//Request
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:animese/request/Request.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
import 'dart:convert';
//widget
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

//pages
import 'package:animese/screens/AnimePoster/Poster.dart';
import 'package:animese/screens/AnimeList/AnimeListSimple.dart';


class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

class ContentScrollFavorite extends StatelessWidget {
  final List<AnimeListJson> images;
  final String title;
  final double imageHeight;
  final double imageWidth;

  ContentScrollFavorite({
    this.images,
    this.title,
    this.imageHeight,
    this.imageWidth,
  });


  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white
                ),
              ),
              GestureDetector(
                onTap: () {
                  var animes = List<AnimeListJson>();
                  animes.addAll(images.map((f) => f).toList());
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeListSimple(animes, title),),);
                },
                child: Icon(
                  Icons.arrow_forward,
                  size: 30.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: imageHeight,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child:  Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  width: imageWidth,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: HexColor('#2b2a2a'),
                        offset: Offset(0.0, 1.0),
                        blurRadius: 3.0,
                      ),
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Videoscreen(images[index].id),
                        ),
                      );
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: CachedNetworkImage(
                        imageUrl: images[index].capa,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                        errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.black87,),),
                      ),
                    ),

                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
//
//  buildContainer(index) {
//    return Container(
//        child: FutureBuilder(
//            future: _getHome(),
//            builder: (context, snapshot) {
//              if (snapshot.connectionState ==ConnectionState.) {
//                return Image.network(
//                  images[index].capa,
//                  fit: BoxFit.contain,
//                );
//              } else {
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              }
//            }));
//  }
}
class ContentScroll extends StatelessWidget {
  final List<AnimeListJson> images;
  final String title;
  final double imageHeight;
  final double imageWidth;

  ContentScroll({
    this.images,
    this.title,
    this.imageHeight,
    this.imageWidth,
  });


  @override
  Widget build(BuildContext context) {
    print(images[0].capa);
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              GestureDetector(
                onTap: () => print('View $title'),
                child: Icon(
                  Icons.arrow_forward,
                  size: 30.0,
                ),
              ),
            ],
          ),
        ),


        Container(
          height: imageHeight,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 30.0),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                width: 340,
                child:  Card(
                    elevation: 5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(
                            horizontal: 10.0,
                            vertical: 20.0,
                          ),
                          width: imageWidth,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: HexColor('#2b2a2a'),
                                offset: Offset(0.0, 4.0),
                                blurRadius: 9.0,
                              ),
                            ],
                          ),
                          child: GestureDetector(
                            onTap: () => {

                            },
                            child:
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                images[index].capa,
                                fit: BoxFit.cover,
                              ),
                            ),

                          ),
                        ),
                        Container(
                          height: 200,
                          width: 160,
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: ListView(
                            children: <Widget>[
                              Text(
                                images[index].nome,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              Opacity(
                                opacity: 0.8,
                                child:
                                Text(
                                  'Episódios: '+images[index].nome.length.toString(),
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Stack(
                                children: <Widget>[
                                  Opacity(
                                    opacity: 0.8,
                                    child: Text(
                                      images[index].nome,
                                      style: TextStyle(
                                          fontSize: 13
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        )

                      ],
                    )
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

//
//class ContentScrollFavorite extends StatelessWidget {
//  final List<ListAnime> images;
//  final String title;
//  final double imageHeight;
//  final double imageWidth;
//
//  ContentScrollFavorite({
//    this.images,
//    this.title,
//    this.imageHeight,
//    this.imageWidth,
//  });
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Column(
//      children: <Widget>[
//        Padding(
//          padding: EdgeInsets.symmetric(horizontal: 40.0),
//          child: Row(
//            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//            children: <Widget>[
//              Text(
//                title,
//                style: TextStyle(
//                  fontSize: 20.0,
//                  fontWeight: FontWeight.w600,
//                ),
//              ),
//              GestureDetector(
//                onTap: () {
//                  if(title == "Lançamentos"){
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => Screen(images, title),),);
//                  }
//                  else if(title == "Minha lista"){
//                    Navigator.of(context).pushNamed('/Favoritos');
//                  }
//                  else if(title == "Sugestões"){
//                    Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (context) => Screen(images, title),),);
//                  }
//
//
//                },
//                child: Icon(
//                  Icons.arrow_forward,
//                  size: 30.0,
//                ),
//              ),
//            ],
//          ),
//        ),
//
//
//        Container(
//          height: imageHeight,
//          width: double.infinity,
//          child: ListView.builder(
//            padding: EdgeInsets.symmetric(horizontal: 30.0),
//            scrollDirection: Axis.horizontal,
//            itemCount: images.length,
//            itemBuilder: (BuildContext context, int index) {
//              return Container(
//                child:  Container(
//                  margin: EdgeInsets.symmetric(
//                    horizontal: 10.0,
//                    vertical: 20.0,
//                  ),
//                  width: imageWidth,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10.0),
//                    boxShadow: [
//                      BoxShadow(
//                        color: HexColor('#2b2a2a'),
//                        offset: Offset(0.0, 4.0),
//                        blurRadius: 9.0,
//                      ),
//                    ],
//                  ),
//                  child: GestureDetector(
//                    onTap: () => Navigator.push(
//                      context,
//                      MaterialPageRoute(
//                        builder: (_) => Videoscreen(movie: images[index]),
//                      ),
//                    ),
//                    child:
//                    ClipRRect(
//                      borderRadius: BorderRadius.circular(10.0),
//                      child: Image.network(
//                        images[index].url,
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//
//                  ),
//                ),
//              );
//            },
//          ),
//        ),
//      ],
//    );
//  }
//}

