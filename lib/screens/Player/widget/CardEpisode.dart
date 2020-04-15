//widget
import 'package:flutter/material.dart';
//request
import 'package:animese/request/Request.dart';
import 'package:animese/request/JSON/Episode/Episode.dart';
import 'package:animese/request/JSON/Episode/Player.dart';
import 'dart:convert';
//Player
import 'package:video_box/video.controller.dart';
import 'package:video_player/video_player.dart';
import 'package:url_launcher/url_launcher.dart';


// ignore: must_be_immutable
class CardPlayer extends StatelessWidget {
  final int ep;
  final int id;
  VideoController vc;

  CardPlayer({
    this.ep,
    this.id,
    this.vc
  });

  _launchURL(bool validador, int episode) async {
    String mp4;

    ANIMES.Ep(id, episode, 'LEG').then((response){
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

    });

  }

  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height+100,
      alignment: Alignment.bottomLeft,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: ep,
        padding: EdgeInsets.only(bottom: 330),
        itemBuilder: (BuildContext context, int index) {
          return Card(
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.play_circle_outline, color: Colors.red,size: 32,),
                  color: Colors.red,
                  onPressed: (){_launchURL(false, (index+1));},
                ),
                Text('Episódio '+(index+1).toString()),
                Padding(padding: EdgeInsets.only(right: MediaQuery.of(context).size.height*0.12)),
                FlatButton(
                  child: Text('Externo',
                    style: TextStyle(
                        fontWeight: FontWeight.w400
                    ),
                  ),
                  onPressed: (){_launchURL(true, (index+1));},
                ),
                IconButton(
                  icon: Icon(Icons.file_download, color: Colors.red,size: 32,),
                  color: Colors.black26,
                  onPressed: (){},
                ),
              ],
            ),
          );
        },
      ),
    );

  }
}
