class DescriptionJson {
  bool btnDub;
  bool btnLeg;
  String capa;
  List<Cat> cat;
  String ds;
  int epDub;
  int epLeg;
  List<Filmes> filmes;
  int id;
  String lancamento;
  String nome;
  String numTemporada;
  List<Ovas> ovas;
  String producao;
  String temporada;

  DescriptionJson(
      {this.btnDub,
        this.btnLeg,
        this.capa,
        this.cat,
        this.ds,
        this.epDub,
        this.epLeg,
        this.filmes,
        this.id,
        this.lancamento,
        this.nome,
        this.numTemporada,
        this.ovas,
        this.producao,
        this.temporada});

  DescriptionJson.fromJson(Map<String, dynamic> json) {
    btnDub = json['btn_dub'];
    btnLeg = json['btn_leg'];
    capa = json['capa'];
    if (json['cat'] != null) {
      cat = new List<Cat>();
      json['cat'].forEach((v) {
        cat.add(new Cat.fromJson(v));
      });
    }
    ds = json['ds'];
    epDub = json['ep_dub'];
    epLeg = json['ep_leg'];
    if (json['filmes'] != null) {
      filmes = new List<Filmes>();
      json['filmes'].forEach((v) {
        filmes.add(new Filmes.fromJson(v));
      });
    }
    id = json['id'];
    lancamento = json['lancamento'];
    nome = json['nome'];
    numTemporada = json['numTemporada'];
    if (json['ovas'] != null) {
      ovas = new List<Ovas>();
      json['ovas'].forEach((v) {
        ovas.add(new Ovas.fromJson(v));
      });
    }
    producao = json['producao'];
    temporada = json['temporada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['btn_dub'] = this.btnDub;
    data['btn_leg'] = this.btnLeg;
    data['capa'] = this.capa;
    if (this.cat != null) {
      data['cat'] = this.cat.map((v) => v.toJson()).toList();
    }
    data['ds'] = this.ds;
    data['ep_dub'] = this.epDub;
    data['ep_leg'] = this.epLeg;
    if (this.filmes != null) {
      data['filmes'] = this.filmes.map((v) => v.toJson()).toList();
    }
    data['id'] = this.id;
    data['lancamento'] = this.lancamento;
    data['nome'] = this.nome;
    data['numTemporada'] = this.numTemporada;
    if (this.ovas != null) {
      data['ovas'] = this.ovas.map((v) => v.toJson()).toList();
    }
    data['producao'] = this.producao;
    data['temporada'] = this.temporada;
    return data;
  }
}

class Cat {
  int id;
  int idCategoria;
  String nome;

  Cat({this.id, this.idCategoria, this.nome});

  Cat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idCategoria = json['id_categoria'];
    nome = json['nome'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_categoria'] = this.idCategoria;
    data['nome'] = this.nome;
    return data;
  }
}

class Filmes {
  String capa;
  int id;
  String nome;

  Filmes({this.capa, this.id, this.nome});

  Filmes.fromJson(Map<String, dynamic> json) {
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

class Ovas {
  String capa;
  int id;
  String nome;

  Ovas({this.capa, this.id, this.nome});

  Ovas.fromJson(Map<String, dynamic> json) {
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