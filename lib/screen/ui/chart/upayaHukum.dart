import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/preference.dart';

class UpayaHukumChart extends StatefulWidget {
  const UpayaHukumChart({super.key});

  @override
  State<UpayaHukumChart> createState() => _UpayaHukumChartState();
}

class _UpayaHukumChartState extends State<UpayaHukumChart> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  List<String> last7Days = [];
  int monthNumber = 0;

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
    // var userFullname = await sharedPref.getPref("name");
    // var userRole = await sharedPref.getPref("level");
    // var userId = await sharedPref.getPref("id");
    // var userPath = await sharedPref.getPref("path");

    setState(() {});

    await getDataReservasi();
    getMonthName(monthNumber);
    // getLast7Days();
  }

  getDataReservasi() async {
    setState(() {
      isProcess = true;
    });

    try {
      var params = jsonEncode({
        "tahun": "",
      });

      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.dataMonitoring;
      var uri = url;
      // print("data monitoring"+uri);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.post(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()}, body: params);
      var content = json.decode(response.body);
      // print("data monitoring"+content.toString());

      if (content['status'] == true) {
        setState(() {
          dataBarchart0 = content['data'];
          barVal0 = dataBarchart0[0];
          barVal1 = dataBarchart0[1];
          barVal2 = dataBarchart0[2];
          barVal3 = dataBarchart0[3];
          barVal4 = dataBarchart0[4];
          barVal5 = dataBarchart0[5];
          barVal6 = dataBarchart0[6];
          barVal7 = dataBarchart0[7];
          barVal8 = dataBarchart0[8];
          barVal9 = dataBarchart0[9];
          barVal10 = dataBarchart0[10];
          barVal11 = dataBarchart0[11];
        });
      } else {
        // ignore: use_build_context_synchronously
        // onBasicAlertPressed(context, content['status'], content['message']);
      }
    } catch (e) {
      // onBasicAlertPressed(context, 'Error', e.toString());
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
    return 
    
    // Scaffold(
    //   appBar: AppBar(
    //     iconTheme: const IconThemeData(
    //       color: Colors.white,
    //     ),
    //     title: const Text("Pra Penuntutan"),
    //     backgroundColor: clrPrimary,
    //   ),
    //   body: 
      
      Container(
        padding: const EdgeInsets.only(right: 15, top: 8),
        width: 310,
        height: 150,
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
                  getTitlesWidget: leftTitleWidgets,
                  interval: 5,
                  reservedSize: 15,
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
                color: clrWait,
                spots: [
                  const FlSpot(0, 3),
                  const FlSpot(1, 9),
                  const FlSpot(2, 2),
                  const FlSpot(3, 8),
                  const FlSpot(4, 5),
                  const FlSpot(5, 6),
                  const FlSpot(6, 10),
                  const FlSpot(7, 13),
                  const FlSpot(8, 7),
                  const FlSpot(9, 20),
                  const FlSpot(10, 1),
                  const FlSpot(11, 4),
                ],
              ),
              LineChartBarData(
                color: clrPrimary,
                spots: [
                  const FlSpot(0, 7),
                  const FlSpot(1, 4),
                  const FlSpot(2, 8),
                  const FlSpot(3, 10),
                  const FlSpot(4, 13),
                  const FlSpot(5, 6),
                  const FlSpot(6, 10),
                  const FlSpot(7, 1),
                  const FlSpot(8, 16),
                  const FlSpot(9, 6),
                  const FlSpot(10, 3),
                  const FlSpot(11, 2),
                ],
              ),
            ],
          ),
        ),
      );
    // );
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
