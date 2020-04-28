//Request
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
//widget
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//pages
import 'package:animese/screens/AnimePoster/Poster.dart';
import 'package:animese/screens/AnimePoster/PosterMovieOva.dart';
import 'package:animese/screens/AnimeList/AnimeListSimple.dart';


class ContentScroll extends StatelessWidget {
  final List<AnimeListJson> images;
  final String title;
  final double imageHeight;
  final double imageWidth;
  String type;

  ContentScroll({
    this.images,
    this.title,
    this.imageHeight,
    this.imageWidth,
    this.type
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeListSimple(animes, title, type),),);
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
                      if(type == 'Animes'){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Videoscreen(images[index].id),),);
                      }else if(type == 'Filmes'){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoscreenMovieOva(images[index].id,type),),);
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoscreenMovieOva(images[index].id,type),),);
                      }
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

// ignore: must_be_immutable
class ContenScrollFavorite extends StatelessWidget {
  List<DescriptionJson> anime;
  List<String> favorite;
  // ignore: non_constant_identifier_names
  final String Title;
  final double imageHeight;
  final double imageWidth;
  ContenScrollFavorite({
    this.anime,
    this.favorite,
    // ignore: non_constant_identifier_names
    this.Title,
    this.imageWidth,
    this.imageHeight
  });
  @override
  Widget build(BuildContext context) {
    if(anime.length == 0){
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
                  Title,
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
            height: imageHeight,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 30.0),
              scrollDirection: Axis.horizontal,
              itemCount: anime.length,
              itemBuilder: (BuildContext context, int index) {
                if(anime[index].capa == null){
                  return Container(
                    child:  Container(
                      width: imageWidth,
                      padding: EdgeInsets.all(5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Videoscreen(favorite[index]),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.asset('assets/imgs/loading.gif'),
                        ),
                      ),
                    ),
                  );
                }
                else{
                  return Container(
                    child:  Container(
//                    margin: EdgeInsets.symmetric(
//                      horizontal: 10.0,
//                      vertical: 20.0,
//                    ),
                      width: imageWidth,
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
                              builder: (context) => Videoscreen(anime[index].id,),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: CachedNetworkImage(
                            imageUrl: anime[index].capa,
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


//class ContenScrollFavorite extends StatefulWidget {
//  @override
//
//  ContenScrollFavorite(
//
//      );
//
//  _ContenScrollFavoriteState createState() => _ContenScrollFavoriteState();
//}
//
//class _ContenScrollFavoriteState extends State<ContenScrollFavorite> {
//
//  @override
//
//}


