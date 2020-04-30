class LanguageModel {
  String language;
  String level;

  LanguageModel({this.language, this.level});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    level = json['level'];
  }
}
