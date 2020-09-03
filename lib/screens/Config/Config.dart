import 'package:animese/widgets/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';



class Config extends StatefulWidget {
  @override
  _Config createState() => _Config();
}

class _Config extends State<Config> {

  String quality = "HD";

  _saveQuality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Quality', quality);
  }

  _getQuality() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    quality = prefs.getString('Quality');
    if(quality == null){
    }else{
      setState(() {
        quality = prefs.getString('Quality');
      });
    }
  }
  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _Config(){
    _getQuality();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MenuWidget(page: 'Config',),
      appBar: AppBar(
        title: Center(child: Text('Configurações'),),
        elevation: 5,
      ),
      body: ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(height: 10,),
              ListTile(
                  leading: Icon(Icons.star, color: Colors.yellow, size: 56,),
                  title: Text('Avalie-nos na google play', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                  onTap: ()  {
                    _launchURL("https://play.google.com/store/apps/details?id=com.animese.android");
                  }
              ),
              ListTile(
                  leading: Image.network('https://miro.medium.com/max/512/0*E3Nphq-iyw_gsZFH.png'),
                  title: Text('Comunidade no Discord', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                  onTap: ()  {
                    _launchURL('https://discord.gg/G3he5Sc');
                  }
              ),
              ListTile(
                leading: Icon(Icons.email, color: Colors.white, size: 56,),
                title: Text('E-MAIL', style: TextStyle(color: Colors.white),),
                subtitle: Text('animeseempresa@gmail.com', style: TextStyle(color: Colors.yellow),),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                onTap: () {
                  _launchURL('mailto:animeseempresa@gmail.com');
                },
              ),
              ListTile(
                  leading: Icon(Icons.autorenew, color: Colors.white, size: 56,),
                  title: Text('Versão 2.2.7', style: TextStyle(color: Colors.white),),
                  subtitle: Text('Acessar Google Play', style: TextStyle(color: Colors.white),),
                  trailing: Icon(Icons.arrow_forward_ios, color: Colors.yellow,),
                  onTap: ()  {
                    _launchURL("https://play.google.com/store/apps/details?id=com.animese.android");
                  }
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[

                  Text("Qualidade de Download",style: TextStyle(color: Colors.white),),
                  Icon(Icons.arrow_forward, size: 22, color: Colors.white,),
                  DropdownButton<String>(
                    value: quality,
                    icon: Icon(Icons.arrow_downward, color: Colors.yellowAccent,),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.green),
                    underline: Container(
                      height: 2,
                      color: Colors.white,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        quality = newValue;
                        _saveQuality();
                      });
                    },
                    items: <String>['HD', 'SD', 'BG'].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              FlatButton(
                color: Colors.red,
                child: Text("Apagar dados", style: TextStyle(
                  fontWeight: FontWeight.bold
                ),),
                onPressed: (){
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
                                      child: Text("Você realmente deseja continuar?\nSerá apagado todos os seus favoritos, configurações de usuários, pesquisas recentes e histórico de animes.", style: TextStyle(color: Colors.yellow),),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text("Apagar tudo"),
                                            color: Colors.red,
                                            onPressed: () async{
                                              final prefs = await SharedPreferences.getInstance();
                                              prefs.clear();
                                              Navigator.of(context).pushNamedAndRemoveUntil('/BottonBar', (Route<dynamic> route) => false);
                                            },
                                          ),
                                          SizedBox(height: 10, width: 10,),
                                          FlatButton(
                                            child: Text("Cancelar"),
                                            color: Colors.green,
                                            onPressed: (){
                                              Navigator.pop(context);
                                              },
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }),
          ],),
          Padding(padding: EdgeInsets.only(bottom: 0)),


        ],
      ),
    );
  }
}
