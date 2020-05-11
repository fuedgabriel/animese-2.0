//Player
import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';
import 'package:video_box/video_box.dart';
import 'package:video_player/video_player.dart';
//widget
import 'widget/CardEpisode.dart';
//request
import 'dart:convert';
import 'package:animese/request/JSON/Episode/Episode.dart';
import 'package:animese/request/JSON/Episode/Player.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:animese/request/Request.dart';

//Nome
import 'package:wakelock/wakelock.dart';
import 'package:rxdart/subjects.dart';

// ignore: must_be_immutable
class PlayerVideo extends StatefulWidget {

  String nome;
  int id;
  int epi;
  String language;
  List<String> quality;
  PlayerVideo(this.id, this.nome, this.epi, this.language, this.quality);
  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {

  VideoController vc;
  int epState;

  Stream<String> get title$ => _titleSubject.stream;
  Sink<String> get titleSink => _titleSubject.sink;
  final _titleSubject = BehaviorSubject<String>.seeded('');



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
    titleSink.add(widget.nome+'   ');
    _getViews().then((ep){
      setState(() {
        if(ep == null){epState = 0;}
        else{epState = ep;}
      });
    });
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
                    child: StreamBuilder<String>(
                      stream: title$,
                      initialData: '',
                      builder: (context, snapshot) {
                        return Row(
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
                              snapshot.data,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 19,
                              ),
                            ),
                          ],
                        );
                      },
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
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                      padding: EdgeInsets.all(8), 
                      child: DropdownButton<String>(
                        icon: Icon(Icons.settings,color: Colors.white,),
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(color: Colors.transparent,),
                        onChanged: (String newValue) {
                        },
                        items: widget.quality.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: GestureDetector(
                              child: Text(value),
                              onTap: (){
                                try {
                                  _getViews().then((ep){
                                    print( value.substring(0,2));
                                    ChangeQuality(ep, value.substring(0,2));
                                  });
                                } on Exception catch (_) {

                                }
                              },
                            ),
                          );
                        }).toList(),
                      ),
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
          CardPlayer(ep: widget.epi, epState: epState,id: widget.id ,vc: vc, lanuage: widget.language, titleSink: titleSink, nome: widget.nome+'   ',)
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  PlayEpisode( int episode) async {
    titleSink.add(widget.nome + '  '+episode.toString());
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
  // ignore: non_constant_identifier_names

  ChangeQuality(int episode, quality) async {
    String mp4;
    ANIMES.Ep(widget.id, episode, widget.language).then((response){
      final episodesVal ep = episodesVal.fromJson(json.decode(response.body)['eps']['eps'][0]);
      ANIMES.PlayerUrl(ep.id, quality).then((response) async{
        final PPlay url = PPlay.fromJson(jsonDecode(response.body));
        mp4 = url.requestedMP4.url;
        print(mp4);
        vc.setSource(VideoPlayerController.network(mp4));

        vc.initialize();
        vc.play();
      });
      _saveViews(episode);
    });

  }
}