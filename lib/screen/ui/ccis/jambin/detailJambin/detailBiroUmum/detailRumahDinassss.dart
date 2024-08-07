import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/preference.dart';
import '../../../../../../src/toast.dart';
import '../../../../../widget/room_widget.dart';
import '../../../constants/api.dart';

class DetailRumahDinasPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailRumahDinasPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailRumahDinasPage> createState() => _DetailRumahDinasPageState();
}

class _DetailRumahDinasPageState extends State<DetailRumahDinasPage> {
  late Widget body;
  String title = "JDIH";
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

  num totalSuratMasuk = 0;
  List listSuratMasuk = [];
  num lineMasuk0 = 0;
  num lineMasuk1 = 0;
  num lineMasuk2 = 0;
  num lineMasuk3 = 0;
  num lineMasuk4 = 0;
  num lineMasuk5 = 0;
  num lineMasuk6 = 0;
  num lineMasuk7 = 0;
  num lineMasuk8 = 0;
  num lineMasuk9 = 0;
  num lineMasuk10 = 0;
  num lineMasuk11 = 0;

  num totalSuratKeluar = 0;
  List listSuratKeluar = [];
  num lineKeluar0 = 0;
  num lineKeluar1 = 0;
  num lineKeluar2 = 0;
  num lineKeluar3 = 0;
  num lineKeluar4 = 0;
  num lineKeluar5 = 0;
  num lineKeluar6 = 0;
  num lineKeluar7 = 0;
  num lineKeluar8 = 0;
  num lineKeluar9 = 0;
  num lineKeluar10 = 0;
  num lineKeluar11 = 0;

  num totalEsignKeluar = 0;
  List listEsignKeluar = [];
  num lineEsignKeluar0 = 0;
  num lineEsignKeluar1 = 0;
  num lineEsignKeluar2 = 0;
  num lineEsignKeluar3 = 0;
  num lineEsignKeluar4 = 0;
  num lineEsignKeluar5 = 0;
  num lineEsignKeluar6 = 0;
  num lineEsignKeluar7 = 0;
  num lineEsignKeluar8 = 0;
  num lineEsignKeluar9 = 0;
  num lineEsignKeluar10 = 0;
  num lineEsignKeluar11 = 0;

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
      var response = await http.post(Uri.parse(ApiService.countPersuratan),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          totalSuratMasuk = content['data']['surat_masuk'];
          listSuratMasuk = content['data']['surat_masuk_kategori'];
          lineMasuk0 = listSuratMasuk[0]['total'];
          lineMasuk1 = listSuratMasuk[1]['total'];
          lineMasuk2 = listSuratMasuk[2]['total'];
          lineMasuk3 = listSuratMasuk[3]['total'];
          lineMasuk4 = listSuratMasuk[4]['total'];
          lineMasuk5 = listSuratMasuk[5]['total'];
          lineMasuk6 = listSuratMasuk[6]['total'];
          lineMasuk7 = listSuratMasuk[7]['total'];
          lineMasuk8 = listSuratMasuk[8]['total'];
          lineMasuk9 = listSuratMasuk[9]['total'];
          lineMasuk10 = listSuratMasuk[10]['total'];
          lineMasuk11 = listSuratMasuk[11]['total'];

          totalSuratKeluar = content['data']['surat_keluar'];
          listSuratKeluar = content['data']['surat_keluar_kategori'];
          lineKeluar0 = listSuratKeluar[0]['total'];
          lineKeluar1 = listSuratKeluar[1]['total'];
          lineKeluar2 = listSuratKeluar[2]['total'];
          lineKeluar3 = listSuratKeluar[3]['total'];
          lineKeluar4 = listSuratKeluar[4]['total'];
          lineKeluar5 = listSuratKeluar[5]['total'];
          lineKeluar6 = listSuratKeluar[6]['total'];
          lineKeluar7 = listSuratKeluar[7]['total'];
          lineKeluar8 = listSuratKeluar[8]['total'];
          lineKeluar9 = listSuratKeluar[9]['total'];
          lineKeluar10 = listSuratKeluar[10]['total'];
          lineKeluar11 = listSuratKeluar[11]['total'];

          totalEsignKeluar = content['data']['surat_esign_keluar'];
          listEsignKeluar = content['data']['surat_esign_keluar_kategori'];
          lineEsignKeluar0 = listEsignKeluar[0]['total'];
          lineEsignKeluar1 = listEsignKeluar[1]['total'];
          lineEsignKeluar2 = listEsignKeluar[2]['total'];
          lineEsignKeluar3 = listEsignKeluar[3]['total'];
          lineEsignKeluar4 = listEsignKeluar[4]['total'];
          lineEsignKeluar5 = listEsignKeluar[5]['total'];
          lineEsignKeluar6 = listEsignKeluar[6]['total'];
          lineEsignKeluar7 = listEsignKeluar[7]['total'];
          lineEsignKeluar8 = listEsignKeluar[8]['total'];
          lineEsignKeluar9 = listEsignKeluar[9]['total'];
          lineEsignKeluar10 = listEsignKeluar[10]['total'];
          lineEsignKeluar11 = listEsignKeluar[11]['total'];
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rumah Dinas",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "BIRO UMUM - JAMBIN",
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
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Periode Tahun ${yearStart.text}",
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white),
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
                                    color: const Color.fromARGB(255, 13, 30, 46),
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
                                              fontWeight: FontWeight.w600,color: Colors.white),
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
                                title: "Pengaturan Jaksa Agung",
                                colorIcon: clrWait,
                                count: "220"),
                            RoomContainer(
                                onTap: () {},
                                title: "Keputusan Jaksa Agung",
                                colorIcon: clrBadge,
                                count: "942"),
                            RoomContainer(
                                onTap: () {},
                                title: "Instruksi Jaksa Agung",
                                colorIcon: clrDelete,
                                count: "270"),
                            RoomContainer(
                                onTap: () {},
                                title: "MoU",
                                colorIcon: clrDelete,
                                count: "81"),
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
                height: MediaQuery.of(context).size.width * 0.68,
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Rekapitulasi Unggahan Berkas Perkara Penting',
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
                              padding: const EdgeInsets.only(top: 0, left: 0),
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: MediaQuery.of(context).size.height * 0.2,
                              
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData,
                                  borderData: borderData,
                                  barGroups: barGroups,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY: 300,
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
              reservedSize: 20,
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
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 2,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 131,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 29,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 9,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 4,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 70,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 57,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 3,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 49,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 217,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 7,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 7,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 14,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 3,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 4,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 6,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 3,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 32,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 3,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 2,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 1,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 264,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 9,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 1,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 27,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 5,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 1,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 11,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 19,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 1,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 5,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 15,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 19,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 1,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 5,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 15,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 70,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 14,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 23,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 10,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 12,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 21,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 120,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 8,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 9,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 2,
              color: clrPrimary,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 10,
              color: clrBadge,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 5,
              toY: 4,
              color: clrEdit,
            )
          ],
          showingTooltipIndicators: [0, 1, 2, 3],
        ),
      ];
}
