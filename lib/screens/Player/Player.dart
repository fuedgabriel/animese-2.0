//Player
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:video_box/video.controller.dart';
import 'package:video_box/video_box.dart';
import 'package:video_player/video_player.dart';
import 'package:permission_handler/permission_handler.dart';

//widget
//import 'widget/CardEpisode.dart';
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
  String img;
  List<String> quality;
  PlayerVideo(this.id, this.nome, this.epi, this.language, this.quality, this.img);
  @override
  _PlayerVideoState createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {

  VideoController vc;
  int epState;

  Stream<String> get title$ => _titleSubject.stream;
  Sink<String> get titleSink => _titleSubject.sink;
  final _titleSubject = BehaviorSubject<String>.seeded('');


  String quality = "HD";

  _getQuality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    quality = prefs.getString('Quality');
    if(quality == null){
      quality = "HD";
    }else{
      setState(() {
        quality = prefs.getString('Quality');
      });
    }
  }


  ScrollController controller = ScrollController();
  Future _getViews() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt(widget.id.toString());
  }

  _saveViews(ep) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(widget.id.toString(), ep);
  }

  _saveHistoric() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // ignore: non_constant_identifier_names
    List<String> Historic = prefs.getStringList('Historic');
    if(Historic == null){ Historic = [];}
    Historic.remove(widget.id.toString());
    Historic.add(widget.id.toString());
    prefs.setStringList('Historic', Historic);
  }

//  _saveDownload(dir) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    // ignore: non_constant_identifier_names
//    List<String> Download = prefs.getStringList('Download');
//    if(Download == null){ Download = [];}
//    Download.remove(widget.id.toString());
//    Download.add(widget.id.toString());
//    prefs.setStringList('Download', Download);
//    _saveDownloadList(widget.id, dir.toString());
//  }

//  _saveDownloadList(id, dir) async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    String nome = id.toString() + 'id';
//    List<String> DownloadList = prefs.getStringList(nome);
//    if(DownloadList == null){ DownloadList = [];}
//    DownloadList.remove(dir);
//    DownloadList.add(dir);
//    prefs.setStringList(nome, DownloadList);
//
//    String image = nome+"nome";
//    List<String> DownloadNome = prefs.getStringList(image);
//    if(DownloadNome == null){ DownloadNome = [];}
//    DownloadNome.remove(widget.nome);
//    DownloadNome.remove(widget.img);
//    DownloadNome.add(widget.nome.toString());
//    DownloadNome.add(widget.img.toString());
//
//
//    prefs.setStringList(image, DownloadNome);
//    _getDownload(image);
//  }

//  _getDownload(image) async{
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    // ignore: non_constant_identifier_names
//    List<String> Download = prefs.getStringList('Download');
//    String nome = Download[1].toString() + ' ';
//    List<String> Lista = prefs.getStringList(nome);
//    List<String> Matros = prefs.getStringList(image);
//    print(Lista);
//    print(Matros);
//  }

  @override
  void initState() {
    super.initState();
    fToast = FToast(context);
    titleSink.add(widget.nome+'   ');
    _getViews().then((ep){
      setState(() {
        if(ep == null){epState = 0;}
        else{epState = ep;}
      });
    });
    vc = VideoController(
//      source: VideoPlayerController.network(""),
      source: VideoPlayerController.network('https://docs.google.com/uc?export=download&id=1gd3n1knckqiI3FU4N_4db5oh13j3C2hN'),
      looping: false,
      autoplay: false,
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
//        Wakelock.disable();
      })
      ..initialize().then((_) {
        Wakelock.enable();
        _getQuality();
        _getViews().then((ep){
          if(ep == null){
            PlayEpisode(1);
          }else{
            PlayEpisode(ep+1);
          }

        });
        _saveHistoric();
        // initialized

      });
  }

  @override
  void dispose() {
    vc.dispose();
    super.dispose();
  }

  Color cardColor;
  IconData visibility;
  IconData IconDownload = Icons.file_download;
  String Progress;
  List<double> _percentage = [];



  FToast fToast;


  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.black,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.check, color: Colors.green,),
          SizedBox(
            width: 12.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width*0.40,
            child: Text("Permaneça na tela para finalizar o download", style: TextStyle(color: Colors.yellowAccent),),
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
                                Wakelock.disable();
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
                                Wakelock.enable();
                                try {
                                  _getViews().then((ep){
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
                      Wakelock.enable();
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
                      Wakelock.enable();
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
        Container(
          height: MediaQuery.of(context).size.height+100,
          alignment: Alignment.bottomLeft,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: widget.epi,
            padding: EdgeInsets.only(bottom: 330),
            itemBuilder: (BuildContext context, int index) {
              if(epState != null){
                if(index < epState){
                  cardColor = Colors.white.withOpacity(0.6);
                  visibility = Icons.visibility_off;
                }
                else{
                  cardColor = Colors.white;
                  visibility = Icons.visibility;
                }
              }
              _percentage.add(0);
              return Card(
                color: cardColor,
                child: Stack(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        IconButton(
                          icon: Icon(Icons.play_circle_outline, color: Colors.red,size: 36,),
                          color: Colors.red,
                          onPressed: (){_PlayVideo(false, (index+1));},
                        ),
                        FlatButton(
                          onPressed: (){_PlayVideo(false, (index+1));},
                          child: Text('Episódio '+(index+1).toString()),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        CircularProgressIndicator(value: _percentage[index], valueColor: AlwaysStoppedAnimation<Color>(Colors.red),),
                        IconButton(
                          icon: Icon(Icons.file_download, color: Colors.red,size: 32,),
                          color: Colors.black26,
                          onPressed: () async{
                            Wakelock.enable();
                            _getQuality();
                            _showToast();
                            String mp4;
                            int episode = (index + 1);
//                            var dir = await getExternalStorageDirectory();
                            Dio dio = Dio();
                            Map<Permission, PermissionStatus> statuses = await [Permission.storage,].request();
                            ANIMES.Ep(widget.id, episode, widget.language).then((response){
                              final episodesVal ep = episodesVal.fromJson(json.decode(response.body)['eps']['eps'][0]);
                              if(ep.linkHd == true && quality == 'HD'){
                                ANIMES.PlayerUrl(ep.id, 'HD').then((response) async{
                                  final PPlay url = PPlay.fromJson(jsonDecode(response.body));
                                  mp4 = url.requestedMP4.url;
                                  String name = (widget.nome);
                                  String numero = (index+1).toString();
                                  String dire = '/storage/emulated/0/Download/Animese/${name}/${'HD'+"_"+numero}.mp4';
                                  try {
                                    dio.download(
                                        mp4,
                                        '${dire}',
                                        onReceiveProgress: (actualbytes, totalbytes){
                                          var percentage = actualbytes / totalbytes * 100;
                                          _percentage[index] = percentage / 100;
                                          setState(() {
                                            Progress = '${percentage.floor()} %';
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
                                  _saveViews(episode);
//                                  _saveDownload(diretorio);
                                });
                              }
                              else if(ep.linkSd == true && quality == 'SD'){
                                if(quality == 'SD'){

                                  ANIMES.PlayerUrl(ep.id, 'SD').then((response) async{
                                    final PPlay url = PPlay.fromJson(jsonDecode(response.body));
                                    mp4 = url.requestedMP4.url;
                                    String name = (widget.nome);
                                    String numero = (index+1).toString();
                                    String dire = '/storage/emulated/0/Download/Animese/${name}/${'SD'+"_"+numero}.mp4';
                                    try {
                                      dio.download(
                                          mp4,
                                          '${dire}',
                                          onReceiveProgress: (actualbytes, totalbytes){
                                            var percentage = actualbytes / totalbytes * 100;
                                            _percentage[index] = percentage / 100;
                                            setState(() {
                                              Progress = '${percentage.floor()} %';
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
                                    _saveViews(episode);
//                                  _saveDownload(diretorio);
                                  });
                                }
                              }
                              else if(ep.linkBg == true && quality == 'BG'){
                                ANIMES.PlayerUrl(ep.id, 'BG').then((response) async{
                                  final PPlay url = PPlay.fromJson(jsonDecode(response.body));
                                  mp4 = url.requestedMP4.url;
                                  String name = (widget.nome);
                                  String numero = (index+1).toString();
                                  String dire = '/storage/emulated/0/Download/Animese/${name}/${'BG'+"_"+numero}.mp4';
                                  try {
                                    dio.download(
                                        mp4,
                                        '${dire}',
                                        onReceiveProgress: (actualbytes, totalbytes){
                                          var percentage = actualbytes / totalbytes * 100;
                                          _percentage[index] = percentage / 100;
                                          setState(() {
                                            Progress = '${percentage.floor()} %';
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
                                                      Wakelock.enable();
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
                                  _saveViews(episode);
//                                  _saveDownload(diretorio);
                                });
                              }
                            });
                          },
                        ),

                        IconButton(
                          icon: Icon(visibility, color: Colors.red,size: 32,),
                          color: Colors.black26,
                          onPressed: (){
                            Wakelock.enable();
                            if(visibility == Icons.visibility){
                              _saveViews(index+1);
                            }else{
                              _saveViews(index);
                            }
                          },
                        ),

                      ],
                    )
                  ],
                ),
              );
            },
          ),
//          CardPlayer(ep: widget.epi, epState: epState,id: widget.id ,vc: vc, lanuage: widget.language, titleSink: titleSink, nome: widget.nome+'   ',)
        )]
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
          vc.setSource(VideoPlayerController.network(mp4));
          vc.initialize();
          vc.play();
        });
      }
      else if(ep.linkSd == true){
        ANIMES.PlayerUrl(ep.id, 'SD').then((response) async{
          final PPlay url = PPlay.fromJson(jsonDecode(response.body));
          mp4 = url.requestedMP4.url;
          vc.setSource(VideoPlayerController.network(mp4));
          vc.initialize();
          vc.play();
        });
      }
      else if(ep.linkBg == true){
        ANIMES.PlayerUrl(ep.id, 'BG').then((response) async{
          final PPlay url = PPlay.fromJson(jsonDecode(response.body));
          mp4 = url.requestedMP4.url;
          vc.setSource(VideoPlayerController.network(mp4));
          vc.initialize();
          vc.play();
        });
      }
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
        vc.setSource(VideoPlayerController.network(mp4));
        vc.initialize();
        vc.play();
      });
      _saveViews(episode);
    });
  }

  _PlayVideo(bool validador, int episode) async {
    Wakelock.enable();
    if(episode >= 100){
      widget.nome = widget.nome.replaceRange(widget.nome.length-5, widget.nome.length, '   ') + episode.toString();
      titleSink.add(widget.nome);
    }else if (episode >= 10){
      widget.nome = widget.nome.replaceRange(widget.nome.length-4, widget.nome.length, '   ') + episode.toString();
      titleSink.add(widget.nome);
    }else{
      widget.nome = widget.nome.replaceRange(widget.nome.length-3, widget.nome.length, '   ') + episode.toString();
      titleSink.add(widget.nome);
    }
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
          vc.setSource(VideoPlayerController.network(mp4));
          vc.initialize();
          vc.play();
        });
      }
      else if(ep.linkBg == true){
        ANIMES.PlayerUrl(ep.id, 'BG').then((response) async{
          final PPlay url = PPlay.fromJson(jsonDecode(response.body));
          mp4 = url.requestedMP4.url;
          vc.setSource(VideoPlayerController.network(mp4));
          vc.initialize();
          vc.play();
        });
      }
      _saveViews(episode);
    });
  }
}