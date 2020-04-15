class HomeLancamentoJson {
  String capa;
  int id;
  String nome;
  String numTemporada;
  String temporada;

  HomeLancamentoJson(
      {this.capa, this.id, this.nome, this.numTemporada, this.temporada});

  HomeLancamentoJson.fromJson(Map<String, dynamic> json) {
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
