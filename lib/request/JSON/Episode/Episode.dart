// ignore: camel_case_types
class episodesVal {
  int ep;
  int id;
  int idEP;
  bool linkBg;
  bool linkHd;
  bool linkM18;
  bool linkM22;
  bool linkM37;
  bool linkSd;

  episodesVal(
      {this.ep,
        this.id,
        this.idEP,
        this.linkBg,
        this.linkHd,
        this.linkM18,
        this.linkM22,
        this.linkM37,
        this.linkSd});

  episodesVal.fromJson(Map<String, dynamic> json) {
    ep = json['ep'];
    id = json['id'];
    idEP = json['idEP'];
    linkBg = json['link_bg'];
    linkHd = json['link_hd'];
    linkM18 = json['link_m18'];
    linkM22 = json['link_m22'];
    linkM37 = json['link_m37'];
    linkSd = json['link_sd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ep'] = this.ep;
    data['id'] = this.id;
    data['idEP'] = this.idEP;
    data['link_bg'] = this.linkBg;
    data['link_hd'] = this.linkHd;
    data['link_m18'] = this.linkM18;
    data['link_m22'] = this.linkM22;
    data['link_m37'] = this.linkM37;
    data['link_sd'] = this.linkSd;
    return data;
  }
}
