import 'package:flutter/material.dart';

class SkillListWidget extends StatelessWidget {
  final List<String> skillList;

  SkillListWidget(this.skillList);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 4.0,
      children: skillList.map((skill) => Text('$skill, ')).toList(),
    );
  }
}
