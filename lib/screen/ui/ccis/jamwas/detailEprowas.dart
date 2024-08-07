import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../src/constant.dart';
import '../../../../src/preference.dart';
import '../../../../src/toast.dart';
import '../constants/api.dart';
import '../constants/defines.dart';

class DetailEprowasPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailEprowasPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailEprowasPage> createState() => _DetailEprowasPageState();
}

class _DetailEprowasPageState extends State<DetailEprowasPage> {
  late Widget body;
  String title = "e-PROWAS";
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

  num lapdu = 0;
  num laporanKlarifikasi = 0;
  num laporanInspeksi = 0;
  num laporanSkph = 0;


  int value1 = 0;
  int value2 = 0;
  int touchedIndexBpk = -1;
  int touchedIndex = -1;
  int touchedGroupIndex = -1;

    num totalEksekusiP48 = 0;
  num totalEksekusiBa17 = 0;
  num totalEksekusiD3 = 0;
  var arrDataEksekusi = [];



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
      var response = await http.post(Uri.parse(ApiService.totalEprowasCasys),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == 200) {
     
        setState(() {
          listData = content['data'];
          lapdu = content['data']['ladpuData'];
          laporanKlarifikasi = content['data']['laporanKlarifikasiData'];
          laporanInspeksi = content['data']['laporanInspeksiKasusData'];
          laporanSkph = content['data']['laporanSKPHDData'];
          print(listData);
          print(lapdu.toString());
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
                    "e-PROWAS",
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
              padding: const EdgeInsets.all(1.0),
              child: Container(
                child: !isProcess
                    ? _buildListInspektorat()
                    : const Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.grey,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Color(0xff3cd2a5)),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListInspektorat() {
    
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ListJdihPage(
            //       accessToken: widget.accessToken,
            //       tahun: widget.tahun,
            //       kodeProgram: "1",
            //       kodeSatker: '2',
            //     ),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
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
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
                title: const Text(
                  "Laporan Pengaduan",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: clrEdit,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  lapdu.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ListJdihPage(
            //       accessToken: widget.accessToken,
            //       tahun: widget.tahun,
            //       kodeProgram: "1",
            //       kodeSatker: '2',
            //     ),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
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
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
                title: const Text(
                  "Laporan Klarifikasi",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: clrEdit,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  laporanKlarifikasi.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ListJdihPage(
            //       accessToken: widget.accessToken,
            //       tahun: widget.tahun,
            //       kodeProgram: "1",
            //       kodeSatker: '2',
            //     ),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
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
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
                title: const Text(
                  "Laporan Inspeksi Kasus",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: clrEdit,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  laporanInspeksi.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) => ListJdihPage(
            //       accessToken: widget.accessToken,
            //       tahun: widget.tahun,
            //       kodeProgram: "1",
            //       kodeSatker: '2',
            //     ),
            //   ),
            // );
          },
          child: Padding(
            padding: const EdgeInsets.all(2),
            child: Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
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
              child: ListTile(
                dense: true,
                contentPadding: const EdgeInsets.only(left: 5.0, right: 5.0),
                title: const Text(
                  "Laporan SKPHD",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: clrEdit,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  laporanSkph.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios_sharp,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ),
      ],
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
