import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../widget/room_widget.dart';
import '../../../shared_components/chart/chart_indicator.dart';

class DetailSilabinPage extends StatefulWidget {
  const DetailSilabinPage({super.key});

  @override
  State<DetailSilabinPage> createState() => _DetailSilabinPageState();
}

class _DetailSilabinPageState extends State<DetailSilabinPage> {
  int touchedIndexBpk = -1;
  int touchedIndex = -1;
  int touchedGroupIndex = -1;

  // int touchedIndex = -1;
  // int touchedGroupIndex = -1;
  int value1 = 0;
  int value2 = 0;
  int value3 = 0;
  int value4 = 0;
  int value5 = 0;
  int value6 = 0;
  int value7 = 0;
  int value8 = 0;
  int value9 = 0;
  int value10 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 30, 46),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: clrSecondary,
        ),
        title: const Row(
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
                  "SILABIN",
                  style: TextStyle(color: Colors.white),
                ),
                Text(
                  "SETBIN - JAMBIN",
                  style: TextStyle(color: clrEdit, fontSize: 12),
                ),
              ],
            ),
            SizedBox(
              width: 5,
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Periode Tahun 2023",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            RoomContainer(
                                onTap: () {},
                                title: "Satuan Kerja",
                                colorIcon: clrWait,
                                count: "1"),
                            RoomContainer(
                                onTap: () {},
                                title: "Laporan (Form)",
                                colorIcon: clrBadge,
                                count: "46"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 5, right: 5),
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
                    height: 270,
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Jenis Kelamin',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ( Periode - 2023 )',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 40),
                                  width: 350,
                                  height: 150,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                            pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (FlTouchEvent event,
                                                      pieTouchResponse) {
                                                setState(() {
                                                  if (!event
                                                          .isInterestedForInteractions ||
                                                      pieTouchResponse ==
                                                          null ||
                                                      pieTouchResponse
                                                              .touchedSection ==
                                                          null) {
                                                    touchedIndexBpk = -1;
                                                    return;
                                                  }
                                                  touchedIndexBpk =
                                                      pieTouchResponse
                                                          .touchedSection!
                                                          .touchedSectionIndex;
                                                });
                                              },
                                            ),
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            sectionsSpace: 5,
                                            centerSpaceRadius: 15,
                                            sections:
                                                showingSections(value1, value2),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Indicator(
                                              color: clrPrimary,
                                              text: "Perempuan",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrBadge,
                                              text: "Laki - laki",
                                              isSquare: true,
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                // Container(
                                //   padding:
                                //       const EdgeInsets.only(left: 8, top: 8),
                                //   width: 350,
                                //   height: 150,
                                //   child: Row(
                                //     children: <Widget>[
                                //       Expanded(
                                //         child: PieChart(
                                //           PieChartData(
                                //             pieTouchData: PieTouchData(
                                //               touchCallback:
                                //                   (FlTouchEvent event,
                                //                       pieTouchResponse) {
                                //                 setState(() {
                                //                   if (!event
                                //                           .isInterestedForInteractions ||
                                //                       pieTouchResponse ==
                                //                           null ||
                                //                       pieTouchResponse
                                //                               .touchedSection ==
                                //                           null) {
                                //                     touchedIndex = -1;
                                //                     return;
                                //                   }
                                //                   touchedIndex =
                                //                       pieTouchResponse
                                //                           .touchedSection!
                                //                           .touchedSectionIndex;
                                //                 });
                                //               },
                                //             ),
                                //             startDegreeOffset: 100,
                                //             borderData: FlBorderData(
                                //               show: false,
                                //             ),
                                //             sectionsSpace: 1,
                                //             centerSpaceRadius: 0,
                                //             sections:
                                //                 showingSections(value1, value2),
                                //           ),
                                //         ),
                                //       ),
                                //       const Padding(
                                //         padding: EdgeInsets.all(10),
                                //         child: Column(
                                //           mainAxisAlignment:
                                //               MainAxisAlignment.center,
                                //           crossAxisAlignment:
                                //               CrossAxisAlignment.start,
                                //           children: <Widget>[
                                //             Indicator(
                                //               color: clrPrimary,
                                //               text: "Perempuan",
                                //               isSquare: true,
                                //             ),
                                //             SizedBox(
                                //               height: 4,
                                //             ),
                                //             Indicator(
                                //               color: clrBadge,
                                //               text: "Laki - laki",
                                //               isSquare: true,
                                //             ),
                                //             SizedBox(
                                //               height: 4,
                                //             ),
                                //           ],
                                //         ),
                                //       )
                                //     ],
                                //   ),
                                // ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 5, right: 5),
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
                    height: 230,
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Usia Pegawai',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ( Periode - 2023 )',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  width: 350,
                                  height: 150,
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: PieChart(
                                          PieChartData(
                                            pieTouchData: PieTouchData(
                                              touchCallback:
                                                  (FlTouchEvent event,
                                                      pieTouchResponse) {
                                                setState(() {
                                                  if (!event
                                                          .isInterestedForInteractions ||
                                                      pieTouchResponse ==
                                                          null ||
                                                      pieTouchResponse
                                                              .touchedSection ==
                                                          null) {
                                                    touchedIndexBpk = -1;
                                                    return;
                                                  }
                                                  touchedIndexBpk =
                                                      pieTouchResponse
                                                          .touchedSection!
                                                          .touchedSectionIndex;
                                                });
                                              },
                                            ),
                                            borderData: FlBorderData(
                                              show: false,
                                            ),
                                            sectionsSpace: 5,
                                            centerSpaceRadius: 8,
                                            sections: showingSections1(value1,
                                                value2, value3, value4, value5),
                                          ),
                                        ),
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Indicator(
                                              color: clrPrimary,
                                              text: "20-25",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrBadge,
                                              text: ">55",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrEdit,
                                              text: "36-45",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrDelete,
                                              text: "46-55",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrWait,
                                              text: "26-35",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrPink,
                                              text: "Tidak Ada",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      )
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
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 5, right: 5),
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
                    height: 400,
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Pangkat',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ( Periode - 2023 )',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  width: 350,
                                  height: 325,
                                  child: Column(
                                    children: <Widget>[
                                         Expanded(
                                          child: PieChart(
                                            PieChartData(
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndexBpk = -1;
                                                      return;
                                                    }
                                                    touchedIndexBpk =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 5,
                                              centerSpaceRadius: 8,
                                              sections: showingSections3(
                                                  value1,
                                                  value2,
                                                  value3,
                                                  value4,
                                                  value5,
                                                  value6,
                                                  value7,
                                                  value8,
                                                  value9),
                                            ),
                                          ),
                                        ),
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Indicator(
                                              color: clrWait,
                                              text:
                                                  "Jaksa Fungsional Kejaksaan Tinggi: 1641",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrDelete,
                                              text:
                                                  "Pengolah Data Perkara Dan Putusan: 466",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrBadge,
                                              text:
                                                  "Pegawai Tahanan dan Narapidana 1133",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: Colors.greenAccent,
                                              text: "Analis Penuntunan 1005",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: Colors.limeAccent,
                                              text:
                                                  "Jaksa Fungsional Kejaksaan Tinggi: 1641",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrPink,
                                              text: "Pranatan Barang Bukti 542",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrSecondary,
                                              text: "Fungsional Pranta Komputer Pertama",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      )
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
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 5, right: 5),
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
                    height: 400,
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Pangkat',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ( Periode - 2023 )',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  width: 350,
                                  height: 325,
                                  child: Column(
                                    children: <Widget>[
                                        Expanded(
                                          child: PieChart(
                                            PieChartData(
                                              pieTouchData: PieTouchData(
                                                touchCallback:
                                                    (FlTouchEvent event,
                                                        pieTouchResponse) {
                                                  setState(() {
                                                    if (!event
                                                            .isInterestedForInteractions ||
                                                        pieTouchResponse ==
                                                            null ||
                                                        pieTouchResponse
                                                                .touchedSection ==
                                                            null) {
                                                      touchedIndexBpk = -1;
                                                      return;
                                                    }
                                                    touchedIndexBpk =
                                                        pieTouchResponse
                                                            .touchedSection!
                                                            .touchedSectionIndex;
                                                  });
                                                },
                                              ),
                                              borderData: FlBorderData(
                                                show: false,
                                              ),
                                              sectionsSpace: 5,
                                              centerSpaceRadius: 8,
                                              sections: showingSections3(
                                                  value1,
                                                  value2,
                                                  value3,
                                                  value4,
                                                  value5,
                                                  value6,
                                                  value7,
                                                  value8,
                                                  value9),
                                            ),
                                          ),
                                        ),
                                      
                                      const Padding(
                                        padding: EdgeInsets.all(8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Indicator(
                                              color: clrWait,
                                              text:
                                                  "Jaksa Fungsional Kejaksaan Tinggi: 1641",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrDelete,
                                              text:
                                                  "Pengolah Data Perkara Dan Putusan: 466",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrBadge,
                                              text:
                                                  "Pegawai Tahanan dan Narapidana 1133",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: Colors.greenAccent,
                                              text: "Analis Penuntunan 1005",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: Colors.limeAccent,
                                              text:
                                                  "Jaksa Fungsional Kejaksaan Tinggi: 1641",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrPink,
                                              text: "Pranatan Barang Bukti 542",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                            Indicator(
                                              color: clrSecondary,
                                              text: "Fungsional Pranta Komputer Pertama",
                                              isSquare: true,
                                            ),
                                            SizedBox(
                                              height: 4,
                                            ),
                                          ],
                                        ),
                                      )
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
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
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
                height: MediaQuery.of(context).size.width * 0.58,
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
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pendidikan',
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
                              padding: const EdgeInsets.only(top: 5, left: 8),
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData,
                                  borderData: borderData,
                                  barGroups: barGroups,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceBetween,
                                  maxY: 10000,
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
                height: MediaQuery.of(context).size.width * 0.58,
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
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rekap Izin Cuti',
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
                              padding: const EdgeInsets.only(top: 5),
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData1,
                                  borderData: borderData,
                                  barGroups: barGroups1,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceBetween,
                                  maxY: 3500,
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
                height: MediaQuery.of(context).size.width * 0.58,
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
                              width: 340,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Penggunaan Energi',
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
                              padding: const EdgeInsets.only(top: 5),
                              width: MediaQuery.of(context).size.width * 0.85,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData2,
                                  borderData: borderData,
                                  barGroups: barGroups2,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceBetween,
                                  maxY: 30000000,
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
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(val1, val2) {
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = clrPrimary;
        const color1 = clrBadge;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: val1 == 0 ? 1.0 : val1.toDouble(),
              title: 'Perempuan (9362)',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(
                      color: Colors.white.withOpacity(0),
                    ),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: val2 == 0 ? 1.0 : val2.toDouble(),
              title: 'Laki - Laki (16327)',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }

  List<PieChartSectionData> showingSections1(val1, val2, val3, val4, val5) {
    return List.generate(
      5,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = clrPrimary;
        const color1 = clrBadge;
        const color2 = clrEdit;
        const color3 = clrDelete;
        const color4 = clrWait;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: val1 == 0 ? 0.5 : val1.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(
                      color: Colors.white.withOpacity(0),
                    ),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: val2 == 0 ? 0.3 : val2.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: val2 == 0 ? 2.0 : val2.toDouble(),
              title: 'Jumlah 7872',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: val2 == 0 ? 1.0 : val2.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 4:
            return PieChartSectionData(
              color: color4,
              value: val2 == 0 ? 3.0 : val2.toDouble(),
              title: 'Jumlah 8272',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }

  List<PieChartSectionData> showingSections2(
      val1, val2, val3, val4, val5, val6, val7, val8, val9, val10) {
    return List.generate(
      10,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = clrPrimary;
        const color1 = clrBadge;
        const color2 = clrEdit;
        const color3 = clrDelete;
        const color4 = clrWait;
        const color5 = clrPink;
        const color6 = clrSecondary;
        const color7 = Colors.greenAccent;
        const color8 = Colors.limeAccent;
        const color9 = Colors.brown;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: val1 == 0 ? 0.5 : val1.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(
                      color: Colors.white.withOpacity(0),
                    ),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: val2 == 0 ? 0.3 : val2.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: val2 == 0 ? 2.0 : val2.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: val2 == 0 ? 1.0 : val2.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 4:
            return PieChartSectionData(
              color: color4,
              value: val2 == 0 ? 3.0 : val2.toDouble(),
              title: 'Jabatan Fungsional Kejaksaan Negeri Jumlah 1945',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 5:
            return PieChartSectionData(
              color: color5,
              value: val1 == 0 ? 0.5 : val1.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(
                      color: Colors.white.withOpacity(0),
                    ),
            );
          case 6:
            return PieChartSectionData(
              color: color6,
              value: val2 == 0 ? 0.3 : val2.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 7:
            return PieChartSectionData(
              color: color7,
              value: val2 == 0 ? 2.0 : val2.toDouble(),
              title: 'Jumlah 7872',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 8:
            return PieChartSectionData(
              color: color8,
              value: val2 == 0 ? 1.0 : val2.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 9:
            return PieChartSectionData(
              color: color9,
              value: val2 == 0 ? 3.0 : val2.toDouble(),
              title: 'Jabatan Fungsional Kejaksaan Negeri Jumlah 1641',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
    );
  }

  List<PieChartSectionData> showingSections3(
      val1, val2, val3, val4, val5, val6, val7, val8, val9) {
    return List.generate(
      9,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = clrPrimary;
        const color1 = clrBadge;
        const color2 = clrEdit;
        const color3 = clrDelete;
        const color4 = clrWait;
        const color5 = clrPink;
        const color6 = clrSecondary;
        const color7 = Colors.greenAccent;
        const color8 = Colors.limeAccent;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: val1 == 0 ? 0.5 : val1.toDouble(),
              title: '7872',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(
                      color: Colors.white.withOpacity(0),
                    ),
            );
          case 1:
            return PieChartSectionData(
              color: color1,
              value: val2 == 0 ? 0.3 : val2.toDouble(),
              title: '2790',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 2:
            return PieChartSectionData(
              color: color2,
              value: val2 == 0 ? 2.0 : val2.toDouble(),
              title: '700',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 3:
            return PieChartSectionData(
              color: color3,
              value: val2 == 0 ? 1.0 : val2.toDouble(),
              title: '466',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 4:
            return PieChartSectionData(
              color: color4,
              value: val2 == 0 ? 3.0 : val2.toDouble(),
              title: '1641',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 5:
            return PieChartSectionData(
              color: color5,
              value: val1 == 0 ? 0.5 : val1.toDouble(),
              title: '542',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.55,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(
                      color: Colors.white.withOpacity(0),
                    ),
            );
          case 6:
            return PieChartSectionData(
              color: color6,
              value: val2 == 0 ? 0.3 : val2.toDouble(),
              title: '',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 7:
            return PieChartSectionData(
              color: color7,
              value: val2 == 0 ? 2.0 : val2.toDouble(),
              title: '1005',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          case 8:
            return PieChartSectionData(
              color: color8,
              value: val2 == 0 ? 1.0 : val2.toDouble(),
              title: '988',
              titleStyle: const TextStyle(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
              radius: 80,
              titlePositionPercentageOffset: 0.35,
              borderSide: isTouched
                  ? const BorderSide(color: Colors.white, width: 6)
                  : BorderSide(color: Colors.white.withOpacity(0)),
            );
          default:
            throw Error();
        }
      },
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
              reservedSize: 25,
              interval: 2000,
              getTitlesWidget: leftTitleWidgets),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlTitlesData get titlesData1 => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            // getTitlesWidget: bottomTitles,
            getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 25,
              interval: 500,
              getTitlesWidget: leftTitleWidgets),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlTitlesData get titlesData2 => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            // getTitlesWidget: bottomTitles,
            getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 25,
              interval: 5000000,
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
      'Sarjana Hukum',
      'SLTA Umum',
      'Magister Hukum',
      'D3',
      'S1',
      'SLTA Kejuruan',
      'S2',
      'Pidana Hukum',
      'SMA',
      'Perdata',
      'Sarjana Hukum',
      'Sarjana Ekonomi Umum'
          'Sarjana Teknik Informatika'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w400,
        fontSize: 5,
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
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = "Januari";
        break;
      case 1:
        label = "Februari";
        break;
      case 2:
        label = "Maret";
        break;
      case 3:
        label = "April";
        break;
      case 4:
        label = "Mei";
        break;
      case 5:
        label = "Juni";
        break;
      case 6:
        label = "Juli";
        break;
      case 7:
        label = "Agustus";
        break;
      case 8:
        label = "September";
        break;
      case 9:
        label = "Oktober";
        break;
      case 10:
        label = "November";
        break;
      case 11:
        label = "Desember";
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
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 9419,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 4779,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 3017,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 2276,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 733,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 676,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 407,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: 309,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: 293,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: 227,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              toY: 218,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              toY: 191,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  List<BarChartGroupData> get barGroups1 => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 3049,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 1929,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 1781,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 1775,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 1707,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 1683,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 1673,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: 1652,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: 1241,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: 1202,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              toY: 692,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              toY: 27,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  List<BarChartGroupData> get barGroups2 => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 4000000,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 11000000,
              color: clrPrimary,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 10500000,
              color: clrBadge,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 6900000,
              color: clrDelete,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 7800000,
              color: clrTitle,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 4700000,
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        
      ];
}
