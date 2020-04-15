class AnimeListJson {
  String capa;
  int id;
  String nome;
  String numTemporada;
  String temporada;

  AnimeListJson(
      {this.capa, this.id, this.nome, this.numTemporada, this.temporada});

  AnimeListJson.fromJson(Map<String, dynamic> json) {
    capa = json['capa'];
    id = json['id'];
    nome = json['nome'];
    numTemporada = json['numTemporada'];
    temporada = json['temporada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capa'] = this.capa;
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['numTemporada'] = this.numTemporada;
    data['temporada'] = this.temporada;
    return data;
  }
}
