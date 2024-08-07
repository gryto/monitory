import 'package:flutter/material.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';

import 'calendar.dart';

class LocalizationSupport extends StatelessWidget {
  const LocalizationSupport({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        SfGlobalLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('id'),
        Locale('zh'),
        Locale('he'),
        Locale('ru'),
        Locale('fr', 'BE'),
        Locale('fr', 'CA'),
        Locale('ja'),
        Locale('de'),
        Locale('hi'),
        Locale('ar'),
      ],
      locale: Locale('id'),
      debugShowCheckedModeBanner: false,
      home: CalendarPage(),
    );
  }
}