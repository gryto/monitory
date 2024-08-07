import 'dart:math';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../src/constant.dart';
import '../constants/defines.dart';

class BarInspeksiUmum extends StatefulWidget {
  final num target1,
      realization1,
      target2,
      realization2,
      target3,
      realization3,
      target4,
      realization4;

  const BarInspeksiUmum(
      {Key? key,
      required this.target1,
      required this.realization1,
      required this.target2,
      required this.realization2,
      required this.target3,
      required this.realization3,
      required this.target4,
      required this.realization4})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => BarInspeksiUmumState();
}

class BarInspeksiUmumState extends State<BarInspeksiUmum> {
  final double width = 30;
  num maxBar = 0;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();

    var tempData = [
      widget.target1,
      widget.target2,
      widget.target3,
      widget.target4,
      widget.target3,
      widget.target4,
      widget.target3,
      widget.target4
    ];

    maxBar = tempData.reduce(max);
    maxBar = maxBar + 2;

    final barGroup1 = makeGroupData(
        0, widget.target1.toDouble(), widget.realization1.toDouble());
    final barGroup2 = makeGroupData(
        1, widget.target2.toDouble(), widget.realization2.toDouble());
    final barGroup3 = makeGroupData(
        2, widget.target3.toDouble(), widget.realization3.toDouble());
    final barGroup4 = makeGroupData(
        3, widget.target4.toDouble(), widget.realization4.toDouble());
    final barGroup5 = makeGroupData(
        0, widget.target1.toDouble(), widget.realization1.toDouble());
    final barGroup6 = makeGroupData(
        1, widget.target2.toDouble(), widget.realization2.toDouble());
    final barGroup7 = makeGroupData(
        2, widget.target3.toDouble(), widget.realization3.toDouble());
    final barGroup8 = makeGroupData(
        3, widget.target4.toDouble(), widget.realization4.toDouble());

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
      barGroup8,
    ];

    rawBarGroups = items;

    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius * 2),
        child: Container(
          //height: kSpacing * 10,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                clrPrimary.withOpacity(.1),
                clrPrimary.withOpacity(.3),
                clrPrimary.withOpacity(.6),
                clrPrimary.withOpacity(.9)
              ],
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(left: 15, top: 5),
                  child: Text(
                    'Inspeksi Umum',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffffffff),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: BarChart(
                      BarChartData(
                        maxY: maxBar.toDouble(),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitles,
                              reservedSize: 25,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
                        gridData: FlGridData(show: true),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    // final titles = <String>['Kejagung', 'Kejati', 'Kejari', 'Cabang Kejari'];
    final titles = <String>[
      'Buruh',
      'Hukum',
      'Hutang',
      'Legal',
      'Pendirian',
      'Pernikahan',
      'Pertanahan',
      'Pidana'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xffffffff),
        fontSize: 10,
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  BarChartGroupData makeGroupData(int x, double y1, double y2) {
    return BarChartGroupData(
      x: x,
      barsSpace: 4,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: color1,
          width: width,
          borderRadius: BorderRadius.circular(5),
        ),
        BarChartRodData(
          toY: y2,
          color: color6,
          width: width,
          borderRadius: BorderRadius.circular(5),
        ),
      ],
    );
  }
}
