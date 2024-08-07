import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../src/constant.dart';
import '../../../../src/dialog_info.dart';
import '../../../../src/logout.dart';
import '../../../../src/preference.dart';
import 'detailEprowas.dart';
import 'detailSIIGAP.dart';
import 'detailSadap.dart';

class MapJamwas extends StatefulWidget {
  final String accessToken, tahun;
  const MapJamwas({Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<MapJamwas> createState() => _MapJamwasState();
}

class _MapJamwasState extends State<MapJamwas> {
  late final PlatformWebViewControllerCreationParams params;

  late Widget body;
  String title = "JAMWAS";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget widgets;

    widgets = RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: title,
        style: const TextStyle(
            fontSize: 16, fontWeight: FontWeight.w500, color: clrWait),
      ),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 30, 46),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: Image(
                    image: AssetImage(
                      "assets/images/kejaksaan-logo.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                widgets,
              ],
            ),
            GestureDetector(
              onTap: () {
                logoutDialog(context);
              },
              child: const Icon(
                Icons.logout,
                color: clrSecondary,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
      ),
      body: setJambin(),
    );
  }

  Widget setJambin() {
    List<Location> locations = [
      Location(
        address: "SADAP",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 64, 63, 60),
            Color.fromARGB(255, 173, 172, 166),
            Color.fromARGB(255, 235, 235, 233),
          ],
        ),
        state: "",
        imagePath: "assets/icons/sadapp.png",
      ),
      Location(
        address: "SIIGAP",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 64, 63, 60),
            Color.fromARGB(255, 173, 172, 166),
            Color.fromARGB(255, 235, 235, 233),
          ],
        ),
        state: "",
        imagePath: "assets/icons/siigap.png",
      ),
      Location(
        address: "e-PROWAS",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 64, 63, 60),
            Color.fromARGB(255, 173, 172, 166),
            Color.fromARGB(255, 235, 235, 233),
          ],
        ),
        state: "",
        imagePath: "assets/icons/eprowas.png",
      ),
    ];

    return SizedBox(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => DetailSadapPage(
                            accessToken: widget.accessToken,
                            tahun: widget.tahun,
                          )),
                );
              } else if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => DetailSiigapPage(
                            accessToken: widget.accessToken,
                            tahun: widget.tahun,
                          )),
                );
              } else if (index == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => DetailEprowasPage(
                            accessToken: widget.accessToken,
                            tahun: widget.tahun,
                          )),
                );
              } else {
                onBasicAlertPressed(context, "500", "Menu belum dibuat");
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: 250.0,
                decoration: BoxDecoration(
                  gradient: locations[index].color,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(46, 52, 61, 0.42),
                      spreadRadius: 0.5,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: -7.0,
                      top: 0.0,
                      child: Opacity(
                        opacity: 0.7,
                        child: Image.asset(
                          locations[index].imagePath,
                          fit: BoxFit.cover,
                          scale: 25,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: RichText(
                        maxLines: 2,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${locations[index].address} \n",
                              style: const TextStyle(
                                color: clrWait,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                fontSize: 18.0,
                              ),
                            ),
                            TextSpan(
                              text: locations[index].state,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 15.0,
          );
        },
        itemCount: locations.length,
      ),
    );
  }
}

class Location {
  final String address;
  final String state;
  final Gradient color;
  final String imagePath;

  Location({
    required this.address,
    required this.color,
    required this.imagePath,
    required this.state,
  });
}
