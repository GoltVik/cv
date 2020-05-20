import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'main_cv_page.dart';

void main() => runApp(
      EasyLocalization(
        supportedLocales: [const Locale('pl', 'PL'), const Locale('en', 'US')],
        path: 'assets/content',
        child: CVApp(),
      ),
    );

class CVApp extends StatelessWidget {
  ThemeData get mainTheme => ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        iconTheme: IconThemeData(color: Colors.black54),
        textTheme: TextTheme(
          subtitle1: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          caption: TextStyle(color: Colors.white54),
          headline6: TextStyle(color: Colors.black54),
        ),
        canvasColor: Colors.blue,
        dividerColor: Colors.white,
      );

  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'CV Viktor Goltstein',
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: mainTheme,
        home: MainCVPage(),
      );
}
