class PPlay {
  RequestedMP4 requestedMP4;

  PPlay({this.requestedMP4});

  PPlay.fromJson(Map<String, dynamic> json) {
    requestedMP4 = json['requestedMP4'] != null
        ? new RequestedMP4.fromJson(json['requestedMP4'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.requestedMP4 != null) {
      data['requestedMP4'] = this.requestedMP4.toJson();
    }
    return data;
  }
}

class RequestedMP4 {
  String description;
  String download;
  bool maxUsers;
  String mp4;
  String title;
  String tkv;
  String url;

  RequestedMP4(
      {this.description,
        this.download,
        this.maxUsers,
        this.mp4,
        this.title,
        this.tkv,
        this.url});

  RequestedMP4.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    download = json['download'];
    maxUsers = json['maxUsers'];
    mp4 = json['mp4'];
    title = json['title'];
    tkv = json['tkv'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['description'] = this.description;
    data['download'] = this.download;
    data['maxUsers'] = this.maxUsers;
    data['mp4'] = this.mp4;
    data['title'] = this.title;
    data['tkv'] = this.tkv;
    data['url'] = this.url;
    return data;
  }
}
