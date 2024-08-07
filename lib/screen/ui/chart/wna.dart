import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/preference.dart';

class WnaChart extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final totalWnaP;
  // ignore: prefer_typing_uninitialized_variables
  final totalWnaW;
  const WnaChart({
    super.key,
    this.totalWnaP,
    this.totalWnaW,
  });
  // const WnaChart({super.key});

  @override
  State<WnaChart> createState() => _WnaChartState();
}

class _WnaChartState extends State<WnaChart> {
  int value1 = 0;
  int value2 = 0;

  @override
  void initState() {
    checkSession();
    super.initState();

    setState(() {
      value1 = widget.totalWnaP;
      value2 = widget.totalWnaW;
    });
  }

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
  int touchedIndex = -1;
  // int value1 = 0;
  // int value2 = 0;

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

  // @override
  // void initState() {
  //   checkSession();

  //   super.initState();
  // }

  @override
  void dispose() {
    super.dispose();
  }

  //  int touchedIndex = -1;
  int touchedGroupIndex = -1;

  @override
  Widget build(BuildContext context) {
    return  PieChart(
          PieChartData(
            pieTouchData: PieTouchData(
              touchCallback: (FlTouchEvent event, pieTouchResponse) {
                setState(() {
                  if (!event.isInterestedForInteractions ||
                      pieTouchResponse == null ||
                      pieTouchResponse.touchedSection == null) {
                    touchedIndex = -1;
                    return;
                  }
                  touchedIndex =
                      pieTouchResponse.touchedSection!.touchedSectionIndex;
                });
              },
            ),
            startDegreeOffset: 100,
            borderData: FlBorderData(
              show: false,
            ),
            sectionsSpace: 1,
            centerSpaceRadius: 0,
            sections: showingSections(value1, value2),
          ),
        );
     
  }

  List<PieChartSectionData> showingSections(val1, val2) {
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = clrWait;
        const color1 = clrPrimary;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: val1 == 0 ? 1.0 : val1.toDouble(),
              title: 'Tersangka Pria ($val1)',
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
              title: 'Tersangka Wanita ($val2)',
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
}
