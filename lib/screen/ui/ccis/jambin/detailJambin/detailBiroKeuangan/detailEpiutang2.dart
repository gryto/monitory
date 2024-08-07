import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import 'package:badges/badges.dart' as badges;

class DetailEpiutang2Page extends StatelessWidget {
  const DetailEpiutang2Page({super.key});

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
                    "E-PIUTANG",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "BIRO KEUANGAN - JAMBIN",
                    style: TextStyle(color: clrEdit, fontSize: 12),
                  ),
                  Text(
                    "Dashboard Uang Pengganti Pidana Khusus",
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
                                        'Statistik Piutang Tahun 2024',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
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
                            SizedBox(
                              height: 20,
                              width: 350,
                              // width:  MediaQuery.of(context).size.width * 0.82,
                              // height: MediaQuery.of(context).size.height * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration:
                                            const BoxDecoration(color: clrWait),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Saldo Awal",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration:
                                            const BoxDecoration(color: clrPink),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Saldo Akhir",
                                          style:
                                              TextStyle(color: Colors.white)),
                                    ],
                                  ),
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
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: clrSecondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  badges.Badge(
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.square,
                      borderRadius: BorderRadius.circular(5),
                      badgeColor: clrPink,
                    ),
                    position: badges.BadgePosition.custom(start: 10, top: 10),
                    badgeContent: const Text(
                      "DKI Jakarta",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Expanded(
                    child: Text(
                      "Saldo awal : Rp. 36.618.848.633.103 | Mutasi tambah : Rp. 2.000.000.000 | Mutasi kurang : Rp. 0 | Saldo akhir : Rp. 36.620.848.633.103",
                      style: TextStyle(color: clrPrimary),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: clrPink),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Saldo Awal",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "IDR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "43.390.374.920.982,25",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "USD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "194.743.570,50",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SGD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "EUR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "20.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Tambah",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "IDR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "43.390.374.920.982,25",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "USD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "194.743.570,50",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SGD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "EUR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "20.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Kurang",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "IDR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "43.390.374.920.982,25",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "USD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "194.743.570,50",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SGD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "EUR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "20.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Total diselesaikan/Sisa Total Disetor Sisa",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "IDR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "43.390.374.920.982,25",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "USD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "194.743.570,50",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SGD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "EUR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "20.000",
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
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 360,
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
                                height: 300,
                                width: 255,
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
                                                  'KT. ACEH',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : Rp. 1.811.042",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text("Perkara Baru : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 60.000.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 461.705.299",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 87.764.558.305",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. SUMATERA UTARA',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : Rp. 2.938.556",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang : ",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text("Perkara Baru : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 2.938.556",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. SUMATERA UTARA',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : Rp. 681.988.695.617",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Perkara Baru : 691.627.885",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Koreksi(+): 27.590.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 260.132.626",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 682.447.780.876",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. SUMATERA BARAT',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : Rp. 108.153.678.143",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text("Perkara Baru : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 108.153.678.143",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. RIAU',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : Rp. 432.111.950.148",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text("Perkara Baru : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 432.111.950.148",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. JAMBI',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : Rp. 113.552.062.801",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text("Perkara Baru : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 113.552.062.801",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. SUMATERA SELATAN',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : Rp. 225.478.836.247,12",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Perkara Baru : 375.052.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 153.000.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 225.478.836.247,12",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. BENGKULU',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : 59.698.159.165",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text("Perkara Baru : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 105.500.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 59.698.159.165",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. LAMPUNG',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : 159.538.272.535",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Perkara Baru : 2.455.345.433",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 229.515.232",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Koreksi(+): 42.500.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 161.721.602.736",
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
                                height: 300,
                                width: 255,
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
                                                  'KT. DKI JAKARTA',
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
                                              height: 280,
                                              width: 240,
                                              // width:  MediaQuery.of(context).size.width * 0.82,
                                              // height: MediaQuery.of(context).size.height * 0.02,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const Text(
                                                      "Saldo Awal : 20.000",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text("Mata Uang :",
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
                                                          "IDR",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Tambah",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text("Perkara Baru : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  const Text("Mutasi Kurang",
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w800)),
                                                  const Text(
                                                      "Setor ke kas negara : 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text("Koreksi(+): 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Menjalani Subsider: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  const Text("Lain - lain: 0",
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                  const Text(
                                                      "Saldo Akhir: 20.000",
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
            const SizedBox(
              height: 5,
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: clrWait),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Total IDR",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saldo Awal",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "43.390.374.920.982,25",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Tambah",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Perkara Baru",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "140.627.698.553,03",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Koreksi(+)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "27.590.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Kurang",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Setor ke kas negara",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "1.431.308.858",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "koreksi(-)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "1.794.549.200",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Menjalani subsider",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "3.637.630.284",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lain - lain",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "1",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saldo Akhir",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "43.524.166.721.192,28",
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
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: clrWait),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Total IDR",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saldo Awal",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "194.743.570,5",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Tambah",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Perkara Baru",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Koreksi(+)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Kurang",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Setor ke kas negara",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "koreksi(-)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Menjalani subsider",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lain - lain",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saldo Akhir",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "194.743.570,5",
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
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: clrWait),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Total IDR",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saldo Awal",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Tambah",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Perkara Baru",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Koreksi(+)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Kurang",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Setor ke kas negara",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "koreksi(-)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Menjalani subsider",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lain - lain",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saldo Akhir",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "0",
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
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: clrWait),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Total IDR",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saldo Awal",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "20.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Tambah",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Perkara Baru",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Koreksi(+)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Mutasi Kurang",
                          style: TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Setor ke kas negara",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "koreksi(-)",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Menjalani subsider",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Lain - lain",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Saldo Akhir",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "20.000",
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
