//pages
import 'package:animese/request/JSON/AnimeListJson/AnimeLittleListJson.dart';
import 'package:animese/screens/AnimePoster/Poster.dart';
//widget
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//request
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';

// ignore: must_be_immutable
class ContentScroll extends StatelessWidget {
  var images = List<AnimeListJson>();
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
  List<DescriptionJson> anime;
  List<String> favorite;
  var controller = ScrollController();
  ContentScrollFavorite({
    this.anime,
    this.favorite,
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
        itemCount: anime.length,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
        itemBuilder: (BuildContext context, int index) {
          if(anime[index].capa== null){
            return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: GestureDetector(
                            onTap: () async {
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
                      ],
                    ),
                  ],
                )
            );
          }else{
            return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Videoscreen(anime[index].id),
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
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.black87,),),
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
                              anime[index].nome.toUpperCase(),
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
          }
        },
      ),
    );
  }
}



// ignore: must_be_immutable
class ContentScrollCategory extends StatelessWidget {
  List<LittleListAnimeJson> anime;
  var controller = ScrollController();
  ContentScrollCategory({
    this.anime,
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
        itemCount: anime.length,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10,bottom: 10),
        itemBuilder: (BuildContext context, int index) {
          if(anime[index].capa== null){
            return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Videoscreen(anime[index]),
                                ),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.asset('assets/imgs/loading.gif'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                )
            );
          }else{
            return Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          height: MediaQuery.of(context).size.height * 0.30,
                          width: MediaQuery.of(context).size.width * 0.30,
                          child: GestureDetector(
                            onTap: () async {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Videoscreen(anime[index].id),
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
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => Center(child: CircularProgressIndicator(),),
                                errorWidget: (context, url, error) => Center(child: Icon(Icons.error, color: Colors.black87,),),
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
                              anime[index].nome.toUpperCase(),
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
          }
        },
      ),
    );
  }
}