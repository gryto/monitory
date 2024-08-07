import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import 'package:badges/badges.dart' as badges;

class DetailEtilangPage extends StatelessWidget {
  const DetailEtilangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 30, 46),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Align(
          alignment: Alignment.topLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: Image(
                  image: AssetImage(
                    "assets/icons/JAMBIN_logo.png",
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
                    "e-TILANG",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "BIRO KEUANGAN - JAMBIN",
                    style: TextStyle(color: clrEdit, fontSize: 12),
                  ),
                ],
              ),
              SizedBox(
                width: 5,
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 0, right: 5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 34, 68, 87),
                      Color.fromARGB(255, 13, 30, 46),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(255, 23, 56, 82),
                      blurRadius: 1.0,
                      spreadRadius: 0.5,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                height: MediaQuery.of(context).size.width * 0.68,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Statistik Putusan Perkara Tilang',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '( Periode -  2023 )',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 11,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 0, left: 0),
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData,
                                  borderData: borderData,
                                  barGroups: barGroups,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY: 800000,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15, right: 0),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 34, 68, 87),
                                      Color.fromARGB(255, 13, 30, 46),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 23, 56, 82),
                                      blurRadius: 1.0,
                                      spreadRadius: 0.5,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                height: 310,
                                width: 240,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Text(
                                                  'Perkara',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            SizedBox(
                                              height: 220,
                                              width: 210,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Jumlah : Rp. 1.811.042",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Diselesaikan",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      badges.Badge(
                                                        badgeStyle:
                                                            badges.BadgeStyle(
                                                          shape: badges
                                                              .BadgeShape
                                                              .square,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          badgeColor: clrWait,
                                                        ),
                                                        position:
                                                            badges.BadgePosition
                                                                .custom(
                                                                    start: 10,
                                                                    top: 10),
                                                        badgeContent:
                                                            const Text(
                                                          "Sebelum",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text(
                                                        "sidang",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                      "Dibayar: Rp. 541.968",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Disetor: Rp. 523.964",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Diselesaikan",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      badges.Badge(
                                                        badgeStyle:
                                                            badges.BadgeStyle(
                                                          shape: badges
                                                              .BadgeShape
                                                              .square,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          badgeColor: clrDelete,
                                                        ),
                                                        position:
                                                            badges.BadgePosition
                                                                .custom(
                                                                    start: 10,
                                                                    top: 10),
                                                        badgeContent:
                                                            const Text(
                                                          "Setelah",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text(
                                                        "sidang",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text("Rp. 541.968",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text(
                                                      "Sisa: Rp. 400.617",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15, right: 0),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 34, 68, 87),
                                      Color.fromARGB(255, 13, 30, 46),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 23, 56, 82),
                                      blurRadius: 1.0,
                                      spreadRadius: 0.5,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                height: 310,
                                width: 240,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Text(
                                                  'Denda',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            SizedBox(
                                              height: 220,
                                              width: 210,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Jumlah : Rp. 193.973.298.449",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Diselesaikan",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      badges.Badge(
                                                        badgeStyle:
                                                            badges.BadgeStyle(
                                                          shape: badges
                                                              .BadgeShape
                                                              .square,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          badgeColor: clrWait,
                                                        ),
                                                        position:
                                                            badges.BadgePosition
                                                                .custom(
                                                                    start: 10,
                                                                    top: 10),
                                                        badgeContent:
                                                            const Text(
                                                          "Sebelum",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text(
                                                        "sidang",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                      "Dibayar: Rp. 64.563.404.600",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Disetor: Rp. 62.501.510.100",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Diselesaikan",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      badges.Badge(
                                                        badgeStyle:
                                                            badges.BadgeStyle(
                                                          shape: badges
                                                              .BadgeShape
                                                              .square,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          badgeColor: clrDelete,
                                                        ),
                                                        position:
                                                            badges.BadgePosition
                                                                .custom(
                                                                    start: 10,
                                                                    top: 10),
                                                        badgeContent:
                                                            const Text(
                                                          "Setelah",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text(
                                                        "sidang",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                      "Rp. 87.181.797.200",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text(
                                                      "Sisa: Rp. 44.289.991.149",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5),
                              child: Container(
                                padding: const EdgeInsets.only(
                                    top: 15, bottom: 15, left: 15, right: 0),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 34, 68, 87),
                                      Color.fromARGB(255, 13, 30, 46),
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromARGB(255, 23, 56, 82),
                                      blurRadius: 1.0,
                                      spreadRadius: 0.5,
                                      offset: Offset(1, 1),
                                    ),
                                  ],
                                ),
                                height: 310,
                                width: 240,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Text(
                                                  'Ongkos Perkara',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            SizedBox(
                                              height: 220,
                                              width: 210,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Jumlah : Rp. 1.913.879.001",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Diselesaikan",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      badges.Badge(
                                                        badgeStyle:
                                                            badges.BadgeStyle(
                                                          shape: badges
                                                              .BadgeShape
                                                              .square,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          badgeColor: clrWait,
                                                        ),
                                                        position:
                                                            badges.BadgePosition
                                                                .custom(
                                                                    start: 10,
                                                                    top: 10),
                                                        badgeContent:
                                                            const Text(
                                                          "Sebelum",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text(
                                                        "sidang",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text(
                                                      "Dibayar: Rp. 575.608.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Disetor: Rp. 556.138.500",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Diselesaikan",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      badges.Badge(
                                                        badgeStyle:
                                                            badges.BadgeStyle(
                                                          shape: badges
                                                              .BadgeShape
                                                              .square,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          badgeColor: clrDelete,
                                                        ),
                                                        position:
                                                            badges.BadgePosition
                                                                .custom(
                                                                    start: 10,
                                                                    top: 10),
                                                        badgeContent:
                                                            const Text(
                                                          "Setelah",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      const Text(
                                                        "sidang",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                    ],
                                                  ),
                                                  const Text("Rp. 932.595.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text(
                                                      "Sisa: Rp. 425.145.501",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    contentPadding:
                        const EdgeInsets.only(left: 5.0, right: 5.0),
                    title: const Text(
                      "Satker: 2",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15,
                        ),
                        const Text(
                          "Putusan",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jumlah",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "3",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Denda",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "4",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Biaya Perkara",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "5",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Diselesaikan sebelum sidang jumlah titipan setor",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.square,
                                borderRadius: BorderRadius.circular(5),
                                badgeColor: clrEdit,
                              ),
                              position: badges.BadgePosition.custom(
                                  start: 10, top: 10),
                              badgeContent: const Text(
                                "JUMLAH TITIPAN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.square,
                                borderRadius: BorderRadius.circular(5),
                                badgeColor: clrBadge,
                              ),
                              position: badges.BadgePosition.custom(
                                  start: 10, top: 10),
                              badgeContent: const Text(
                                "DISETOR",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jumlah",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "6",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Denda",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "7",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Biaya Perkara",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "8",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Diselesaikan setelah sidang jumlah non titipan setor",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.square,
                                borderRadius: BorderRadius.circular(5),
                                badgeColor: clrDelete,
                              ),
                              position: badges.BadgePosition.custom(
                                  start: 10, top: 10),
                              badgeContent: const Text(
                                "JUMLAH NON TITIPAN",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.square,
                                borderRadius: BorderRadius.circular(5),
                                badgeColor: clrBadge,
                              ),
                              position: badges.BadgePosition.custom(
                                  start: 10, top: 10),
                              badgeContent: const Text(
                                "DISETOR",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jumlah",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "9",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Denda",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "10",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Biaya Perkara",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "11",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Total diselesaikan/Sisa Total Disetor Sisa",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        Row(
                          children: [
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.square,
                                borderRadius: BorderRadius.circular(5),
                                badgeColor: clrBadge,
                              ),
                              position: badges.BadgePosition.custom(
                                  start: 10, top: 10),
                              badgeContent: const Text(
                                "TOTAL DISETOR",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(width: 5,),
                            badges.Badge(
                              badgeStyle: badges.BadgeStyle(
                                shape: badges.BadgeShape.square,
                                borderRadius: BorderRadius.circular(5),
                                badgeColor: clrDelete,
                              ),
                              position: badges.BadgePosition.custom(
                                  start: 10, top: 10),
                              badgeContent: const Text(
                                "SISA",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Jumlah",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "12",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Denda",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "13",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Biaya Perkara",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "14",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 1,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: bottomTitles,
            // getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              interval: 200000,
              getTitlesWidget: leftTitleWidgets),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      'KT.ACEH',
      'KT.SUMATERA UTARA',
      'KT.SUMATERA BARAT',
      'KT. RIAU',
      'KT. JAMBI',
      'KT. SUMATERA SELATAN',
      'KT. BENGKULU',
      'KT. LAMPUNG',
      'KT. DKI JAKARTA',
      'KT. JAWA BARAT',
      'KT. JAWA TENGAH',
      'KT. D.I YOGYAKARTA',
      'KT.ACEH',
      'KT.SUMATERA UTARA',
      'KT.SUMATERA BARAT',
      'KT. RIAU',
      'KT. JAMBI',
      'KT. SUMATERA SELATAN',
      'KT. BENGKULU',
      'KT. LAMPUNG',
      'KT. DKI JAKARTA',
      'KT. JAWA BARAT',
      'KT. JAWA TENGAH',
      'KT. D.I YOGYAKARTA'
    ];

    final Widget text = SizedBox(
      height: 20,
      width: 20,
      child: Text(
        titles[value.toInt()],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 4,
        ),
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  Widget bottomtitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = "KT.ACEH";
        break;
      case 1:
        label = "KT.SUMATERA UTARA";
        break;
      case 2:
        label = "KT.SUMATERA BARAT";
        break;
      case 3:
        label = "KT. RIAU";
        break;
      case 4:
        label = "KT. JAMBI";
        break;
      case 5:
        label = "KT. SUMATERA SELATAN";
        break;
      case 6:
        label = "KT. BENGKULU";
        break;
      case 7:
        label = "KT. LAMPUNG";
        break;
      case 8:
        label = "KT. DKI JAKARTA";
        break;
      case 9:
        label = "KT. JAWA BARAT";
        break;
      case 10:
        label = "KT. JAWA TENGAH";
        break;
      case 11:
        label = "KT. D.I YOGYAKARTA";
        break;
    }

    Widget text;
    text = Text(label, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 6,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(meta.formattedValue, style: style),
    );
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          barsSpace: 1,
          x: 0,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 406292,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 406292,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 60000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 60000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 107000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 107000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 683000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 683000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 27500,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 27500,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 14500,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 14500,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 406292,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 406292,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 260000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 260000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 107000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 107000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 68300,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 68300,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 27500,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 27500,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 14500,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 14500,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 12,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 406292,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 406292,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 13,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 260000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 260000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 14,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 107000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 107000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 15,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 68300,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 68300,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 16,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 27500,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 27500,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 17,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 14500,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 14500,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 18,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 406292,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 406292,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 19,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 260000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 260000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 20,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 107000,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 107000,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 21,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 68300,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 68300,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 22,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 27500,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 27500,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 23,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 14500,
              color: clrPink,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 14500,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
