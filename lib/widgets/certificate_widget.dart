import 'package:cv/models/certificate_model.dart';
import 'package:flutter/material.dart';

class CertificateWidget extends StatelessWidget {
  final String title;
  final String school;

  const CertificateWidget({
    Key key,
    @required this.title,
    @required this.school,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style:
            DefaultTextStyle.of(context).style.copyWith(color: Colors.black87),
        children: [
          TextSpan(text: title),
          TextSpan(
              text: ' @$school', style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  factory CertificateWidget.fromModel(CertificateModel model) =>
      CertificateWidget(title: model.title, school: model.school);
}
