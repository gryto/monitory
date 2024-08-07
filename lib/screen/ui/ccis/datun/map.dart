import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../src/constant.dart';
import '../../../../src/dialog_info.dart';
import '../../../../src/logout.dart';
import 'detailEcms.dart';
import 'detail_jamdatun.dart';

class DetailDatun extends StatefulWidget {
  final String accessToken, tahun;

  const DetailDatun({Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailDatun> createState() => _DetailDatunState();
}

class _DetailDatunState extends State<DetailDatun> {
  String title = "JAMDATUN";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";
  late final PlatformWebViewControllerCreationParams params;

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
          fontSize: 16,
          color: Colors.orange,
          fontWeight: FontWeight.w500,
        ),
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
        address: "Halo JPN",
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
        imagePath: "assets/icons/logo-jpn.png",
      ),
      Location(
        address: "e-CMS",
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
        imagePath: "assets/icons/logo-kejaksaan.png",
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
                    builder: (context) => DetailDatunIsi(
                      accessToken: widget.accessToken,
                      tahun: widget.tahun,
                    ),
                  ),
                );
              } else if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailEcmsPage(accessToken: widget.accessToken,),
                  ),
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
                          scale: 8,
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
                                color: Colors.orange,
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
