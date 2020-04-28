class ListJsonOvaMovie {
  bool btnDub;
  bool btnLeg;
  String capa;
  String ds;
  String duracao;
  int id;
  String lancamento;
  String linkDub;
  String linkLeg;
  String nome;
  String qualidadeImagem;

  ListJsonOvaMovie(
      {this.btnDub,
        this.btnLeg,
        this.capa,
        this.ds,
        this.duracao,
        this.id,
        this.lancamento,
        this.linkDub,
        this.linkLeg,
        this.nome,
        this.qualidadeImagem});

  ListJsonOvaMovie.fromJson(Map<String, dynamic> json) {
    btnDub = json['btn_dub'];
    btnLeg = json['btn_leg'];
    capa = json['capa'];
    ds = json['ds'];
    duracao = json['duracao'];
    id = json['id'];
    lancamento = json['lancamento'];
    linkDub = json['link_dub'];
    linkLeg = json['link_leg'];
    nome = json['nome'];
    qualidadeImagem = json['qualidade_imagem'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['btn_dub'] = this.btnDub;
    data['btn_leg'] = this.btnLeg;
    data['capa'] = this.capa;
    data['ds'] = this.ds;
    data['duracao'] = this.duracao;
    data['id'] = this.id;
    data['lancamento'] = this.lancamento;
    data['link_dub'] = this.linkDub;
    data['link_leg'] = this.linkLeg;
    data['nome'] = this.nome;
    data['qualidade_imagem'] = this.qualidadeImagem;
    return data;
  }
}
