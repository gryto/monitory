// ignore_for_file: use_build_context_synchronously, duplicate_ignore
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screen/ui/ccis/datun/map.dart';
import '../screen/ui/ccis/jambin/detail_jambin.dart';
import '../screen/ui/ccis/jamintel/detail_jamintel.dart';
import '../screen/ui/ccis/jampidmil/map.dart';
import '../screen/ui/ccis/jamwas/map.dart';
import '../screen/ui/ccis/page.dart';
import '../screen/ui/ccis/pidsus/map.dart';
import '../screen/ui/ccis/pidum/map.dart';
import '../screen/ui/main_home.dart';
import '../src/api.dart';
import '../src/preference.dart';
import '../src/toast.dart';
import '../login/login.dart';

class LauncherPage extends StatefulWidget {
  const LauncherPage({Key? key}) : super(key: key);

  @override
  State<LauncherPage> createState() => _LauncherPageState();
}

class _LauncherPageState extends State<LauncherPage> {
  SharedPref sharedPref = SharedPref();
  String url = ApiService.detailUser;
  String message = "";
  bool isLogged = false;

  @override
  void initState() {
    startLaunching();
    super.initState();
  }

  startLaunching() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, checkSession);
  }

  void checkSession() async {
    var accessToken = await sharedPref.getPref("access_token");
    var userBidang = await sharedPref.getPref("user_bidang");
    var userRole = await sharedPref.getPref("level");
    print(accessToken);

    if (accessToken != "") {
      var userId = await sharedPref.getPref("id");

      String tahun = "2023";
      String tahun2 = "2022";
      await getDetailUser(userId, accessToken);

      if (isLogged == true) {
        if (userRole == "1") {
          goToApp(userId);
        } else if (userRole == "3") {
          goToApp(userId);
        } else if (userRole == "2") {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => CcisPage(
                  role: userRole,
                  bidangId: userId,
                ),
              ),
              (Route<dynamic> route) => false);
        }else{
        if (userBidang == "9") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => CcisPage(
                  role: userRole,
                  bidangId: userId,
                ),
              ),
              (Route<dynamic> route) => false);
        } else if (userBidang == "3") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    MapJamwas(accessToken: accessToken, tahun: tahun),
              ),
              (Route<dynamic> route) => false);
        } else if (userBidang == "5") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    DetailDatun(
                            accessToken: accessToken, tahun: tahun),
              ),
              (Route<dynamic> route) => false);
        } else if (userBidang == "2") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    DetailPidsus(accessToken: accessToken, tahun: tahun),
              ),
              (Route<dynamic> route) => false);
        } else if (userBidang == "7") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    DetailPidum(accessToken: accessToken, tahun: tahun),
              ),
              (Route<dynamic> route) => false);
        } else if (userBidang == "1") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    DetailJambin(accessToken: accessToken, tahun: tahun),
              ),
              (Route<dynamic> route) => false);
        } else if (userBidang == "4") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => MapJampidmil(
                              accessToken: accessToken, tahun: tahun2),
              ),
              (Route<dynamic> route) => false);
        } else if (userBidang == "6") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) =>
                    DetailJamintel(accessToken: accessToken, tahun: tahun),
              ),
              (Route<dynamic> route) => false);
        } else {
          print(userBidang);
          goToApp(userId);
        }
        }
      } else {
        goToLogin();
      }
    } else {
      // ignore: use_build_context_synchronously
      toastShort(context, "Akses token telah berakhir.");
      goToLogin();
    }
  }

  getDetailUser(userId, accessToken) async {
    try {
      var uri = "$url/$userId";
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          isLogged = true;
        });
      } else {
        setState(() {
          toastShort(context, content['message']);
          isLogged = false;
        });
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context, "Data sesi login telah berakhir.");
      isLogged = false;
    }
  }

  void goToApp(userId) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MainHome(id: userId),
        ),
        (Route<dynamic> route) => false);
  }

  void goToLogin() {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
      return const LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.80,
          child: Image.asset(
            "assets/images/kejaksaan-logo.jpg",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
