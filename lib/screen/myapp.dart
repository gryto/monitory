import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import '../launcher/launcher.dart';
import '../src/constant.dart';
import 'package:sizer/sizer.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent, //top bar color
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            canvasColor: CustomColors.greyBackground,
            fontFamily: 'MONITORIY',
          ),
          //home: DetailJamwas(),
          home: const LauncherPage(),
        );
      },
    );
  }
}
