import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../widget/room_widget.dart';

class DetailSiladokkumPage extends StatelessWidget {
  const DetailSiladokkumPage({super.key});

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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "SILADOKKUM",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "BIRO HUKUM DAN HUB. LUAR NEGRI - JAMBIN",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: clrEdit, fontSize: 12),
                    ),
                  ],
                ),
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
                                title: "Pidana Umum",
                                colorIcon: clrWait,
                                count: "4"),
                            RoomContainer(
                                onTap: () {},
                                title: "Pidana Khusus",
                                colorIcon: clrBadge,
                                count: "1"),
                            RoomContainer(
                                onTap: () {},
                                title: "Datun",
                                colorIcon: clrDelete,
                                count: "0"),
                            RoomContainer(
                                onTap: () {},
                                title: "Koneksitas",
                                colorIcon: clrDelete,
                                count: "0"),
                          ],
                        ),
                      ),
                    ],
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
                height: 300,
                // height: MediaQuery.of(context).size.width * 0.71,
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
                            // const HomeMonitoringAset(),
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
                                        'Rekapitulasi Unggahan Berkas perkara Penting',
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
                              width: 350,
                              height: 150,
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData,
                                  borderData: borderData,
                                  barGroups: barGroups,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceBetween,
                                  maxY: 5,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 61,
                              width: 350,
                              // width:  MediaQuery.of(context).size.width * 0.82,
                              // height: MediaQuery.of(context).size.height * 0.02,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                color: clrWait),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Pidum",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),),
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
                                            decoration: const BoxDecoration(
                                                color: clrPrimary),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Pidsus",style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                color: clrBadge),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Datun",style: TextStyle(
                                          color: Colors.white,
                                        ),),
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
                                            decoration: const BoxDecoration(
                                                color: clrEdit),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Koneksitas",style: TextStyle(
                                          color: Colors.white,
                                        ),),
                                        ],
                                      ),
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
              reservedSize: 15,
              interval: 1,
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
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
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
      color: Colors.black,
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
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3, 2, 3],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: 4,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 1,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            ),
            BarChartRodData(
              toY: 0,
              color: clrBadge,
            ),
            BarChartRodData(
              toY: 0,
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
            BarChartRodData(
              toY: 0,
              color: clrPrimary,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
      ];

  List<BarChartGroupData> get barGroups1 => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
