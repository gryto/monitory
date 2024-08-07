import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../src/loader.dart';
import '../../../src/logout.dart';
import '../../../src/toast.dart';
import 'constants/api.dart';
import 'datun/map.dart';
import 'jambin/detail_jambin.dart';
import 'jamintel/map.dart';
import 'jampidmil/map.dart';
import 'jamwas/map.dart';
import 'pidsus/map.dart';
import 'pidum/map.dart';
import 'smart_device_box_widget.dart';

class CcisPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final role;
  // ignore: prefer_typing_uninitialized_variables
  final bidangId;
  const CcisPage({super.key, required this.role, required this.bidangId});

  @override
  State<CcisPage> createState() => _CcisPageState();
}

class _CcisPageState extends State<CcisPage> {
  bool isProcess = true;
  String accessToken = "";
  String tahun = "2023";
  String tahun2 = "2022";
  DateTime today = DateTime.now();

  loginCheck() async {
    try {
      var params = jsonEncode({
        "username": "superadmin",
        "password": "P@ssw0rd#123",
      });

      var response = await http.post(Uri.parse(ApiService.setLogin),
          headers: {"Content-Type": "application/json"}, body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          accessToken = content['data']['session']['access_token'];
        });
      } else {
        // ignore: use_build_context_synchronously
        toastShort(context, content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context, e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  @override
  void initState() {
    super.initState();
    loginCheck();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 30, 46),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 40,
                  height: 40,
                  child: Image(
                    image: AssetImage(
                      "assets/images/kejaksaan-logo.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "CASYS",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Command Center & Activity Monitoring System",
                      style: TextStyle(
                          color: Color.fromARGB(255, 232, 232, 232),
                          fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                logoutDialog(context);
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: !isProcess
          ? GridView.count(
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => DetailJambin(
                              accessToken: accessToken, tahun: tahun)
                          // DetailJambin(x
                          //     accessToken: accessToken, tahun: tahun),
                          ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: SmartDeviceBoxWidget(
                      width: w / 6,
                      smartDeviceName: "JAMBIN",
                      imageProvider:
                          const AssetImage("assets/icons/jambin.png"),
                      smartDeviceColor: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 34, 68, 87),
                          Color.fromARGB(255, 13, 30, 46),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => JamintelMapPage(
                            accessToken: accessToken, tahun: tahun),
                      ),
                      //   DetailJamintel(
                      //       accessToken: accessToken, tahun: tahun),
                      // ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: SmartDeviceBoxWidget(
                      smartDeviceName: "JAMINTEL",
                      width: w / 6,
                      imageProvider:
                          const AssetImage("assets/icons/jamintel.png"),
                      smartDeviceColor: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                         Color.fromARGB(255, 34, 68, 87),
                          Color.fromARGB(255, 13, 30, 46),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPidum(accessToken: accessToken, tahun: tahun),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: SmartDeviceBoxWidget(
                      smartDeviceName: "JAMPIDUM",
                      width: w / 6,
                      imageProvider:
                          const AssetImage("assets/icons/jampidum.png"),
                      smartDeviceColor: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                         Color.fromARGB(255, 34, 68, 87),
                          Color.fromARGB(255, 13, 30, 46),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailPidsus(
                            accessToken: accessToken, tahun: tahun),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: SmartDeviceBoxWidget(
                      width: w / 6,
                      smartDeviceName: "JAMPIDSUS",
                      imageProvider:
                          const AssetImage("assets/icons/jampidsus.png"),
                      smartDeviceColor: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                         Color.fromARGB(255, 34, 68, 87),
                          Color.fromARGB(255, 13, 30, 46),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailDatun(accessToken: accessToken, tahun: tahun),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: SmartDeviceBoxWidget(
                      smartDeviceName: "JAMDATUN",
                      width: w / 6,
                      imageProvider:
                          const AssetImage("assets/icons/logo-kejaksaan.png"),
                      smartDeviceColor: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                         Color.fromARGB(255, 34, 68, 87),
                          Color.fromARGB(255, 13, 30, 46),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            MapJamwas(accessToken: accessToken, tahun: tahun2),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: SmartDeviceBoxWidget(
                      smartDeviceName: "JAMWAS",
                      width: w / 6,
                      imageProvider:
                          const AssetImage("assets/icons/logo-kejaksaan.png"),
                      smartDeviceColor: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                         Color.fromARGB(255, 34, 68, 87),
                          Color.fromARGB(255, 13, 30, 46),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => MapJampidmil(
                              accessToken: accessToken, tahun: tahun2)),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(1),
                    child: SmartDeviceBoxWidget(
                      width: w / 6,
                      smartDeviceName: "JAMPIDMIL",
                      imageProvider:
                          const AssetImage("assets/icons/logo-kejaksaan.png"),
                      smartDeviceColor: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                         Color.fromARGB(255, 34, 68, 87),
                          Color.fromARGB(255, 13, 30, 46),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : loaderDialog(context),
    );
  }
}
