import 'package:cv/data_loader.dart';
import 'package:cv/models/certificate_model.dart';
import 'package:cv/models/language_model.dart';
import 'package:cv/widgets/certificate_widget.dart';
import 'package:cv/widgets/language_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'models/experience_model.dart';
import 'widgets/category_card.dart';
import 'widgets/job_position.dart';
import 'widgets/skill_list_widget.dart';

void main() => runApp(CVApp());

class CVApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CV Viktor Goltstein',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(color: Colors.black54),
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white54),
          headline6: TextStyle(color: Colors.black54),
        ),
      ),
      home: CVPage(),
    );
  }
}

class CVPage extends StatelessWidget {
  static const CATEGORIES_COUNT = 5;
  static const CROSS_AXIS_COUNT = 2;
  static const CATEGORY_ICON_SIZE = 30.0;

  final DataLoader _loader = DataLoader();
  final List<ListTile> drawerItems = [
    ListTile(
      leading: Icon(Icons.person),
      title: Text(
        'I am an enthusiastic, self-motivated, reliable, responsible and hard working person. I am a mature team worker and adaptable to '
        'all challenging situations. I am able to work well both in a team environment as well as using own initiative.',
        style: TextStyle(fontSize: 12),
      ),
    ),
    ListTile(
      leading: Icon(Icons.phone),
      title: Text('(+48) 792 33 80 84'),
      subtitle: Text('Mobile', style: TextStyle(fontSize: 10)),
    ),
    ListTile(
      leading: Icon(Icons.mail),
      title: Text('v.goltstein@gmail.com'),
      subtitle: Text('Personal', style: TextStyle(fontSize: 10)),
    ),
    ListTile(
      leading: Image.asset('assets/in.png', width: 25),
      title: Text('www.linkedin.com/in/viktor- goltstein-421a46a4'),
    ),
    ListTile(
      leading: Icon(Icons.pin_drop),
      title: Text('Wrocław'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).accentColor,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            width: 300,
            child: Column(
              children: [
                ClipRRect(
                  borderRadius:
                      BorderRadius.only(bottomRight: Radius.circular(36)),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset('assets/photo.jpg', width: 300),
                      ColoredBox(
                        color: Colors.black.withOpacity(0.7),
                        child: ListTile(
                          title: Text('Viktor Goltstein',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontSize: 24)),
                          subtitle: Text('Flutter/Android Developer'),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.separated(
                    itemBuilder: (_, index) => drawerItems[index],
                    separatorBuilder: (_, __) => Divider(),
                    itemCount: drawerItems.length,
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: StaggeredGridView(
              children: [
                CategoryCard(
                  icon: Icon(Icons.work),
                  title: Text('Work experience'),
                  content: FutureBuilder<List<ExperienceModel>>(
                    future: _loader.loadExperience(),
                    builder: (_, snapshot) => Column(
                        children: (snapshot.data ?? List())
                            .map((position) => JobPosition.test(position))
                            .toList()),
                  ),
                ),
                CategoryCard(
                  icon: Icon(Icons.school),
                  title: Text('Education'),
                  content: FutureBuilder<List<ExperienceModel>>(
                    future: _loader.loadEducation(),
                    builder: (_, snapshot) => Column(
                        children: (snapshot.data ?? List())
                            .map((position) => JobPosition.test(position))
                            .toList()),
                  ),
                ),
                CategoryCard(
                  icon: Icon(Icons.language),
                  title: Text('Languages'),
                  ignorePadding: true,
                  content: FutureBuilder<List<LanguageModel>>(
                    future: _loader.loadLanguages(),
                    builder: (_, snapshot) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: (snapshot.data ?? List())
                          .map((language) => LanguageWidget.test(language))
                          .toList(),
                    ),
                  ),
                ),
                CategoryCard(
                  icon: Icon(FontAwesomeIcons.paste),
                  title: Text('Skills'),
                  content: FutureBuilder<List<String>>(
                    future: _loader.loadSkills(),
                    builder: (_, snapshot) =>
                        SkillListWidget(snapshot.data ?? List()),
                  ),
                ),
                CategoryCard(
                  icon: Icon(FontAwesomeIcons.solidIdBadge),
                  title: Text('Certificates'),
                  content: FutureBuilder<List<CertificateModel>>(
                      future: _loader.loadCerts(),
                      builder: (_, snapshot) {
                        var data = (snapshot.data ?? List())
                            .map((cert) => CertificateWidget.test(cert))
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
                crossAxisCount: CROSS_AXIS_COUNT,
                staggeredTileBuilder: (int index) => index == 0
                    ? StaggeredTile.fit(CROSS_AXIS_COUNT)
                    : StaggeredTile.fit(
                        MediaQuery.of(context).size.width < 1000 ? 2 : 1),
                staggeredTileCount: CATEGORIES_COUNT,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
