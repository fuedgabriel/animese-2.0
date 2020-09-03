import 'package:flutter/material.dart';
import '../screens/Home/HomePage.dart';
import '../screens/AnimeList/AnimeListFavorite.dart';
import '../screens/Config/Config.dart';
import '../screens/Download/DownloadList.dart';
import 'HexColor.dart';
//page

class BottonBar extends StatefulWidget {
  @override
  _BottonBar createState() => _BottonBar();
}

class _BottonBar extends State<BottonBar> {
  int _currentIndex = 0;
  PageController _c;
  @override
  void initState(){
    _c = PageController(
      initialPage: _currentIndex,
    );
    super.initState();
  }
  final tabs = [
    HomePage(),
    AnimeListFavorite(),
//    DownloadList(),
    Config()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        elevation: 10,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.red,
        backgroundColor: HexColor('#080808'),
        unselectedLabelStyle: TextStyle(
            color: Colors.grey
        ),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Início'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            title: Text('Favoritos'),
          ),
//          BottomNavigationBarItem(
//            icon: Icon(Icons.file_download),
//            title: Text('Download'),
//          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Mais'),
          ),
        ],

        onTap: (index){
          setState(() {
            this._c.jumpToPage(index);
          });
        },
      ),
      body: PageView(
        controller: _c,

        onPageChanged: (newPage){
          setState((){
            this._currentIndex=newPage;
          });
        },
        children: <Widget>[
          HomePage(),
          AnimeListFavorite(),
//          DownloadList(),
          Config()
        ],
      ),
    );
  }
}
