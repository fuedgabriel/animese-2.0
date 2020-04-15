class LittleListAnimeJson {
  String capa;
  int id;
  String nome;

  LittleListAnimeJson({this.capa, this.id, this.nome});

  LittleListAnimeJson.fromJson(Map<String, dynamic> json) {
    capa = json['capa'];
    id = json['id'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capa'] = this.capa;
    data['id'] = this.id;
    data['nome'] = this.nome;
    return data;
  }
}
