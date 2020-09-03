import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Player/PlayerOff.dart';
class DownloadList extends StatefulWidget {
  @override
  _DownloadList createState() => _DownloadList();
}

class _DownloadList extends State<DownloadList> {
  List<String> list = [];
  List<String> download = [];
  List<String> nomeList = [];

  _getDownload() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    setState(() {
      list = prefs.getStringList('Download');
      String nome = list[1].toString() + ' ';
      download = prefs.getStringList(nome+"nome");
      String image = nome+"nome";
      nomeList = prefs.getStringList(image);
      print(nome);
    });
    print(download);
    print(nomeList);
  }


  _DownloadList(){
    _getDownload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              padding: EdgeInsets.only(top: 30),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 150,
                  child: Card(
                    color: Colors.white10,
                    margin: EdgeInsets.all(5),
                    child: Row(
                      children: <Widget>[
                        Image.network('https://meusanimes.com/animes/capas/assistir-the-god-of-high-school-todos-os-episodios-legendado-hd-meus-animes-online.jpg', cacheHeight: 150,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width*0.60,
                                  child: Text("  The god", style: TextStyle(color: Colors.white, fontSize: 16),),
                                ),
                                GestureDetector(
                                  child: Icon(Icons.delete,color: Colors.white38, size: 32,),
                                  onTap: (){

                                  },
                                )
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Container(
                                  width: MediaQuery.of(context).size.width*0.45,
                                  child: Text("  The God of High School  asdas  sad sa adsas", style: TextStyle(color: Colors.white, fontSize: 11),),
                                ),
                                IconButton(
                                  icon: Icon(Icons.play_circle_outline,color: Colors.red, size: 70,),
                                  iconSize: 70,
                                  color: Colors.red,
                                  highlightColor: Colors.black.withOpacity(0.5),
                                  splashColor: Colors.black.withOpacity(0.5),
                                  onPressed: (){
//                                Navigator.push(context, MaterialPageRoute(builder: (context) => PlayerOff(),),);
                                  },
                                )
                              ],
                            )

                          ],
                        )
                      ],
                    ),
                  ),
                );
              }),

        ],
      ),
    );
  }
}
