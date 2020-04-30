class ExperienceModel {
  String position;
  String company;
  String duration;
  String description;

  ExperienceModel(
      {this.position, this.company, this.duration, this.description});

  ExperienceModel.fromJson(Map<String, dynamic> json) {
    position = json['position'];
    company = json['company'];
    duration = json['duration'];
    description = json['description'];
  }
}
