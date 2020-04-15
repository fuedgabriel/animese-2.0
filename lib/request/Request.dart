import 'package:http/http.dart' as http;
const baseUrl = "http://192.168.1.70:7844";


class ANIMES{
  // ignore: non_constant_identifier_names
  static Future HomePage() async{
    String url = 'https://home.myvideo.vip/api-new/homenewalw';
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future AnimeList(page) async{
    String url = 'https://remainder.myvideo.vip/api-new/animes/'+page.toString()+'?search=all';
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future AnimeSearch(name) async{
    String url = 'https://remainder.myvideo.vip/api-new/animes/1?search='+name.toString();
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future Description(id) async{
    String url = 'https://remainder.myvideo.vip/api-new/anime/'+id.toString();
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future Ep(id, ep, language) async{
    String url = 'https://remainder.myvideo.vip/api-new/eps/'+id.toString()+'/'+language+'/1?search='+ep.toString();
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future PlayerUrl(id,quality) async{
    String url = 'https://remainder.myvideo.vip/api-new/assistindov2/'+quality+'/'+id.toString()+'/PLAYER-2/c7e5767ead45d629';
    return await http.get(url);
  }
}
class API{


}