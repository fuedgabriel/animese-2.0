//Request
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animese/request/Request.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
import 'dart:convert';
//widget
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:animese/widgets/HexColor.dart';
//pages
import 'package:animese/screens/AnimePoster/Poster.dart';
import 'package:animese/screens/AnimeList/AnimeListSimple.dart';
import 'package:animese/screens/AnimeList/AnimeListFavorite.dart';


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
//                  margin: EdgeInsets.symmetric(
//                    horizontal: 2.0,
//                    vertical: 5.0,
//                  ),
                  width: imageWidth,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(10.0),
//                    boxShadow: [
//                      BoxShadow(
//                        color: HexColor('#2b2a2a'),
//                        offset: Offset(0.0, 1.0),
//                        blurRadius: 3.0,
//                      ),
//                    ],
//                  ),
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
}


class ContenScrollFavorite extends StatefulWidget {
  @override
  List<DescriptionJson> anime;
  final String Title;
  final double imageHeight;
  final double imageWidth;
  ContenScrollFavorite(
      this.anime,
      this.Title,
      this.imageWidth,
      this.imageHeight
      );

  _ContenScrollFavoriteState createState() => _ContenScrollFavoriteState();
}

class _ContenScrollFavoriteState extends State<ContenScrollFavorite> {


  @override
  Widget build(BuildContext context) {
    if(widget.anime.length == 0){
      return Container();
    }
    else{
      return Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  widget.Title,
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/AnimeListFavorite');
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
            height: widget.imageHeight,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              scrollDirection: Axis.horizontal,
              itemCount: widget.anime.length,
              itemBuilder: (BuildContext context, int index) {
                if(widget.anime[index].capa == null){
                  return Container();
                }
                else{
                  return Container(
                    child:  Container(
//                    margin: EdgeInsets.symmetric(
//                      horizontal: 10.0,
//                      vertical: 20.0,
//                    ),
                      width: widget.imageWidth,
//                    decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(10.0),
//                      boxShadow: [
//                        BoxShadow(
//                          color: HexColor('#2b2a2a'),
//                          offset: Offset(0.0, 1.0),
//                          blurRadius: 3.0,
//                        ),
//                      ],
//                    ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Videoscreen(widget.anime[index].id),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: widget.anime[index].capa,
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
                }
              },
            ),
          ),
        ],
      );
    }
  }
}


