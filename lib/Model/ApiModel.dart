class ApiModel {
  String photographerName;
  SrcModel src;
  String mainUrl;

  ApiModel({
    this.src,
    this.photographerName,
    this.mainUrl,
  });

  factory ApiModel.fromMap(Map<String, dynamic> jsonData) {
    return ApiModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographerName: jsonData["photographer"],
      mainUrl: jsonData["url"],
    );
  }
}

class SrcModel {
  String original;
  String large2x;
  String medium;
  String portrait;

  SrcModel({
    this.original,
    this.large2x,
    this.medium,
    this.portrait,
  });

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      original: jsonData["original"],
      large2x: jsonData["large2x"],
      medium: jsonData["medium"],
      portrait: jsonData["portrait"],
    );
  }
}
