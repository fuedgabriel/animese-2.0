class HomeJson {
  List<Lancamentos> lancamentos;
  List<Recentes> recentes;
  Recomendado recomendado;
  List<UltimosAtualizados> ultimosAtualizados;
  List<UltimosFilmes> ultimosFilmes;
  List<UltimosOvas> ultimosOvas;

  HomeJson(
      {this.lancamentos,
        this.recentes,
        this.recomendado,
        this.ultimosAtualizados,
        this.ultimosFilmes,
        this.ultimosOvas});

  HomeJson.fromJson(Map<String, dynamic> json) {
    if (json['lancamentos'] != null) {
      lancamentos = new List<Lancamentos>();
      json['lancamentos'].forEach((v) {
        lancamentos.add(new Lancamentos.fromJson(v));
      });
    }
    if (json['recentes'] != null) {
      recentes = new List<Recentes>();
      json['recentes'].forEach((v) {
        recentes.add(new Recentes.fromJson(v));
      });
    }
    recomendado = json['recomendado'] != null
        ? new Recomendado.fromJson(json['recomendado'])
        : null;
    if (json['ultimosAtualizados'] != null) {
      ultimosAtualizados = new List<UltimosAtualizados>();
      json['ultimosAtualizados'].forEach((v) {
        ultimosAtualizados.add(new UltimosAtualizados.fromJson(v));
      });
    }
    if (json['ultimosFilmes'] != null) {
      ultimosFilmes = new List<UltimosFilmes>();
      json['ultimosFilmes'].forEach((v) {
        ultimosFilmes.add(new UltimosFilmes.fromJson(v));
      });
    }
    if (json['ultimosOvas'] != null) {
      ultimosOvas = new List<UltimosOvas>();
      json['ultimosOvas'].forEach((v) {
        ultimosOvas.add(new UltimosOvas.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.lancamentos != null) {
      data['lancamentos'] = this.lancamentos.map((v) => v.toJson()).toList();
    }
    if (this.recentes != null) {
      data['recentes'] = this.recentes.map((v) => v.toJson()).toList();
    }
    if (this.recomendado != null) {
      data['recomendado'] = this.recomendado.toJson();
    }
    if (this.ultimosAtualizados != null) {
      data['ultimosAtualizados'] =
          this.ultimosAtualizados.map((v) => v.toJson()).toList();
    }
    if (this.ultimosFilmes != null) {
      data['ultimosFilmes'] =
          this.ultimosFilmes.map((v) => v.toJson()).toList();
    }
    if (this.ultimosOvas != null) {
      data['ultimosOvas'] = this.ultimosOvas.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class Recentes {
  String capa;
  int id;
  String nome;
  String numTemporada;
  String temporada;

  Recentes({this.capa, this.id, this.nome, this.numTemporada, this.temporada});

  Recentes.fromJson(Map<String, dynamic> json) {
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

class UltimosAtualizados {
  String capa;
  int id;
  String nome;
  String numTemporada;
  String temporada;

  UltimosAtualizados(
      {this.capa, this.id, this.nome, this.numTemporada, this.temporada});

  UltimosAtualizados.fromJson(Map<String, dynamic> json) {
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

class Lancamentos {
  String capa;
  int id;
  String nome;
  String numTemporada;
  String temporada;

  Lancamentos(
      {this.capa, this.id, this.nome, this.numTemporada, this.temporada});

  Lancamentos.fromJson(Map<String, dynamic> json) {
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

class Recomendado {
  String capa;
  String ds;
  int id;
  String nome;
  String numTemporada;
  String temporada;

  Recomendado(
      {this.capa,
        this.ds,
        this.id,
        this.nome,
        this.numTemporada,
        this.temporada});

  Recomendado.fromJson(Map<String, dynamic> json) {
    capa = json['capa'];
    ds = json['ds'];
    id = json['id'];
    nome = json['nome'];
    numTemporada = json['numTemporada'];
    temporada = json['temporada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capa'] = this.capa;
    data['ds'] = this.ds;
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['numTemporada'] = this.numTemporada;
    data['temporada'] = this.temporada;
    return data;
  }
}

class UltimosFilmes {
  String capa;
  int id;

  UltimosFilmes({this.capa, this.id});

  UltimosFilmes.fromJson(Map<String, dynamic> json) {
    capa = json['capa'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capa'] = this.capa;
    data['id'] = this.id;
    return data;
  }
}
class UltimosOvas {
  String capa;
  int id;

  UltimosOvas({this.capa, this.id});

  UltimosOvas.fromJson(Map<String, dynamic> json) {
    capa = json['capa'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['capa'] = this.capa;
    data['id'] = this.id;
    return data;
  }
}
class MaisAssistidos {
  String capa;
  int id;
  String nome;
  String numTemporada;
  String temporada;

  MaisAssistidos(
      {this.capa, this.id, this.nome, this.numTemporada, this.temporada});

  MaisAssistidos.fromJson(Map<String, dynamic> json) {
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