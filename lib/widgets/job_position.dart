import 'package:cv/models/experience_model.dart';
import 'package:flutter/material.dart';

class JobPosition extends StatelessWidget {
  final String position;
  final String company;
  final String duration;
  final String description;

  const JobPosition({
    Key key,
    @required this.position,
    @required this.company,
    @required this.duration,
    this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        RichText(
          text: TextSpan(
            style: DefaultTextStyle.of(context)
                .style
                .copyWith(color: Colors.black87),
            children: [
              TextSpan(text: position),
              TextSpan(
                  text: ' @$company',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        Text(duration, style: TextStyle(color: Theme.of(context).accentColor)),
        SizedBox(height: 4),
        if (description != null)
          Text(description,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.grey)),
        SizedBox(height: 8),
      ],
    );
  }

  factory JobPosition.fromModel(ExperienceModel position) => JobPosition(
        position: position.position,
        company: position.company,
        duration: position.duration,
        description: position.description,
      );
}
