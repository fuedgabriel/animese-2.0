import 'package:flutter/material.dart';
import 'package:video_box/video.controller.dart';
import 'package:video_box/video_box.dart';
// import 'package:video_box/widgets/buffer_slider.dart';
import 'package:video_player/video_player.dart';
import 'widget/CardEpisode.dart';

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

  ScrollController controller = ScrollController();
  @override
  void initState() {
    super.initState();
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
                    onPressed: () {},
                  ),
                ),
                Align(
                  alignment: Alignment(-0.5, 0.0),
                  child: IconButton(
                    iconSize: VideoBox.centerIconSize,
                    disabledColor: Colors.white60,
                    icon: Icon(Icons.skip_previous),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
          CardPlayer(ep: widget.ep, id: widget.id ,vc: vc, lanuage: widget.language,)

        ],
      ),
    );
  }
}