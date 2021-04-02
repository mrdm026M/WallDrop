class ApiModel {
  String photographerName;
  SrcModel src;

  ApiModel({
    this.src,
    this.photographerName,
  });

  factory ApiModel.fromMap(Map<String, dynamic> jsonData) {
    return ApiModel(
      src: SrcModel.fromMap(jsonData["src"]),
      photographerName: jsonData["photographer"],
    );
  }
}

class SrcModel {
  String large2x;
  String medium;
  String portrait;

  SrcModel({
    this.large2x,
    this.medium,
    this.portrait,
  });

  factory SrcModel.fromMap(Map<String, dynamic> jsonData) {
    return SrcModel(
      portrait: jsonData["portrait"],
      large2x: jsonData["large2x"],
      medium: jsonData["medium"],
    );
  }
}
