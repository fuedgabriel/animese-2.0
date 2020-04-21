import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';
import 'package:video_box/video_box.dart';
// import 'package:video_box/widgets/buffer_slider.dart';
import 'package:video_player/video_player.dart';
//widget
import 'widget/CardEpisode.dart';
//request
import 'dart:convert';
import 'package:animese/request/JSON/Episode/Episode.dart';
import 'package:animese/request/JSON/Episode/Player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animese/request/Request.dart';

class PlayerVideo extends StatefulWidget {
  String nome;
  int id;
  int ep;
  String language;
  PlayerVideo(this.id, this.nome, this.ep, this.language);
  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
  VideoController vc;
  int epState;

  ScrollController controller = ScrollController();
  Future _getViews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(widget.id.toString());
  }
  _saveViews(ep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(widget.id.toString(), ep);
  }

  @override
  void initState() {
    super.initState();
    _getViews().then((ep){
      setState(() {
        if(ep == null){epState = 0;}
        else{epState = ep;}
      });
    });
    vc = VideoController(
      source: VideoPlayerController.network('https://docs.google.com/uc?export=download&id=1gd3n1knckqiI3FU4N_4db5oh13j3C2hN'),
      looping: false,
      autoplay: false,
      circularProgressIndicatorColor: Colors.green,
      cover: Image.asset('assets/logo/NameIcon.png'),
      controllerWidgets: true,

//       initPosition: Duration(minutes: 23, seconds: 50)
    )
      ..addFullScreenChangeListener((c) async {})
      ..addPlayEndListener(() {
        /*play end*/
      })
      ..initialize().then((_) {

        // initialized
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
                  alignment: Alignment((MediaQuery.of(context).size.height * 0.0015)*-1, (MediaQuery.of(context).size.width * 0.0025)*-1),
                  child: IconButton(
                    iconSize: VideoBox.centerIconSize,
                    disabledColor: Colors.red,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Align(
                  alignment: Alignment((MediaQuery.of(context).size.height * 0.0004)*-1, (MediaQuery.of(context).size.width * 0.0020)*-1),
                  child: Text(
                    widget.nome,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                    ),
                  )
                ),
                Align(
                  alignment: Alignment((MediaQuery.of(context).size.height * 0.0015), (MediaQuery.of(context).size.width * 0.0025)*-1),
                    child: Image(
                      height: 32,
                      width: 32,
                      image: AssetImage('assets/logo/Icon.png'),
                    ),
                ),
                Align(
                  alignment: Alignment(0.5, 0),
                  child: IconButton(
                    iconSize: VideoBox.centerIconSize,
                    disabledColor: Colors.white60,
                    icon: Icon(Icons.skip_next),
                    onPressed: () {
                      _getViews().then((ep){
                        PlayEpisode(ep+1);
                      });
                    },
                  ),
                ),
                Align(
                  alignment: Alignment(-0.5, 0.0),
                  child: IconButton(
                    iconSize: VideoBox.centerIconSize,
                    disabledColor: Colors.white60,
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {
                      _getViews().then((ep){
                        if(ep == 0){
                          PlayEpisode(ep);
                        }else{
                          PlayEpisode(ep-1);
                        }

                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          CardPlayer(ep: widget.ep, epState: epState,id: widget.id ,vc: vc, lanuage: widget.language)

        ],
      ),
    );
  }

  PlayEpisode( int episode) async {
    String mp4;
    ANIMES.Ep(widget.id, episode, widget.language).then((response){
      final episodesVal ep = episodesVal.fromJson(json.decode(response.body)['eps']['eps'][0]);
      if(ep.linkHd == true){
        ANIMES.PlayerUrl(ep.id, 'HD').then((response) async{
          final PPlay url = PPlay.fromJson(jsonDecode(response.body));
          mp4 = url.requestedMP4.url;
          print(mp4);
          vc.setSource(VideoPlayerController.network(mp4));
          vc.initialize();
          vc.play();
        });
      }
      else if(ep.linkSd == true){
        ANIMES.PlayerUrl(ep.id, 'SD').then((response) async{
          final PPlay url = PPlay.fromJson(jsonDecode(response.body));
          mp4 = url.requestedMP4.url;
          print(mp4);
          vc.setSource(VideoPlayerController.network(mp4));
          vc.initialize();
          vc.play();
        });
      }
      else if(ep.linkBg == true){
        ANIMES.PlayerUrl(ep.id, 'BG').then((response) async{
          final PPlay url = PPlay.fromJson(jsonDecode(response.body));
          mp4 = url.requestedMP4.url;
          print(mp4);
          vc.setSource(VideoPlayerController.network(mp4));
          vc.initialize();
          vc.play();
        });
      }
      print('episódio');
      print(episode);
      _saveViews(episode);
    });

  }
}