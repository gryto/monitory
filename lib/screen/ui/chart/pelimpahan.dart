import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../src/constant.dart';
import '../../../src/preference.dart';

class PelimpahanChart extends StatefulWidget {
  const PelimpahanChart({super.key});

  @override
  State<PelimpahanChart> createState() => _PelimpahanChartState();
}

class _PelimpahanChartState extends State<PelimpahanChart> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  List<String> last7Days = [];
  int monthNumber = 0;
  double divY = 1;

  List dataBarchart0 = [];
  List dataBarchart1 = [];
  List dataBarchart2 = [];
  List dataBarchart3 = [];
  List dataBarchart4 = [];
  List dataBarchart5 = [];
  List dataBarchart6 = [];
  List dataBarchart7 = [];
  List dataBarchart8 = [];
  List dataBarchart9 = [];
  List dataBarchart10 = [];
  List dataBarchart11 = [];
  List dataBarchart12 = [];
  List dataBarchart13 = [];
  List dataBarchart14 = [];
  List dataBarchart15 = [];
  List dataBarchart16 = [];
  List dataBarchart17 = [];
  List dataBarchart18 = [];
  List dataBarchart19 = [];
  List dataBarchart20 = [];
  num barVal0 = 0;
  num barVal1 = 0;
  num barVal2 = 0;
  num barVal3 = 0;
  num barVal4 = 0;
  num barVal5 = 0;
  num barVal6 = 0;
  num barVal7 = 0;
  num barVal8 = 0;
  num barVal9 = 0;
  num barVal10 = 0;
  num barVal11 = 0;

  String line0 = "";
  String line1 = "";
  String line2 = "";
  String line3 = "";
  String line4 = "";
  String line5 = "";
  String line6 = "";
  String line7 = "";
  String line8 = "";
  String line9 = "";
  String line10 = "";
  String line11 = "";
  String line12 = "";

  void checkSession() async {

    setState(() {});

    getMonthName(monthNumber);
  }

  String getMonthName(int monthNumber) {
    List<String> monthNames = [
      line0 = 'Januari',
      line1 = 'Februari',
      line2 = 'Maret',
      line3 = 'April',
      line4 = 'Mei',
      line5 = 'Juni',
      line6 = 'Juli',
      line7 = 'Agustus',
      line8 = 'September',
      line9 = 'Oktober',
      line10 = 'November',
      line11 = 'Desember',
    ];

    if (monthNumber >= 0 && monthNumber <= 11) {
      return monthNames[
          monthNumber - 1]; // Subtract 1 since lists are 0-indexed
    } else {
      return 'Invalid Month';
    }
  }

  @override
  void initState() {
    checkSession();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15, top: 8),
      width: 310,
      height: 180,
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
          titlesData: FlTitlesData(
            topTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                interval: 1,
                reservedSize: 15,
              ),
            ),
            rightTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: false,
                interval: 1,
                reservedSize: 15,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: leftTitleWidgetss,
                interval: 50,
                reservedSize: 25,
                // reservedSize: 20,
                //                   interval: divY,
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: getTitles,
                interval: 1,
                reservedSize: 15,
              ),
            ),
          ),
          lineBarsData: [
            LineChartBarData(
              color: clrDelete,
              spots: [
                const FlSpot(0, 151),
                const FlSpot(1, 104),
                const FlSpot(2, 140),
                const FlSpot(3, 88),
                const FlSpot(4, 103),
                const FlSpot(5, 114),
                const FlSpot(6, 111),
                const FlSpot(7, 140),
                const FlSpot(8, 148),
                const FlSpot(9, 167),
                const FlSpot(10, 186),
                const FlSpot(11, 131),
              ],
            ),
            LineChartBarData(
              color: clrPrimary,
              spots: [
                const FlSpot(0, 11),
                const FlSpot(1, 3),
                const FlSpot(2, 0),
                const FlSpot(3, 2),
                const FlSpot(4, 3),
                const FlSpot(5, 3),
                const FlSpot(6, 5),
                const FlSpot(7, 8),
                const FlSpot(8, 2),
                const FlSpot(9, 10),
                const FlSpot(10, 10),
                const FlSpot(11, 1),
              ],
            ),
            LineChartBarData(
              color: clrWait,
              spots: [
                const FlSpot(0, 19),
                const FlSpot(1, 5),
                const FlSpot(2, 2),
                const FlSpot(3, 2),
                const FlSpot(4, 1),
                const FlSpot(5, 3),
                const FlSpot(6, 2),
                const FlSpot(7, 3),
                const FlSpot(8, 9),
                const FlSpot(9, 8),
                const FlSpot(10, 6),
                const FlSpot(11, 4),
              ],
            ),
            LineChartBarData(
              color: clrBadge,
              spots: [
                const FlSpot(0, 0),
                const FlSpot(1, 0),
                const FlSpot(2, 0),
                const FlSpot(3, 0),
                const FlSpot(4, 0),
                const FlSpot(5, 0),
                const FlSpot(6, 0),
                const FlSpot(7, 0),
                const FlSpot(8, 0),
                const FlSpot(9, 0),
                const FlSpot(10, 0),
                const FlSpot(11, 0),
              ],
            ),
            LineChartBarData(
              color: clrPink,
              spots: [
                const FlSpot(0, 3),
                const FlSpot(1, 2),
                const FlSpot(2, 2),
                const FlSpot(3, 1),
                const FlSpot(4, 1),
                const FlSpot(5, 4),
                const FlSpot(6, 2),
                const FlSpot(7, 1),
                const FlSpot(8, 0),
                const FlSpot(9, 2),
                const FlSpot(10, 4),
                const FlSpot(11, 2),
              ],
            ),
            LineChartBarData(
              color: clrEdit,
              spots: [
                const FlSpot(0, 1),
                const FlSpot(1, 0),
                const FlSpot(2, 0),
                const FlSpot(3, 0),
                const FlSpot(4, 0),
                const FlSpot(5, 0),
                const FlSpot(6, 0),
                const FlSpot(7, 1),
                const FlSpot(8, 0),
                const FlSpot(9, 0),
                const FlSpot(10, 0),
                const FlSpot(11, 0),
              ],
            ),
            LineChartBarData(
              color: clrSecondary,
              spots: [
                const FlSpot(0, 9),
                const FlSpot(1, 4),
                const FlSpot(2, 13),
                const FlSpot(3, 16),
                const FlSpot(4, 12),
                const FlSpot(5, 14),
                const FlSpot(6, 13),
                const FlSpot(7, 17),
                const FlSpot(8, 12),
                const FlSpot(9, 7),
                const FlSpot(10, 14),
                const FlSpot(11, 9),
              ],
            ),
            LineChartBarData(
              color: clrTitle,
              spots: [
                const FlSpot(0, 0),
                const FlSpot(1, 0),
                const FlSpot(2, 0),
                const FlSpot(3, 0),
                const FlSpot(4, 0),
                const FlSpot(5, 0),
                const FlSpot(6, 0),
                const FlSpot(7, 0),
                const FlSpot(8, 1),
                const FlSpot(9, 1),
                const FlSpot(10, 0),
                const FlSpot(11, 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget leftTitleWidgetss(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 8,
    );
    String text;
    int temp = 0;
    temp = value.toInt();
    text = temp.toString();

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 6,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(meta.formattedValue, style: style),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = line0;
        break;
      case 1:
        label = line1;
        break;
      case 2:
        label = line2;
        break;
      case 3:
        label = line3;
        break;
      case 4:
        label = line4;
        break;
      case 5:
        label = line5;
        break;
      case 6:
        label = line6;
        break;
      case 7:
        label = line7;
        break;
      case 8:
        label = line8;
        break;
      case 9:
        label = line9;
        break;
      case 10:
        label = line10;
        break;
      case 11:
        label = line11;
        break;
    }

    Widget text;
    text = Text(label, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 10,
      child: text,
    );
  }
}
