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

class DetailSiigapPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailSiigapPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailSiigapPage> createState() => _DetailSiigapPageState();
}

class _DetailSiigapPageState extends State<DetailSiigapPage> {
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

  num lhpComplate = 0;
  num lhpNoFindings = 0;
  num lhpSupportingEvidenceIsLacking = 0;
  num lhpSupportingEvidenceNoComplete = 0;

  num khususComplate = 0;
  num khususNoFindings = 0;
  num khususSupportingEvidenceIsLacking = 0;
  num khususSupportingEvidenceNoComplete = 0;

  num pemantauanComplate = 0;
  num pemantauanNoFindings = 0;
  num pemantauanSupportingEvidenceIsLacking = 0;
  num pemantauanSupportingEvidenceNoComplete = 0;

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
      var response = await http.post(Uri.parse(ApiService.totalSiigapCasys),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("coba" + content.toString());

      if (content['status'] == 200) {
        setState(() {
          lhpComplate = content['data']['lhp_bpk']['diagram_pie']
              ['ComplateSupportingEvidence'];
          print(lhpComplate);
          lhpNoFindings =
              content['data']['lhp_bpk']['diagram_pie']['NoFindings'];
          print(lhpNoFindings);
          lhpSupportingEvidenceIsLacking = content['data']['lhp_bpk']
              ['diagram_pie']['SupportingEvidenceIsLacking'];
          lhpSupportingEvidenceNoComplete = content['data']['lhp_bpk']
              ['diagram_pie']['SupportingEvidenceNoComplete'];

          khususComplate = content['data']['inspeksi_khusus']['diagram_pie']
              ['ComplateSupportingEvidence'];
          khususNoFindings =
              content['data']['inspeksi_khusus']['diagram_pie']['NoFindings'];
          khususSupportingEvidenceIsLacking = content['data']['inspeksi_khusus']
              ['diagram_pie']['SupportingEvidenceIsLacking'];
          khususSupportingEvidenceNoComplete = content['data']
                  ['inspeksi_khusus']['diagram_pie']
              ['SupportingEvidenceNoComplete'];

          pemantauanComplate = content['data']['pemantauan']['diagram_pie']
              ['ComplateSupportingEvidence'];
          pemantauanNoFindings =
              content['data']['pemantauan']['diagram_pie']['NoFindings'];
          pemantauanSupportingEvidenceIsLacking = content['data']['pemantauan']
              ['diagram_pie']['SupportingEvidenceIsLacking'];
          pemantauanSupportingEvidenceNoComplete = content['data']['pemantauan']
              ['diagram_pie']['SupportingEvidenceNoComplete'];
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
                    "SIIGAP",
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
                                        'Rekapitulasi LHPBPK',
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
                                          text: "Bukti Pendukung",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrPrimary,
                                          text: "Tidak Ditemukan",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrBadge,
                                          text: "Bukti Pendukung Kurang",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrDelete,
                                          text: "Bukti Tidak Lengkap",
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
                                          text: "Bukti Pendukung",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrPrimary,
                                          text: "Tidak Ditemukan",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrBadge,
                                          text: "Bukti Pendukung Kurang",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrDelete,
                                          text: "Bukti Tidak Lengkap",
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
                                        'Rekapitulasi Pemantauan',
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
                                              sections: showingSectionsBpk2(),
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
                                          text: "Bukti Pendukung",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrPrimary,
                                          text: "Tidak Ditemukan",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrBadge,
                                          text: "Bukti Pendukung Kurang",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrDelete,
                                          text: "Bukti Tidak Lengkap",
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
                                        'Audit',
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
                                          maxY: 500000),
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
                                        'Reviu',
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
                                        maxY: 500000,
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
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSectionsBpk() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clrWait,
            value: lhpComplate.toDouble(),
            title: lhpComplate.toString(),
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
            value: lhpNoFindings.toDouble(),
            title: lhpNoFindings.toString(),
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
            value: lhpSupportingEvidenceIsLacking.toDouble(),
            title: lhpSupportingEvidenceIsLacking.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: clrDelete,
            value: lhpSupportingEvidenceNoComplete.toDouble(),
            title: lhpSupportingEvidenceNoComplete.toString(),
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
    return List.generate(4, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clrWait,
            value: khususComplate.toDouble(),
            title: khususComplate.toString(),
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
            value: khususNoFindings.toDouble(),
            title: khususNoFindings.toString(),
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
            value: khususSupportingEvidenceIsLacking.toDouble(),
            title: khususSupportingEvidenceIsLacking.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: clrDelete,
            value: khususSupportingEvidenceNoComplete.toDouble(),
            title: khususSupportingEvidenceNoComplete.toString(),
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

  List<PieChartSectionData> showingSectionsBpk2() {
    return List.generate(4, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clrWait,
            value: pemantauanComplate.toDouble(),
            title: pemantauanComplate.toString(),
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
            value: pemantauanNoFindings.toDouble(),
            title: pemantauanNoFindings.toString(),
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
            value: pemantauanSupportingEvidenceIsLacking.toDouble(),
            title: pemantauanSupportingEvidenceIsLacking.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 3:
          return PieChartSectionData(
            color: clrDelete,
            value: pemantauanSupportingEvidenceNoComplete.toDouble(),
            title: pemantauanSupportingEvidenceNoComplete.toString(),
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
              interval: 100000,
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
        label = "Lengkapi Bukti Pendukung";
        break;
      case 1:
        label = "Tidak Ditemukan";
        break;
      case 2:
        label = "Bukti Pendukung Kurang";
        break;
      case 3:
        label = "Bukti Pendukung Tidak Lengkap";
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
              toY: 4,
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
              toY: 2,
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
              toY: 406292,
              color: clrWait,
            ),
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: 51086,
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
              toY: 260000,
              color: clrWait,
            ),
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: 136000,
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
              toY: 107000,
              color: clrWait,
            ),
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: 5500,
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
              toY: 68300,
              color: clrWait,
            ),
            BarChartRodData(
              width: 20,
              borderRadius: BorderRadius.circular(5),
              toY: 141000,
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
              toY: 9,
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
              toY: 4,
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
