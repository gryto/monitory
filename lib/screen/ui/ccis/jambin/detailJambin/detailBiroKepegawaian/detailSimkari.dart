import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/preference.dart';
import '../../../../../../src/toast.dart';
import '../../../../../widget/room_widget.dart';
import '../../../constants/api.dart';
import '../../../shared_components/chart/chart_indicator.dart';
import 'detailSimkari2.dart';

class DetailSimkariPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailSimkariPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailSimkariPage> createState() => _DetailSimkariPageState();
}

class _DetailSimkariPageState extends State<DetailSimkariPage> {
  late Widget body;
  String title = "SIMKARI";
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

  num totalPegawai = 0;
  num totalPegawaiLaki = 0;
  num totalPegawaiPerempuan = 0;
  num totalJaksa = 0;
  num totalTu = 0;
  num totalStrukturalJaksa = 0;
  num totalNonStrukturalJaksa = 0;
  num totalStrukturalNonJaksa = 0;
  num totalJaksaLaki = 0;
  num totalJaksaPerempuan = 0;
  num totalNonJaksaLaki = 0;
  num totalNonJaksaPerempuan = 0;
  num totalStrukturalJaksaLaki = 0;
  num totalStrukturalJaksaPerempuan = 0;
  num totalNonStrukturalJaksaLaki = 0;
  num totalNonStrukturalJaksaPerempuan = 0;
  num totalAgama = 0;
  num totalBudha = 0;
  num totalHindu = 0;
  num totalIslam = 0;
  num totalKatolik = 0;
  num totalKristen = 0;

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
      var params = jsonEncode({
        "satker": "kejaksaan-agung-republik-indonesia",
        "tahun": tahun.toString()
      });
      var response = await http.post(Uri.parse(ApiService.countPegawaiCasys),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          totalPegawai = content['data']['total_pegawai'];
          totalPegawaiLaki = content['data']['total_pegawai_laki'];
          totalPegawaiPerempuan = content['data']['total_pegawai_perempuan'];
          totalJaksa = content['data']['total_jaksa'];
          totalTu = content['data']['total_tu'];
          totalStrukturalJaksa = content['data']['total_struktural_jaksa'];
          totalNonStrukturalJaksa =
              content['data']['total_non_struktural_jaksa'];
          totalStrukturalNonJaksa =
              content['data']['total_struktural_non_jaksa'];
          totalJaksaLaki = content['data']['total_jaksa_laki'];
          totalJaksaPerempuan = content['data']['total_jaksa_perempuan'];
          totalNonJaksaLaki = content['data']['total_non_jaksa_laki'];
          totalNonJaksaPerempuan = content['data']['total_non_jaksa_perempuan'];
          totalStrukturalJaksaLaki =
              content['data']['total_struktural_jaksa_laki'];
          totalStrukturalJaksaPerempuan =
              content['data']['total_struktural_jaksa_perempuan'];
          totalNonStrukturalJaksaLaki =
              content['data']['total_non_struktural_jaksa_laki'];
          totalNonStrukturalJaksaPerempuan =
              content['data']['total_non_struktural_jaksa_perempuan'];
          totalBudha = content['data']['total_pegawai_agama'][0]['total'];
          totalHindu = content['data']['total_pegawai_agama'][1]['total'];
          totalIslam = content['data']['total_pegawai_agama'][2]['total'];
          totalKatolik = content['data']['total_pegawai_agama'][3]['total'];
          totalKristen = content['data']['total_pegawai_agama'][4]['total'];
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context, "Err detail data jampidum"); //e.toString());
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
                    "SIMKARI",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "BIRO KEPEGAWAIAN - JAMBIN",
                    style: TextStyle(color: clrEdit, fontSize: 12),
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
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => DetailSimkari2Page(
                                        accessToken: widget.accessToken,
                                        tahun: widget.tahun,
                                      ),
                                    ),
                                  );
                                },
                                title: "Total Pegawai",
                                colorIcon: clrWait,
                                count: totalPegawai.toString()),
                            RoomContainer(
                                onTap: () {},
                                title: "Total Jaksa",
                                colorIcon: clrBadge,
                                count: totalJaksa.toString()),
                            RoomContainer(
                                onTap: () {},
                                title: "Total Non Jaksa",
                                colorIcon: clrWait,
                                count: totalTu.toString()),
                            RoomContainer(
                                onTap: () {},
                                title: "Total Jasa Struktural",
                                colorIcon: clrBadge,
                                count: totalStrukturalJaksa.toString()),
                            RoomContainer(
                                onTap: () {},
                                title: "Total Jasa Non Struktural",
                                colorIcon: clrBadge,
                                count: totalNonStrukturalJaksa.toString()),
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
                height: 260,
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
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Pegawai',
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
                                  alignment: BarChartAlignment.center,
                                  maxY: 20000,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                              width: 350,
                              // width:  MediaQuery.of(context).size.width * 0.82,
                              // height: MediaQuery.of(context).size.height * 0.02,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "*Total Pegawai: $totalPegawai",
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 10,
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
                            const SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Pegawai Berdasarkan Agama',
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
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    child: PieChart(
                                      PieChartData(
                                        pieTouchData: PieTouchData(
                                          touchCallback: (FlTouchEvent event,
                                              pieTouchResponse) {
                                            setState(() {
                                              if (!event
                                                      .isInterestedForInteractions ||
                                                  pieTouchResponse == null ||
                                                  pieTouchResponse
                                                          .touchedSection ==
                                                      null) {
                                                touchedIndexBpk = -1;
                                                return;
                                              }
                                              touchedIndexBpk = pieTouchResponse
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
                                          text: "Budha",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrPrimary,
                                          text: "Hindu",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrBadge,
                                          text: "Islam",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrDelete,
                                          text: "Katolik",
                                          isSquare: true,
                                        ),
                                        SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrSecondary,
                                          text: "Kristen",
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
                            const SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Jaksa Dan Non jaksa',
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
                                  titlesData: titlesData3,
                                  borderData: borderData,
                                  barGroups: barGroups2,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceEvenly,
                                  maxY: 12500,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 61,
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
                                                color: clrEdit),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Laki - Laki",
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
                                                color: clrSecondary),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text(
                                            "Perempuan",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "*Total Jaksa: $totalJaksa Pegawai",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    "*Total Non Jaksa: $totalTu Pegawai ",
                                    style: const TextStyle(color: Colors.white),
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
                                        'Total Struktural Jaksa Dan Non Struktural Jaksa',
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
                                  titlesData: titlesData3,
                                  borderData: borderData,
                                  barGroups: barGroups3,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceEvenly,
                                  maxY: 6000,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 61,
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
                                            "Laki - Laki",
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
                                            "Perempuan",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Text(
                                    "*Total Struktural Jaksa: $totalStrukturalJaksa Pegawai",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                      "*Total Struktural Non Jaksa: $totalStrukturalNonJaksa Pegawai"),
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
    return List.generate(5, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clrWait,
            value: totalBudha.toDouble(),
            title: totalBudha.toString(),
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
            value: totalHindu.toDouble(),
            title: totalHindu.toString(),
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
            value: totalIslam.toDouble(),
            title: totalIslam.toString(),
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
            value: totalKatolik.toDouble(),
            title: totalKatolik.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff),
            ),
          );
        case 4:
          return PieChartSectionData(
            color: clrSecondary,
            value: totalKristen.toDouble(),
            title: totalKristen.toString(),
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
              reservedSize: 15,
              interval: 5000,
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
              interval: 1000,
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
        label = "Laki - Laki";
        break;
      case 1:
        label = "Perempuan";
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
        label = "Jaksa";
        break;
      case 1:
        label = "Non Jaksa";
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
              toY: totalPegawaiLaki.toDouble(),
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
              toY: totalPegawaiPerempuan.toDouble(),
              color: clrPrimary,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  List<BarChartGroupData> get barGroups2 => [
        BarChartGroupData(
          x: 0,
          barsSpace: 20,
          barRods: [
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalJaksaLaki.toDouble(),
              color: clrEdit,
            ),
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalJaksaPerempuan.toDouble(),
              color: clrSecondary,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          barsSpace: 20,
          x: 1,
          barRods: [
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalNonJaksaLaki.toDouble(),
              color: clrEdit,
            ),
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalNonJaksaPerempuan.toDouble(),
              color: clrSecondary,
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
              toY: totalStrukturalJaksaLaki.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalStrukturalJaksaPerempuan.toDouble(),
              color: clrPrimary,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          barsSpace: 20,
          x: 1,
          barRods: [
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalNonStrukturalJaksaLaki.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              width: 40,
              borderRadius: BorderRadius.circular(5),
              toY: totalNonStrukturalJaksaPerempuan.toDouble(),
              color: clrPrimary,
            ),
          ],
          showingTooltipIndicators: [0, 1],
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
