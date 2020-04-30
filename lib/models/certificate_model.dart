class CertificateModel {
  String title;
  String school;

  CertificateModel({this.title, this.school});

  CertificateModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    school = json['school'];
  }
}
