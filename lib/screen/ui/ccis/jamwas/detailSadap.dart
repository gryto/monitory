import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../src/constant.dart';
import '../../../../src/preference.dart';
import '../../../../src/toast.dart';
import '../constants/api.dart';
import '../constants/defines.dart';
import '../shared_components/chart/chart_indicator.dart';
import '../shared_components/header_text.dart';

class DetailSadapPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailSadapPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailSadapPage> createState() => _DetailSadapPageState();
}

class _DetailSadapPageState extends State<DetailSadapPage> {
  late Widget body;
  String title = "SADAP";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();

  List listData = [];
  List arrSatkerId = [];
  String dropdownValue = '';
  String dropdownName = "";

  num totalUmumTarget = 0;
  num totalUmumRealisasi = 0;
  num totalKhususTarget = 0;
  num totalKhususRealisasi = 0;

  List totalPemantauan = [];
  String pemantauanTitle0 = '';
  String pemantauanTitle1 = '';
  String pemantauanTitle2 = '';
  String pemantauanTitle3 = '';

  num pemantauanTarget0 = 0;
  num pemantauanTarget1 = 1;
  num pemantauanTarget2 = 2;
  num pemantauanTarget3 = 3;

  num pemantauanRealisasi0 = 0;
  num pemantauanRealisasi1 = 1;
  num pemantauanRealisasi2 = 2;
  num pemantauanRealisasi3 = 3;

  num lapduIncoming = 0;
  num lapduDone = 0;

  num hukdisLight = 0;
  num hukdisMedium = 0;
  num hukdisSeveral = 0;

  int value1 = 0;
  int value2 = 0;
  int touchedIndexBpk = -1;
  int touchedIndex = -1;
  int touchedGroupIndex = -1;

  searchData(tahun) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
    });

    getData(year.toString());
  }

  getData(tahun) async {
    try {
      var params = jsonEncode({"tahun": tahun.toString()});
      var response = await http.post(Uri.parse(ApiService.totalSadapCasys),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalUmumTarget = content['data']['inspeksiUmumData']['target'];
          totalUmumRealisasi =
              content['data']['inspeksiUmumData']['realization'];

          totalKhususTarget = content['data']['inspeksiKhususData']['target'];
          totalKhususRealisasi =
              content['data']['inspeksiKhususData']['realization'];

          totalPemantauan = content['data']['pemantauanData'];

          pemantauanTarget0 = totalPemantauan[0]['target'];
          pemantauanTarget1 = totalPemantauan[1]['target'];
          pemantauanTarget2 = totalPemantauan[2]['target'];
          pemantauanTarget3 = totalPemantauan[3]['target'];

          pemantauanTitle0 = totalPemantauan[0]['inspection_object'];
          pemantauanTitle1 = totalPemantauan[1]['inspection_object'];
          pemantauanTitle2 = totalPemantauan[2]['inspection_object'];
          pemantauanTitle3 = totalPemantauan[3]['inspection_object'];

          pemantauanRealisasi0 = totalPemantauan[0]['realization']['reports'];
          pemantauanRealisasi1 = totalPemantauan[1]['realization']['reports'];
          pemantauanRealisasi2 = totalPemantauan[2]['realization']['reports'];
          pemantauanRealisasi3 = totalPemantauan[3]['realization']['reports'];

          lapduIncoming = content['data']['lapduData']['incoming'];
          lapduDone = content['data']['lapduData']['done'];

          hukdisLight = content['data']['hukdisData']['light_punishment'];
          hukdisMedium = content['data']['hukdisData']['medium_punishment'];
          hukdisSeveral = content['data']['hukdisData']['several_punishment'];
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context, "Err detail data jampidum"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  sessionToken() async {
    getData(year.toString());
  }

  selectyear(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 13, 30, 46),
          title: const Text(
            "Pilih Tahun",
            style: TextStyle(color: Colors.white),
          ),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 5, 1),
              lastDate: DateTime(DateTime.now().year + 0, 1),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                setState(() {
                  _selectedYear = dateTime;
                  yearStart.text = "${dateTime.year}";
                  year = dateTime.year;
                });

                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  selectsatker(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Tahun"),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(DateTime.now().year - 5, 1),
              lastDate: DateTime(DateTime.now().year + 0, 1),
              initialDate: DateTime.now(),
              selectedDate: _selectedYear,
              onChanged: (DateTime dateTime) {
                setState(() {
                  _selectedYear = dateTime;
                  yearStart.text = "${dateTime.year}";
                  year = dateTime.year;
                });

                Navigator.pop(context);
              },
            ),
          ),
        );
      },
    );
  }

  checkSession() async {
    setState(() {
      year = today.year;
    });

    yearStart.text = year.toString();
    getData(year.toString());
  }

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  @override
  dispose() {
    super.dispose();
  }

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
                    "SADAP",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "JAMWAS",
                    style: TextStyle(color: clrWait, fontSize: 12),
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
            const SizedBox(height: kSpacing),
            Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Periode Tahun ${yearStart.text}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  HeaderText(
                    "Periode Tahun ${yearStart.text}",
                  ),
                  GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        builder: (BuildContext context) {
                          return BottomSheet(
                            enableDrag: false,
                            onClosing: () {},
                            builder: (BuildContext context) {
                              return StatefulBuilder(
                                builder: (BuildContext context, setState) =>
                                    SafeArea(
                                  child: Container(
                                    color:
                                        const Color.fromARGB(255, 13, 30, 46),
                                    //height: 150,
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.remove,
                                          color: Colors.grey[600],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Text(
                                          "Pencarian",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        ),
                                        const Divider(
                                          thickness: 2,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child: TextField(
                                            controller: yearStart,
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              labelText: "Tahun",
                                              labelStyle: const TextStyle(
                                                  color: Colors.white),
                                              hintStyle: const TextStyle(
                                                  color: Colors.white),
                                              hintText: 'Pilih tahun',
                                              focusColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            readOnly: true,
                                            onTap: () async {
                                              selectyear(context);
                                            },
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            searchData(yearStart.text);
                                          },
                                          child: Container(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 20.0),
                                            margin: const EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              color: clrBadge,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Pencarian",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.date_range,
                      color: clrBadge,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
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
                height: 240,
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
                            SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Inspeksi Umum',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '( Periode -  ${yearStart.text} )',
                                        style: const TextStyle(
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
                              child: !isProcess
                                  ? BarChart(BarChartData(
                                      barTouchData: barTouchData,
                                      titlesData: titlesData,
                                      borderData: borderData,
                                      barGroups: barGroups,
                                      gridData: FlGridData(show: true),
                                      alignment: BarChartAlignment.center,
                                      maxY: 1500,
                                    ))
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.grey,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xff3cd2a5),
                                        ),
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
                height: 240,
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
                            SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Inspeksi Khusus',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '( Periode -  ${yearStart.text} )',
                                        style: const TextStyle(
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
                              child: !isProcess
                                  ? BarChart(
                                      BarChartData(
                                        barTouchData: barTouchData,
                                        titlesData: titlesData,
                                        borderData: borderData,
                                        barGroups: barGroups3,
                                        gridData: FlGridData(show: true),
                                        alignment: BarChartAlignment.center,
                                        maxY: 800,
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.grey,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xff3cd2a5),
                                        ),
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
                height: 270,
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
                            SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Pemantauan',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '( Periode -  ${yearStart.text} )',
                                        style: const TextStyle(
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
                              child: !isProcess
                                  ? BarChart(
                                      BarChartData(
                                        barTouchData: barTouchData,
                                        titlesData: titlesData3,
                                        borderData: borderData,
                                        barGroups: barGroups2,
                                        gridData: FlGridData(show: true),
                                        alignment:
                                            BarChartAlignment.spaceEvenly,
                                        maxY: 700,
                                      ),
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                        backgroundColor: Colors.grey,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          Color(0xff3cd2a5),
                                        ),
                                      ),
                                    ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 350,
                              // width:  MediaQuery.of(context).size.width * 0.82,
                              // height: MediaQuery.of(context).size.height * 0.02,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
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
                                          const Text(
                                            "Total Target",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
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
                                          const Text(
                                            "Total Realisasi",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
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
                height: 240,
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
                            SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Rekapitulasi Laporan Aduan',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '( Periode -  ${yearStart.text} )',
                                        style: const TextStyle(
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
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: !isProcess
                                        ? PieChart(
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
                                              sectionsSpace: 2,
                                              centerSpaceRadius: 30,
                                              sections: showingSectionsBpk(),
                                            ),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.grey,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Color(0xff3cd2a5),
                                              ),
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
                                          color: clrWait,
                                          text: "Selesai",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrPrimary,
                                          text: "Akan Datang",
                                          isSquare: true,
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
                height: 240,
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
                            SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Text(
                                        'Rekapitulasi Hukum Disiplin',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '( Periode -  ${yearStart.text} )',
                                        style: const TextStyle(
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
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: !isProcess
                                        ? PieChart(
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
                                              sectionsSpace: 2,
                                              centerSpaceRadius: 30,
                                              sections: showingSectionsBpk1(),
                                            ),
                                          )
                                        : const Center(
                                            child: CircularProgressIndicator(
                                              backgroundColor: Colors.grey,
                                              valueColor:
                                                  AlwaysStoppedAnimation<Color>(
                                                Color(0xff3cd2a5),
                                              ),
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
                                          color: clrWait,
                                          text: "Hukuman Ringan",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrPrimary,
                                          text: "Hukuman Sedang",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrBadge,
                                          text: "Beberapa Hukuman",
                                          isSquare: true,
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
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSectionsBpk() {
    return List.generate(2, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clrWait,
            value: lapduDone.toDouble(),
            title: lapduDone.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: clrPrimary,
            value: lapduIncoming.toDouble(),
            title: lapduIncoming.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
  }

  List<PieChartSectionData> showingSectionsBpk1() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clrWait,
            value: hukdisLight.toDouble(),
            title: hukdisLight.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 1:
          return PieChartSectionData(
            color: clrPrimary,
            value: hukdisMedium.toDouble(),
            title: hukdisMedium.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 2:
          return PieChartSectionData(
            color: clrBadge,
            value: hukdisSeveral.toDouble(),
            title: hukdisSeveral.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        default:
          throw Error();
      }
    });
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
            getTitlesWidget: bottomtitles,
            // getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 25,
              interval: 200,
              getTitlesWidget: leftTitleWidgets),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlTitlesData get titlesData3 => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: bottomtitles2,
            // getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 15,
              interval: 100,
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
            getTitlesWidget: bottomtitles1,
            // getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 15,
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

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      'Pertemnuan Tatap Muka',
      'Antar Surat',
      'Mengunjungi Rutan',
      'Taha2',
      'Pelayanan PTSP',
      'Pertemuan ThapMUka',
      'Wajib Lapor'
    ];

    final Widget text = Text(
      titles[value.toInt()],
      style: const TextStyle(
        color: Colors.black,
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
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 8,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = "Total Target";
        break;
      case 1:
        label = "Total Realisasi";
        break;
    }

    Widget text;
    text = Text(label, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: text,
    );
  }

  Widget bottomtitles2(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = pemantauanTitle0;
        break;
      case 1:
        label = pemantauanTitle1;
        break;
      case 2:
        label = pemantauanTitle2;
        break;
      case 3:
        label = pemantauanTitle3;
        break;
    }

    Widget text;
    text = Text(label, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 2,
      child: text,
    );
  }

  Widget bottomtitles1(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = "Tamu Biasa";
        break;
      case 1:
        label = "Tersangka";
        break;
      case 2:
        label = "Pegawai";
        break;
      case 3:
        label = "VVIP";
        break;
      case 4:
        label = "Saksi";
        break;
      case 5:
        label = "Ahli";
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
      space: 2,
      child: Text(meta.formattedValue, style: style),
    );
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalUmumTarget.toDouble(),
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalUmumRealisasi.toDouble(),
              color: clrPrimary,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  List<BarChartGroupData> get barGroups2 => [
        BarChartGroupData(
          x: 0,
          barsSpace: 10,
          barRods: [
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: pemantauanTarget0.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: pemantauanRealisasi0.toDouble(),
              color: clrPrimary,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          barsSpace: 8,
          x: 1,
          barRods: [
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: pemantauanTarget1.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: pemantauanRealisasi1.toDouble(),
              color: clrPrimary,
            ),
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          barsSpace: 10,
          x: 2,
          barRods: [
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: pemantauanTarget2.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: pemantauanRealisasi2.toDouble(),
              color: clrPrimary,
            ),
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          barsSpace: 10,
          x: 3,
          barRods: [
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: pemantauanTarget3.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: pemantauanRealisasi3.toDouble(),
              color: clrPrimary,
            ),
          ],
          showingTooltipIndicators: [0, 1],
        ),
      ];

  List<BarChartGroupData> get barGroups3 => [
        BarChartGroupData(
          x: 0,
          barsSpace: 20,
          barRods: [
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalKhususTarget.toDouble(),
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          barsSpace: 20,
          x: 1,
          barRods: [
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalKhususRealisasi.toDouble(),
              color: clrPrimary,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  List<BarChartGroupData> get barGroups1 => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: 2608,
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrPink,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: 2,
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: 7,
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: 36,
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: 0,
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
