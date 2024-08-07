import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';

class DetailEpiutang5Page extends StatelessWidget {
  const DetailEpiutang5Page({super.key});

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
                width: 8,
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
                    "Dashboard Piutang Tuntutan Perbendaharaan dan Tuntutan Ganti Rugi",
                    style: TextStyle(color: clrEdit, fontSize: 8),
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
                              "RP.",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "6.277.493.455.680",
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
                              "RP",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "99.758.800",
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
                              "RP.",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "20.500.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Saldo Akhir",
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
                              "6.277.572.714.480",
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
