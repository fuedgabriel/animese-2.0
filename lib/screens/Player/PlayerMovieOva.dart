import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_box/video.controller.dart';
import 'package:video_box/video_box.dart';
import 'package:video_player/video_player.dart';
//request
import 'package:animese/request/Request.dart';
import 'package:animese/request/JSON/Episode/Player.dart';
import 'dart:convert';
import 'package:wakelock/wakelock.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  String Progress;
  double _percentage = 0;

  ScrollController controller = ScrollController();


  @override
  void initState() {
    super.initState();
    fToast = FToast(context);
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

  FToast fToast;


  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.white,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.40,
            child: Text("Permaneça na tela para finalizar o download"),
          )
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: 4),
    );
  }


  @override
  void dispose() {
    vc.dispose();
    super.dispose();
  }

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
                          widget.nome,
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
            child: Stack(
              children: <Widget>[
                Row(
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    CircularProgressIndicator(value: _percentage, valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                    IconButton(
                        icon: Icon(Icons.file_download, color: Colors.red,size: 32,),
                        color: Colors.black26,
                        onPressed: () async{
                          _showToast();

                          String mp4;
                          Dio dio = Dio();
                          Map<Permission, PermissionStatus> statuses = await [Permission.storage,].request();
                          String dire = '/storage/emulated/0/Download/Animese/Filmes_Ovas/${widget.nome}.mp4';
                          ANIMES.MovieOvaGet(widget.id, widget.language, widget.end).then((response) async{
                            final PPlay url = PPlay.fromJson(jsonDecode(response.body));
                            mp4 = url.requestedMP4.url;
                            print(mp4);
                            try {
                              dio.download(
                                  mp4,
                                  '${dire}',
                                  onReceiveProgress: (actualbytes, totalbytes){
                                    var percentage = actualbytes / totalbytes * 100;
                                    _percentage = percentage / 100;
                                    setState(() {
                                      Progress = '${percentage.floor()} %';
                                      print(Progress);
                                    });
                                  }
                              );
                            } on Exception catch (_) {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      backgroundColor: Colors.black.withOpacity(0.8),
                                      content: Stack(
                                        overflow: Overflow.visible,
                                        children: <Widget>[
                                          Positioned(
                                            right: -40.0,
                                            top: -40.0,
                                            child: InkResponse(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: CircleAvatar(
                                                child: Icon(Icons.close),
                                                backgroundColor: Colors.red,
                                              ),
                                            ),
                                          ),
                                          Form(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                Padding(
                                                  padding: EdgeInsets.all(8.0),
                                                  child: Text(_.toString(), style: TextStyle(color: Colors.yellow),),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Text("Ocorreu um erro \n Tire um print do erro e envie por e-mail ou via mensagem no discord"),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
                            }
                          });
                        }),
                  ],
                )
              ],
            )
          )
        ],
      ),
    );
  }
}