import 'package:cv/main_cv_drawer.dart';
import 'package:cv/service/data_loader.dart';
import 'package:cv/models/certificate_model.dart';
import 'package:cv/models/language_model.dart';
import 'package:cv/widgets/certificate_widget.dart';
import 'package:cv/widgets/language_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/experience_model.dart';
import 'widgets/category_card.dart';
import 'widgets/job_position.dart';
import 'widgets/skill_list_widget.dart';

class MainCVPage extends StatefulWidget {
  static const CATEGORIES_COUNT = 5;
  static const CROSS_AXIS_COUNT = 2;
  static const MAX_PORTRAIT_WIDTH = 700;

  @override
  _MainCVPageState createState() => _MainCVPageState();
}

class _MainCVPageState extends State<MainCVPage> {
  DataLoader _loader;

  bool inPortraitMode(context) =>
      MediaQuery.of(context).size.width < MainCVPage.MAX_PORTRAIT_WIDTH;

  @override
  void initState() {
    super.initState();
    _loader = DataLoader(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: inPortraitMode(context)
          ? AppBar(title: Text(tr('name')), centerTitle: true)
          : null,
      backgroundColor: Theme.of(context).accentColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (!inPortraitMode(context)) MainCVDrawer(),
          Expanded(
            child: StaggeredGridView(
              children: [
                CategoryCard(
                  icon: Icon(Icons.work),
                  title: Text(tr('experience')),
                  content: FutureBuilder<List<ExperienceModel>>(
                    future: _loader.loadExperience(),
                    builder: (_, snapshot) => Column(
                        children: (snapshot.data ?? List())
                            .map((position) => JobPosition.fromModel(position))
                            .toList()),
                  ),
                ),
                CategoryCard(
                  icon: Icon(Icons.school),
                  title: Text(tr('education')),
                  content: FutureBuilder<List<ExperienceModel>>(
                    future: _loader.loadEducation(),
                    builder: (_, snapshot) => Column(
                        children: (snapshot.data ?? List())
                            .map((position) => JobPosition.fromModel(position))
                            .toList()),
                  ),
                ),
                CategoryCard(
                  icon: Icon(Icons.language),
                  title: Text(tr('languages')),
                  ignorePadding: true,
                  content: FutureBuilder<List<LanguageModel>>(
                    future: _loader.loadLanguages(),
                    builder: (_, snapshot) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: (snapshot.data ?? List())
                          .map((language) => LanguageWidget.fromModel(language))
                          .toList(),
                    ),
                  ),
                ),
                CategoryCard(
                  icon: Icon(FontAwesomeIcons.paste),
                  title: Text(tr('skills')),
                  content: FutureBuilder<List<String>>(
                    future: _loader.loadSkills(),
                    builder: (_, snapshot) =>
                        SkillListWidget(snapshot.data ?? List()),
                  ),
                ),
                CategoryCard(
                  icon: Icon(FontAwesomeIcons.solidIdBadge),
                  title: Text(tr('certificates')),
                  content: FutureBuilder<List<CertificateModel>>(
                      future: _loader.loadCerts(),
                      builder: (_, snapshot) {
                        var data = (snapshot.data ?? List())
                            .map((cert) => CertificateWidget.fromModel(cert))
                            .toList();
                        return ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (_, index) => data[index],
                          separatorBuilder: (_, index) =>
                              Divider(color: Colors.transparent, height: 4),
                          itemCount: data.length,
                        );
                      }),
                ),
              ],
              gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: MainCVPage.CROSS_AXIS_COUNT,
                staggeredTileBuilder: (int index) => index == 0
                    ? StaggeredTile.fit(MainCVPage.CROSS_AXIS_COUNT)
                    : StaggeredTile.fit(
                        MediaQuery.of(context).size.width < 1000 ? 2 : 1),
                staggeredTileCount: MainCVPage.CATEGORIES_COUNT,
              ),
            ),
          ),
        ],
      ),
      drawer: inPortraitMode(context) ? MainCVDrawer() : null,
    );
  }
}
