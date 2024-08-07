import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/dialog_info.dart';
import 'detailBiroPerlengkapan/detailLpse.dart';
import 'detailBiroPerlengkapan/detailSimak.dart';
import 'detailBiroPerlengkapan/detailSimpel.dart';
import 'detailSetJanbin.dart';

class DetailBiroPerlengkapanPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailBiroPerlengkapanPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailBiroPerlengkapanPageState createState() =>
      _DetailBiroPerlengkapanPageState();
}

class _DetailBiroPerlengkapanPageState
    extends State<DetailBiroPerlengkapanPage> {
  late Widget body;
  String title = "BIRO PERLENGKAPAN";
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
        body: biroPerlengakapan());
  }

  Widget biroPerlengakapan() {
    List<Location> locations = [
      Location(
        address: "SIMAK/SIMAN BMN",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 73, 68, 18),
            Color.fromARGB(255, 158, 146, 42),
            Color.fromARGB(255, 235, 233, 125),
          ],
        ),
        state: "Barang Milik Negara",
        imagePath: "assets/icons/logo-kejaksaan.png",
      ),
      Location(
        address: "SIMPEL",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 73, 68, 18),
            Color.fromARGB(255, 158, 146, 42),
            Color.fromARGB(255, 235, 233, 125),
          ],
        ),
        state: "Sistem Persuratan Disposisi Elektronik",
        imagePath: "assets/icons/logo-kejaksaan.png",
      ),
      Location(
        address: "LPSE",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 73, 68, 18),
            Color.fromARGB(255, 158, 146, 42),
            Color.fromARGB(255, 235, 233, 125),
          ],
        ),
        state: "Layanan Pengadaan Secara Elektronik",
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
                    builder: (context) => DetailSimakPage(
                      accessToken: widget.accessToken,
                      tahun: widget.tahun,
                    ),
                  ),
                );
              } else if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailSimpelPage(
                      accessToken: widget.accessToken,
                      tahun: widget.tahun,
                    ),
                  ),
                );
              } else if (index == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailLpsePage(),
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

  // Widget jambin() {
  //   return GridView.count(
  //     crossAxisSpacing: 10,
  //     mainAxisSpacing: 10,
  //     crossAxisCount: 2,
  //     children: <Widget>[
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) => const DetailSimakPage(),
  //             ),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.shade300,
  //                 blurRadius: 1.0,
  //                 spreadRadius: 0.5,
  //                 offset: const Offset(1, 1),
  //               ),
  //             ],
  //             borderRadius: BorderRadius.circular(15),
  //             color: Colors.white,
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: const Column(
  //             children: [
  //               SizedBox(height: 20),
  //               Column(
  //                 children: [
  //                   Text(
  //                     'SIMAK/SIMAN BMN',
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                         fontSize: 18,
  //                         color: clrPrimary,
  //                         fontWeight: FontWeight.w700),
  //                   ),
  //                   Text(
  //                     "Barang Milik Negara",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   SizedBox(height: 30),
  //                   Divider(
  //                     height: 2,
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text("Lihat Detail"),
  //                       SizedBox(
  //                         width: 5,
  //                       ),
  //                       Icon(Icons.arrow_circle_right)
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) => const DetailSimpelPage(),
  //             ),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.shade300,
  //                 blurRadius: 1.0,
  //                 spreadRadius: 0.5,
  //                 offset: const Offset(1, 1),
  //               ),
  //             ],
  //             borderRadius: BorderRadius.circular(15),
  //             color: Colors.white,
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: const Column(
  //             children: [
  //               SizedBox(height: 40),
  //               Column(
  //                 children: [
  //                   Text(
  //                     'SIMPEL',
  //                     style: TextStyle(
  //                         fontSize: 18,
  //                         color: clrPrimary,
  //                         fontWeight: FontWeight.w700),
  //                   ),
  //                   SizedBox(height: 60),
  //                   Divider(
  //                     height: 2,
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text("Lihat Detail"),
  //                       SizedBox(
  //                         width: 5,
  //                       ),
  //                       Icon(Icons.arrow_circle_right)
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.of(context).push(
  //             MaterialPageRoute(
  //               builder: (context) => const DetailLpsePage(),
  //             ),
  //           );
  //         },
  //         child: Container(
  //           decoration: BoxDecoration(
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.grey.shade300,
  //                 blurRadius: 1.0,
  //                 spreadRadius: 0.5,
  //                 offset: const Offset(1, 1),
  //               ),
  //             ],
  //             borderRadius: BorderRadius.circular(15),
  //             color: Colors.white,
  //           ),
  //           padding: const EdgeInsets.all(8),
  //           child: const Column(
  //             children: [
  //               SizedBox(height: 20),
  //               Column(
  //                 children: [
  //                   Text(
  //                     'LPSE',
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                         fontSize: 18,
  //                         color: clrPrimary,
  //                         fontWeight: FontWeight.w700),
  //                   ),
  //                   Text(
  //                     "Layanan Pengadaan Secara Elektronik",
  //                     textAlign: TextAlign.center,
  //                     style: TextStyle(
  //                       fontSize: 16,
  //                       fontWeight: FontWeight.w500,
  //                     ),
  //                   ),
  //                   SizedBox(height: 30),
  //                   Divider(
  //                     height: 2,
  //                   ),
  //                   SizedBox(height: 10),
  //                   Row(
  //                     mainAxisAlignment: MainAxisAlignment.center,
  //                     children: [
  //                       Text("Lihat Detail"),
  //                       SizedBox(
  //                         width: 5,
  //                       ),
  //                       Icon(Icons.arrow_circle_right)
  //                     ],
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }
}
