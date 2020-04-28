import 'package:http/http.dart' as http;


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
  static Future MovieList(page) async{
    String url = 'https://remainder.samehada.stream/api-new/menufilmes/'+page.toString()+'?search=all';
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future OvaList(page) async{
    String url = 'https://remainder.samehada.stream/api-new/menuovas/'+page.toString()+'?search=all';
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future AnimeSearch(name) async{
    String url = 'https://remainder.myvideo.vip/api-new/animes/1?search='+name.toString();
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future MovieSearch(name) async{
    String url = 'https://remainder.samehada.stream/api-new/menufilmes/1?search='+name.toString();
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future OvaSearch(name) async{
    String url = 'https://remainder.samehada.stream/api-new/menuovas/1?search='+name.toString();
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future MovieOvaGet(id, language, end) async{
    String url = 'https://remainder.myvideo.vip/api-new/assistindoFilmeOva/'+id.toString()+'/'+language.toString()+'/'+end;
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future Description(id, type) async{
    if(type == 'Animes'){
      String url = 'https://remainder.myvideo.vip/api-new/anime/'+id.toString();
      return await http.get(url);
    }else if(type == 'Filmes'){
      String url = 'https://remainder.samehada.stream/api-new/filme/'+id.toString();
      return await http.get(url);
    }else{
      String url = 'https://remainder.samehada.stream/api-new/ova/'+id.toString();
      return await http.get(url);
    }
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
  // ignore: non_constant_identifier_names
  static Future GetCategory() async{
    String url = 'http://remainder.samehada.stream/api-new/categorias';
    return await http.get(url);
  }
  // ignore: non_constant_identifier_names
  static Future GetCategoryList(id, page) async{
    String url = 'http://remainder.samehada.stream/api-new/categoria/'+id.toString()+'/'+page.toString();
    return await http.get(url);
  }

}
