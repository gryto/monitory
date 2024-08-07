import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/preference.dart';

class HomeMonitoringAset extends StatefulWidget {
  const HomeMonitoringAset({super.key});

  @override
  State<HomeMonitoringAset> createState() => _HomeMonitoringAsetState();
}

class _HomeMonitoringAsetState extends State<HomeMonitoringAset> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  String selectedMonth = '';
  int selectedYear = 0;
  String selectedMonthIndex = '';
  String dropdownName = "";
  String month = "";
  var year = 10;
  int bulannkkk = DateTime.now().month;
  late var bulans = bulannkkk;
  int tahun = DateTime.now().year;
  late var tahuns = tahun;
  List<int> years =
      List.generate(3, (int index) => DateTime.now().year - index);

  List<String> months = [
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

  List dataLinechart = [];
  num lineVal0 = 50;
  num lineVal1 = 6;
  num lineVal2 = 0;
  num lineVal3 = 7;
  num lineVal4 = 0;
  num lineVal5 = 20;
  num lineVal6 = 0;
  num lineVal7 = 0;

  num lineVal8 = 6;
  num lineVal9 = 0;
  num lineVal10 = 0;
  num lineVal11 = 0;
  num lineVal12 = 0;
  num lineVal13 = 0;
  num lineVal14 = 0;
  num lineVal15 = 0;

  String lineTxt0 = "";
  String lineTxt1 = "";
  String lineTxt2 = "";
  String lineTxt3 = "";
  String lineTxt4 = "";
  String lineTxt5 = "";
  String lineTxt6 = "";
  String lineTxt7 = "";

  num summAset = 0;
  num totalAsetMasuk = 0;
  num totalAsetKeluar = 0;
  int maxLinechart = 0;

  Future<void> _pullRefresh() async {
    setState(() {
      listData.clear();
      // searchData(selectedMonthIndex, selectedYear);
      getDataMonitoring(month, year);
      // getDataAset();
      // getDataReservasi();
      // getDataTotalAset();
    });
  }

  String getMonthName(int monthNumber) {
    List<String> monthNames = [
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
      'Desember',
    ];

    if (monthNumber >= 1 && monthNumber <= 12) {
      return monthNames[
          monthNumber - 1]; // Subtract 1 since lists are 0-indexed
    } else {
      return 'Invalid Month';
    }
  }

  getDataMonitoring(month, year) async {
    setState(() {
      isProcess = true;
      
    });

    try {
      final params = {
        // 'bulan': month.toString(),
        // 'tahun': year.toString(),
        'bulan': bulans.toString(),
        'tahun': tahuns.toString(),
        
      };

      

      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.dataMonitoring;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.post(Uri.parse(uri),
          body: params, headers: {"Authorization": bearerToken.toString()});
      // var response = await http.post(Uri.parse(uri),
      //     headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      

      if (content['status'] == true) {
        setState(() {
          dataLinechart = content['data'];
          lineVal0 = dataLinechart[0]['aset_masuk'];
          lineVal1 = dataLinechart[1]['aset_masuk'];
          lineVal2 = dataLinechart[2]['aset_masuk'];
          lineVal3 = dataLinechart[3]['aset_masuk'];
          lineVal4 = dataLinechart[4]['aset_masuk'];
          lineVal5 = dataLinechart[5]['aset_masuk'];
          lineVal6 = dataLinechart[6]['aset_masuk'];
          lineVal7 = dataLinechart[7]['aset_masuk'];

          lineVal8 = dataLinechart[0]['aset_keluar'];
          lineVal9 = dataLinechart[1]['aset_keluar'];
          lineVal10 = dataLinechart[2]['aset_keluar'];
          lineVal11 = dataLinechart[3]['aset_keluar'];
          lineVal12 = dataLinechart[4]['aset_keluar'];
          lineVal13 = dataLinechart[5]['aset_keluar'];
          lineVal14 = dataLinechart[6]['aset_keluar'];
          lineVal15 = dataLinechart[6]['aset_keluar'];

          for (var row in dataLinechart) {
            totalAsetMasuk += row["aset_masuk"];
            totalAsetKeluar += row["aset_keluar"];
          }

          summAset = totalAsetMasuk + totalAsetKeluar;

          var tempLinechart = [
            lineVal0.toInt(),
            lineVal1.toInt(),
            lineVal2.toInt(),
            lineVal3.toInt(),
            lineVal4.toInt(),
            lineVal5.toInt(),
            lineVal6.toInt(),
            lineVal7.toInt(),
            lineVal8.toInt(),
            lineVal9.toInt(),
            lineVal10.toInt(),
            lineVal11.toInt(),
            lineVal12.toInt(),
            lineVal13.toInt(),
            lineVal14.toInt(),
            lineVal15.toInt(),
          ];

          maxLinechart = tempLinechart.reduce(max);
          maxLinechart = maxLinechart + 2;

          lineTxt0 = dataLinechart[0]['bidang_name'];
          lineTxt1 = dataLinechart[1]['bidang_name'];
          lineTxt2 = dataLinechart[2]['bidang_name'];
          lineTxt3 = dataLinechart[3]['bidang_name'];
          lineTxt4 = dataLinechart[4]['bidang_name'];
          lineTxt5 = dataLinechart[5]['bidang_name'];
          lineTxt6 = dataLinechart[6]['bidang_name'];
          lineTxt7 = dataLinechart[7]['bidang_name'];
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, content['status'], content['message']);
      }
    } catch (e) {
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  searchData(selectedMonthIndex, selectedYear) async {


    month = selectedMonthIndex;
    year = selectedYear;
    try {
      final params = {
        'bulan': selectedMonthIndex.toString(),
        'tahun': selectedYear.toString(),
      };

      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.dataMonitoring;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.post(Uri.parse(uri),
          body: params, headers: {"Authorization": bearerToken.toString()});
    
      var content = json.decode(response.body) as Map;

      if (content['status'] == true) {
        setState(() {
          dataLinechart = content['data'];
          lineVal0 = dataLinechart[0]['aset_masuk'];
          lineVal1 = dataLinechart[1]['aset_masuk'];
          lineVal2 = dataLinechart[2]['aset_masuk'];
          lineVal3 = dataLinechart[3]['aset_masuk'];
          lineVal4 = dataLinechart[4]['aset_masuk'];
          lineVal5 = dataLinechart[5]['aset_masuk'];
          lineVal6 = dataLinechart[6]['aset_masuk'];
          lineVal7 = dataLinechart[7]['aset_masuk'];

          lineVal8 = dataLinechart[0]['aset_keluar'];
          lineVal9 = dataLinechart[1]['aset_keluar'];
          lineVal10 = dataLinechart[2]['aset_keluar'];
          lineVal11 = dataLinechart[3]['aset_keluar'];
          lineVal12 = dataLinechart[4]['aset_keluar'];
          lineVal13 = dataLinechart[5]['aset_keluar'];
          lineVal14 = dataLinechart[6]['aset_keluar'];
          lineVal15 = dataLinechart[6]['aset_keluar'];

          for (var row in dataLinechart) {
            totalAsetMasuk += row["aset_masuk"];
            totalAsetKeluar += row["aset_keluar"];
          }

          summAset = totalAsetMasuk + totalAsetKeluar;

          var tempLinechart = [
            lineVal0.toInt(),
            lineVal1.toInt(),
            lineVal2.toInt(),
            lineVal3.toInt(),
            lineVal4.toInt(),
            lineVal5.toInt(),
            lineVal6.toInt(),
            lineVal7.toInt(),
            lineVal8.toInt(),
            lineVal9.toInt(),
            lineVal10.toInt(),
            lineVal11.toInt(),
            lineVal12.toInt(),
            lineVal13.toInt(),
            lineVal14.toInt(),
            lineVal15.toInt(),
          ];

          maxLinechart = tempLinechart.reduce(max);
          maxLinechart = maxLinechart + 2;

          lineTxt0 = dataLinechart[0]['bidang_name'];
          lineTxt1 = dataLinechart[1]['bidang_name'];
          lineTxt2 = dataLinechart[2]['bidang_name'];
          lineTxt3 = dataLinechart[3]['bidang_name'];
          lineTxt4 = dataLinechart[4]['bidang_name'];
          lineTxt5 = dataLinechart[5]['bidang_name'];
          lineTxt6 = dataLinechart[6]['bidang_name'];
          lineTxt7 = dataLinechart[7]['bidang_name'];
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

    // getDataMonitoring(month, year);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: clrPrimary,
      onRefresh: () async {
        await Future.delayed(const Duration(milliseconds: 1500));
        setState(() {
          isProcess = true;
          listData.clear();
          _pullRefresh();
          // informasiLayanan(limit, offset);

          // itemCount = itemCount + 1;
        });
      },
      child: SizedBox(
        height: 34,
        width: 300,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Data Aset dan Masuk Setiap Bidang',
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 1,
                ),
                Text(
                  '( Periode - ${getMonthName(bulans)} $tahuns )',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
