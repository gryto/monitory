import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/preference.dart';
import '../ccis/constants/api.dart';

class Tahap1JampidsusChart extends StatefulWidget {
  final String accessToken, tahun;
  const Tahap1JampidsusChart({super.key, required this.accessToken, required this.tahun});

  @override
  State<Tahap1JampidsusChart> createState() => _Tahap1JampidsusChartState();
}

class _Tahap1JampidsusChartState extends State<Tahap1JampidsusChart> {
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
  num barVal12 = 0;
  num barVal13 = 0;
  num barVal14 = 0;
  num barVal15 = 0;
  num barVal16 = 0;
  num barVal17 = 0;
  num barVal18 = 0;
  num barVal19 = 0;
  num barVal20 = 0;
  num barVal21 = 0;
  num barVal22 = 0;
  num barVal23 = 0;

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

  getData() async {
    try {
      var params = jsonEncode({"tahun": "2022"});
      var response = await http.post(Uri.parse(ApiService.countPidsusKategori),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'].toString() == "200") {
        setState(() {
          listData = content['data']['pratut_tahap1']['pratut_tahap1_tahun_kategori'];
          Map<String, dynamic> listDataMap0 = listData[0];
          Map<String, dynamic> listDataMap1 = listData[1];
          Map<String, dynamic> listDataMap2 = listData[2];
          Map<String, dynamic> listDataMap3 = listData[3];
          Map<String, dynamic> listDataMap4 = listData[4];
          Map<String, dynamic> listDataMap5 = listData[5];
          Map<String, dynamic> listDataMap6 = listData[6];
          Map<String, dynamic> listDataMap7 = listData[7];
          Map<String, dynamic> listDataMap8 = listData[8];
          Map<String, dynamic> listDataMap9 = listData[9];
          Map<String, dynamic> listDataMap10 = listData[10];
          Map<String, dynamic> listDataMap11 = listData[11];
          Map<String, dynamic> listDataMap12 = listData[12];
          Map<String, dynamic> listDataMap13 = listData[13];
          Map<String, dynamic> listDataMap14 = listData[14];
          Map<String, dynamic> listDataMap15 = listData[15];
          Map<String, dynamic> listDataMap16 = listData[16];
          Map<String, dynamic> listDataMap17 = listData[17];
          Map<String, dynamic> listDataMap18 = listData[18];
          Map<String, dynamic> listDataMap19 = listData[19];
          Map<String, dynamic> listDataMap20 = listData[20];
          Map<String, dynamic> listDataMap21 = listData[21];
          Map<String, dynamic> listDataMap22 = listData[22];
          Map<String, dynamic> listDataMap23 = listData[23];

          barVal0 = listDataMap0['total'];
          barVal1 = listDataMap1['total'];
          barVal2 = listDataMap2['total'];
          barVal3 = listDataMap3['total'];
          barVal4 = listDataMap4['total'];
          barVal5 = listDataMap5['total'];
          barVal6 = listDataMap6['total'];
          barVal7 = listDataMap7['total'];
          barVal8 = listDataMap8['total'];
          barVal9 = listDataMap9['total'];
          barVal10 = listDataMap10['total'];
          barVal11 = listDataMap11['total'];
          barVal12 = listDataMap12['total'];
          barVal13 = listDataMap13['total'];
          barVal14 = listDataMap14['total'];
          barVal15 = listDataMap15['total'];
          barVal16 = listDataMap16['total'];
          barVal17 = listDataMap17['total'];
          barVal18 = listDataMap18['total'];
          barVal19 = listDataMap19['total'];
          barVal20 = listDataMap20['total'];
          barVal21 = listDataMap21['total'];
          barVal22 = listDataMap22['total'];
          barVal23 = listDataMap23['total'];
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, content['status'], content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
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
                interval: 100,
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
                const FlSpot(0, 162),
                const FlSpot(1, 123),
                const FlSpot(2, 135),
                const FlSpot(3, 98),
                const FlSpot(4, 129),
                const FlSpot(5, 158),
                const FlSpot(6, 136),
                const FlSpot(7, 207),
                const FlSpot(8, 220),
                const FlSpot(9, 232),
                const FlSpot(10, 219),
                const FlSpot(11, 160),
              ],
            ),
            LineChartBarData(
              color: clrPrimary,
              spots: [
                const FlSpot(0, 6),
                const FlSpot(1, 3),
                const FlSpot(2, 4),
                const FlSpot(3, 7),
                const FlSpot(4, 3),
                const FlSpot(5, 5),
                const FlSpot(6, 20),
                const FlSpot(7, 3),
                const FlSpot(8, 13),
                const FlSpot(9, 14),
                const FlSpot(10, 4),
                const FlSpot(11, 3),
              ],
            ),
            LineChartBarData(
              color: clrWait,
              spots: [
                const FlSpot(0, 2),
                const FlSpot(1, 0),
                const FlSpot(2, 2),
                const FlSpot(3, 4),
                const FlSpot(4, 3),
                const FlSpot(5, 4),
                const FlSpot(6, 4),
                const FlSpot(7, 15),
                const FlSpot(8, 9),
                const FlSpot(9, 9),
                const FlSpot(10, 16),
                const FlSpot(11, 34),
              ],
            ),
            LineChartBarData(
              color: clrBadge,
              spots: [
                const FlSpot(0, 1),
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
                const FlSpot(0, 4),
                const FlSpot(1, 0),
                const FlSpot(2, 6),
                const FlSpot(3, 3),
                const FlSpot(4, 3),
                const FlSpot(5, 1),
                const FlSpot(6, 2),
                const FlSpot(7, 1),
                const FlSpot(8, 4),
                const FlSpot(9, 11),
                const FlSpot(10, 4),
                const FlSpot(11, 3),
              ],
            ),
            LineChartBarData(
              color: clrEdit,
              spots: [
                const FlSpot(0, 0),
                const FlSpot(1, 0),
                const FlSpot(2, 0),
                const FlSpot(3, 0),
                const FlSpot(4, 0),
                const FlSpot(5, 0),
                const FlSpot(6, 0),
                const FlSpot(7, 1),
                const FlSpot(8, 1),
                const FlSpot(9, 0),
                const FlSpot(10, 0),
                const FlSpot(11, 0),
              ],
            ),
            LineChartBarData(
              color: clrSecondary,
              spots: [
                const FlSpot(0, 6),
                const FlSpot(1, 20),
                const FlSpot(2, 16),
                const FlSpot(3, 12),
                const FlSpot(4, 7),
                const FlSpot(5, 19),
                const FlSpot(6, 20),
                const FlSpot(7, 14),
                const FlSpot(8, 8),
                const FlSpot(9, 14),
                const FlSpot(10, 11),
                const FlSpot(11, 17),
              ],
            ),
            LineChartBarData(
              color: clrTitle,
              spots: [
                const FlSpot(0, 0),
                const FlSpot(1, 0),
                const FlSpot(2, 1),
                const FlSpot(3, 0),
                const FlSpot(4, 0),
                const FlSpot(5, 0),
                const FlSpot(6, 0),
                const FlSpot(7, 1),
                const FlSpot(8, 1),
                const FlSpot(9, 0),
                const FlSpot(10, 0),
                const FlSpot(11, 0),
              ],
            ),
          ],
        ),
      ),
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
