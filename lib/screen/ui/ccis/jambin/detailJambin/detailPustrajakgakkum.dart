import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/dialog_info.dart';
import 'detailPustrajakgakkum/detailEjurnal.dart';
import 'detailSetJanbin.dart';

class DetailPustrajakgakkumPage extends StatefulWidget {
  const DetailPustrajakgakkumPage({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailPustrajakgakkumPageState createState() =>
      _DetailPustrajakgakkumPageState();
}

class _DetailPustrajakgakkumPageState extends State<DetailPustrajakgakkumPage> {
  late Widget body;
  String title = "PUSTRAJAKGAKKUM";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";
  bool isProcess = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  dispose() {
    super.dispose();
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
                      "assets/icons/JAMBIN_logo.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgets,
                    const Text(
                      "JAMBIN",
                      style: TextStyle(color: clrEdit, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
      ),
      body: pustrajagakkum()
    );
  }

  Widget pustrajagakkum() {
    List<Location> locations = [
      Location(
        address: "e-JURNAL",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 73, 68, 18),
            Color.fromARGB(255, 158, 146, 42),
            Color.fromARGB(255, 235, 233, 125),
          ],
        ),
        state: "",
        imagePath: "assets/icons/logo-kejaksaan.png",
      ),
      // Location(
      //   address: "E-MAKALAH",
      //   color: const LinearGradient(
      //     begin: Alignment.topLeft,
      //     end: Alignment.bottomRight,
      //     colors: [
      //       Color.fromARGB(255, 73, 68, 18),
      //       Color.fromARGB(255, 158, 146, 42),
      //       Color.fromARGB(255, 235, 233, 125),
      //     ],
      //   ),
      //   state: "",
      //   imagePath: "assets/icons/logo-kejaksaan.png",
      // ),
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
                    builder: (context) => const DetailEjurnalPage(),
                  ),
                );
              } 
              // else if (index == 1) {
              //   Navigator.of(context).push(
              //     MaterialPageRoute(
              //       builder: (context) => const DetailEmakalahPage(),
              //     ),
              //   );
              // } 
              else {
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
                                color: Colors.white,
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
