import 'package:cv/models/language_model.dart';
import 'package:flutter/material.dart';

class LanguageWidget extends StatelessWidget {
  final String language;
  final String level;

  const LanguageWidget({
    Key key,
    @required this.language,
    @required this.level,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(language),
        SizedBox(height: 8),
        Text(level.toUpperCase(),
            style: TextStyle(color: Theme.of(context).accentColor)),
      ],
    );
  }

  factory LanguageWidget.fromModel(LanguageModel model) =>
      LanguageWidget(language: model.language, level: model.level);
}
