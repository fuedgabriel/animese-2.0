import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';
import 'package:video_box/video_box.dart';
import 'package:video_player/video_player.dart';
//request
import 'package:animese/request/Request.dart';
import 'package:animese/request/JSON/Episode/Player.dart';
import 'dart:convert';
import 'package:wakelock/wakelock.dart';
import 'package:auto_size_text/auto_size_text.dart';
// ignore: must_be_immutable
class PlayerVideoOvaMovie extends StatefulWidget {

  String nome;
  int id;
  int epi;
  String language;
  String end;
  PlayerVideoOvaMovie(this.id, this.nome, this.epi, this.language,this.end);
  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideoOvaMovie> {
  VideoController vc;
  int epState;



  ScrollController controller = ScrollController();


  @override
  void initState() {
    super.initState();
    vc = VideoController(
      source: VideoPlayerController.network('https://docs.google.com/uc?export=download&id=1gd3n1knckqiI3FU4N_4db5oh13j3C2hN'),
      looping: false,
      autoplay: true,
      circularProgressIndicatorColor: Colors.green,
      cover: Image.asset('assets/logo/NameIcon.png'),
      controllerWidgets: true,

//       initPosition: Duration(minutes: 23, seconds: 50)
    )
      ..addListener((c) {
        // print(c.value.positionText);
      })
      ..addFullScreenChangeListener((c, isFullScreen) async {})
      ..addPlayEndListener((c) {
        /*play end*/
        Wakelock.disable();
      })
      ..initialize().then((_) {
        // initialized
        Wakelock.enable();
      });
  }

  @override
  void dispose() {
    vc.dispose();
    super.dispose();
  }
//
//  void _changeSource(String src) async {
//    vc.setSource(VideoPlayerController.network(src));
//    vc.initialize();
//  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        controller: controller,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 9,
            child: VideoBox(
              controller: vc,
              children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(0),
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          iconSize: VideoBox.centerIconSize,
                          disabledColor: Colors.red,
                          icon: Icon(Icons.arrow_back),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Text(
                          widget.nome.replaceRange(24, widget.nome.length, '...'),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(left: 0, right: 40, top: 10, ),
                    child: Image(
                      height: 32,
                      width: 32,
                      image: AssetImage('assets/logo/Icon.png'),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Card(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_circle_outline, color: Colors.red,size: 36,),
                  color: Colors.red,
                  onPressed: (){
                    ANIMES.MovieOvaGet(widget.id, widget.language, widget.end).then((response) async{
                      final PPlay url = PPlay.fromJson(jsonDecode(response.body));
                      String mp4 = url.requestedMP4.url;
                      print(mp4);
                      vc.setSource(VideoPlayerController.network(mp4));
                      vc.initialize();
                      vc.play();
                    });
                    },
                ),
                FlatButton(
                  onPressed: (){
                    ANIMES.MovieOvaGet(widget.id, widget.language, widget.end).then((response) async{
                      final PPlay url = PPlay.fromJson(jsonDecode(response.body));
                      String mp4 = url.requestedMP4.url;
                      print(mp4);
                      vc.setSource(VideoPlayerController.network(mp4));
                      vc.initialize();
                      vc.play();
                    });
                    },
                  child: Text('Episódio 1'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}