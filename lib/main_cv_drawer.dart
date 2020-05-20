import 'package:cv/widgets/language_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MainCVDrawer extends StatelessWidget {
  static const double MIN_CONTENT_HEIGHT = 462;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.asset('assets/images/photo.jpg'),
              ColoredBox(
                color: Colors.black.withOpacity(0.7),
                child: ListTile(
                  title: Text(tr('name'), style: TextStyle(fontSize: 24)),
                  subtitle: Text('Flutter/Android Developer'),
                ),
              )
            ],
          ),
          Expanded(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) =>
                  SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MIN_CONTENT_HEIGHT,
                      maxHeight: constraints.maxHeight < MIN_CONTENT_HEIGHT
                          ? MIN_CONTENT_HEIGHT
                          : constraints.maxHeight),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(Icons.person),
                        title: Text(
                          tr('about'),
                          style: TextStyle(fontSize: 12),
                        ),
                      ),
                      ListTile(
                        onTap: () => launch('tel:(+48) 792 33 80 84'),
                        leading: Icon(Icons.phone),
                        title: Text('(+48) 792 33 80 84'),
                        subtitle:
                            Text(tr('mobile'), style: TextStyle(fontSize: 10)),
                      ),
                      ListTile(
                        onTap: () => launch('mailto:v.goltstein@gmail.com'),
                        leading: Icon(Icons.mail),
                        title: Text('v.goltstein@gmail.com'),
                        subtitle: Text(tr('personal'),
                            style: TextStyle(fontSize: 10)),
                      ),
                      ListTile(
                        onTap: () => launch(
                            'https://www.linkedin.com/in/viktor-goltstein-421a46a4'),
                        leading: Image.asset('assets/images/in.png', width: 25),
                        title: Text(
                            'www.linkedin.com/in/viktor-goltstein-421a46a4'),
                      ),
                      ListTile(
                        leading: Icon(Icons.pin_drop),
                        title: Text('Wrocław'),
                      ),
                      Spacer(),
                      LanguageSwitch(
                        firstChildText: 'English',
                        secondChildText: 'Polski',
                        initialIndex:
                            context.supportedLocales.indexOf(context.locale),
                        onSelectionChanged: (value) => context.locale =
                            context.supportedLocales[value ? 0 : 1],
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
