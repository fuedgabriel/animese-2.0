//Request
import 'package:animese/request/JSON/AnimeListJson/AnimeListJson.dart';
import 'package:animese/request/JSON/AnimeListJson/AnimeLittleListJson.dart';
import 'package:animese/request/JSON/CategoryListJson/CategoryListJson.dart';
import 'package:animese/request/JSON/DescriptionJson/DescriptionJson.dart';
import 'package:animese/screens/AnimeList/AnimeListNv.dart';
import 'package:animese/screens/Category/CategoryList.dart';
import 'package:flutter/cupertino.dart';
//widget
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
//pages
import 'package:animese/screens/AnimePoster/Poster.dart';
import 'package:animese/screens/AnimePoster/PosterMovieOva.dart';
import 'package:animese/screens/AnimeList/AnimeListSimple.dart';
import 'package:flutter/rendering.dart';




class ContentScrollTemp extends StatelessWidget {

  List<String> id = ["2213", "2209", "2217", "1818", "2204","2208", "2219", "2214", "2218", "2212", "2206", "2203",
    "2224", "2216", "2225", "2207", "2211", "2227", "2221"
  ];
  List<String> Image = ["https://cdn-eu.anidb.net/images/main/248254.jpg", "https://cdn-eu.anidb.net/images/main/248466.jpg", "https://cdn-eu.anidb.net/images/main/248007.jpg", "https://cdn-eu.anidb.net/images/main/242518.jpg", "https://cdn-eu.anidb.net/images/main/247665.jpg",
    "https://cdn-eu.anidb.net/images/main/247925.jpg","https://cdn-eu.anidb.net/images/main/247715.jpg", "https://cdn-eu.anidb.net/images/main/247378.jpg",
    "https://cdn-eu.anidb.net/images/main/247207.jpg", "https://cdn-eu.anidb.net/images/main/245285.jpg", "https://cdn-eu.anidb.net/images/main/245193.jpg", "https://cdn-eu.anidb.net/images/main/247991.jpg",
    "https://cdn-eu.anidb.net/images/main/248781.jpg", "https://cdn-eu.anidb.net/images/main/242323.jpg", "https://cdn-eu.anidb.net/images/main/10806.jpeg",
    "https://cdn-eu.anidb.net/images/main/247259.jpg", "https://cdn-eu.anidb.net/images/main/244863.jpg", "https://cdn-eu.anidb.net/images/main/247604.jpg", "https://cdn-eu.anidb.net/images/main/248538.jpg"

  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width:  MediaQuery.of(context).size.width*0.03),
            Icon(
              Icons.calendar_today,
              size: 30.0,
              color: Colors.deepOrange,
            ),
            SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
            Text(
              "Temporada de verão",
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.blueAccent
              ),
            ),
            SizedBox(width:  MediaQuery.of(context).size.width*0.2, ),
            GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeListNv(Image,id, "Temporada de Verão","Animes"),),);

                },
                child: Text(
                  "  Ver todos  >",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white54,
                  ),
                )
            ),
          ],
        ),
        Container(
          height: 160,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            itemCount: Image.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                  padding: EdgeInsets.all(5),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Videoscreen(id[index], Image[index]),
                        ),
                      );
                    },
                    child:  CircleAvatar(
                      radius: 65,
                      backgroundColor: Color(0xffFDCF09),
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withOpacity(0.9),
                        radius: 60,
                        backgroundImage: NetworkImage(Image[index]),
                      ),
                    ),),
                  );
            },
          ),
        ),
      ],
    );
  }
}

class ContentScroll extends StatelessWidget {

  final List<AnimeListJson> images;
  final String title;
  final double imageHeight;
  final double imageWidth;
  String type;
  Color color;
  IconData icon;

  ContentScroll({
    this.images,
    this.color,
    this.title,
    this.imageHeight,
    this.imageWidth,
    this.type,
    this.icon
  });

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[
        SizedBox(height:  MediaQuery.of(context).size.height*0.02, ),
       Row(
          children: <Widget>[
            SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
            Icon(
              icon,
              size: 30.0,
              color: color,
            ),
            SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
            Text(
              title,
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueAccent
              ),
            ),
            SizedBox(width:  MediaQuery.of(context).size.width*0.2, ),
            GestureDetector(
                onTap: () {
                  var animes = List<AnimeListJson>();
                  animes.addAll(images.map((f) => f).toList());
                  print(animes);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AnimeListSimple(animes, title, type),),);

                },
                child: Text(
                  "Ver todos  >",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white54,
                  ),
                )
            ),
          ],
        ),
        Container(
          height: imageHeight,
          width: double.infinity,
          child: ListView.builder(
            padding: EdgeInsets.all(10),
            scrollDirection: Axis.horizontal,
            itemCount: images.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child:  Container(
                  width: imageWidth,
                  child: GestureDetector(
                    onTap: () {
                      if(type == 'Animes'){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => Videoscreen(images[index].id, ""),),);
                      }else if(type == 'Filmes'){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoscreenMovieOva(images[index].id,type),),);
                      }else{
                        Navigator.push(context, MaterialPageRoute(builder: (context) => VideoscreenMovieOva(images[index].id,type),),);
                      }
                    },
                    child: ClipRRect(
//                      borderRadius: BorderRadius.circular(10.0),
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
  final String Title;
  final double imageHeight;
  final double imageWidth;
  ContenScrollFavorite({
    this.anime,
    this.favorite,
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
          Row(
            children: <Widget>[
              SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
              Icon(
                Icons.favorite,
                size: 30.0,
                color: Colors.red,
              ),
              SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
              Text(
                Title,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blueAccent
                ),
              ),
              SizedBox(width:  MediaQuery.of(context).size.width*0.2, ),
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/AnimeListFavorite');
                  },
                  child: Text(
                    "Ver todos  >",
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white54,
                    ),
                  )
              ),
            ],
          ),
          Container(
            height: imageHeight,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              itemCount: anime.length,
              itemBuilder: (BuildContext context, int index) {
                if(anime[index].capa == null){
                  return Container(
                    child:  Container(
                      width: imageWidth,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Videoscreen(favorite[index], ""),
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
                              builder: (context) => Videoscreen(anime[index].id,""),
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





class ContenScrollHistoric extends StatelessWidget {
  List<DescriptionJson> anime;
  List<String> historic;
  final String Title;
  final double imageHeight;
  final double imageWidth;
  ContenScrollHistoric({
    this.anime,
    this.historic,
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
          Row(
            children: <Widget>[
              SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
              Icon(
                Icons.history,
                size: 30.0,
                color: Colors.deepOrange,
              ),
              SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
              Text(
                Title,
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.blueAccent
                ),
              ),
            ],
          ),
          Container(
            height: imageHeight,
            width: double.infinity,
            child: ListView.builder(
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              itemCount: anime.length,
              itemBuilder: (BuildContext context, int index) {
                if(anime[index].capa == null){
                  return Container(
                    child:  Container(
                      padding: EdgeInsets.all(10),
                      height: 20,
                      width: 150,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Videoscreen(historic[index], ""),
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
                    padding: EdgeInsets.only(right: 4),
                      width: imageWidth,
                      height: imageHeight,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Videoscreen(anime[index].id,""),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: anime[index].capa,
                            width: imageWidth,
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

class ContentCategory extends StatelessWidget {
  List<Color> cor = [Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent,Colors.deepOrange, Colors.deepPurple, Colors.green, Colors.orange,Colors.teal,Colors.blueAccent,Colors.redAccent,Colors.cyanAccent,Colors.pink,Colors.brown,Colors.indigoAccent,Colors.indigo,Colors.deepPurpleAccent,Colors.white10,Colors.pinkAccent,Colors.deepPurpleAccent];
  var CategoryListVar = List<CategoryListJson>();
  ContentCategory(
      this.CategoryListVar
      );

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
            Icon(
              Icons.category,
              size: 30.0,
              color: Colors.greenAccent,
            ),
            SizedBox(width:  MediaQuery.of(context).size.width*0.03, ),
            Text(
              "Categorias           ",
              style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.blueAccent
              ),
            ),
            SizedBox(width:  MediaQuery.of(context).size.width*0.2, ),
            GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/Category');
                },
                child: Text(
                  "Ver todos  >",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white54,
                  ),
                )
            ),
          ],
        ),
        Container(
          height: 200,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: CategoryListVar.length,
              padding: EdgeInsets.all(10),
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
                    margin: EdgeInsets.only(top: 10, left: 10, bottom: 20),
                    color: cor[index],
                    child: Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 60,
                      child: Text(CategoryListVar[index].nome,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),),
                    ),
                  ),
                );
              }
          ),
        )
      ],
    );
  }
}

