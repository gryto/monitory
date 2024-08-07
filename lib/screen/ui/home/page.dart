import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:intl/intl.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/preference.dart';
import '../../../src/toast.dart';
import '../../widget/slider.dart';
import '../chart/monitoringActivity.dart';
import '../chart/monitoringActivityBidang.dart';
import '../notifikasi/page.dart';
import '../reporting/report_page.dart';
import '../setting/component/info.dart';
import '../setting/page.dart';
import 'scanner.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  List<String> last7Days = [];

  String dropdownValue = '';
  String fullName = "";
  String typeUser = "";
  String id = "";
  String path = "";
  String dateString = "";
  // ignore: unused_field
  String _scanBarcode = 'Unknown';
  List arrMonthsIndex = [];
  String dropdownName = "";
  String search = "";
  int bulannkkk = DateTime.now().month;
  // String bulan = Date.parse.bulan1;
  late var bulans = bulannkkk;
  int tahun = DateTime.now().year;
  late var tahuns = tahun;

  String month = "";
  var year = 10;

  String line1 = "";
  String line2 = "";
  String line3 = "";
  String line4 = "";
  String line5 = "";
  String line6 = "";
  String line7 = "";

  num summAset = 0;
  num totalAsetMasuk = 0;
  num totalAsetKeluar = 0;
  int maxLinechart = 0;
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

  List dataPiechart0 = [];
  List dataPiechart1 = [];
  List dataPiechart2 = [];
  num pieVal0 = 0;
  num pieVal1 = 0;
  num pieVal2 = 0;
  num pieVal3 = 0;
  num pieVal4 = 0;

  String pieTxt0 = "";
  String pieTxt1 = "";
  String pieTxt2 = "";
  String pieTxt3 = "";
  String pieTxt4 = "";

  List dataTotal = [];
  List dataTotalMasuk = [];
  List dataTotalKeluar = [];
  num totalAll = 0;
  num totalMasuk = 0;
  num totalKeluar = 0;

  void checkSession() async {
    var userFullname = await sharedPref.getPref("name");
    var userRole = await sharedPref.getPref("level");
    var userId = await sharedPref.getPref("id");
    var userPath = await sharedPref.getPref("path");
    

    setState(() {
      fullName = userFullname;
      typeUser = userRole == "1"
          ? 'Administrator'
          : userRole == "2"
              ? 'Pimpinan'
              : 'User';
      id = userId;
      path = userPath;

      for (int i = 0; i < months.length; i++) {
        arrMonthsIndex.add(months[i]);
      }
    });

    await getDataMonitoring(months, years);
    await getDataAset();
    getLast7Days();
    // await getDataTotalAset();
    await searchData(selectedMonthIndex, selectedYear);
  }

  searchData(selectedMonthIndex, selectedYear) async {
    month = selectedMonthIndex;
    year = selectedYear;
  }

  Future<void> _pullRefresh() async {
    setState(() {
      searchData(selectedMonthIndex, selectedYear);
      getDataMonitoring(month, year);
      getDataAset();
      // getDataTotalAset();
    });
  }

  getDataMonitoring(month, year) async {
    setState(() {
      isProcess = true;
    });

    try {
      final params = {
        'bulan': bulans.toString(),
        'tahun': tahuns.toString(),
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
          month;
          year;
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
        // onBasicAlertPressed(context, content['status'], content['message']);
      }
    } catch (e) {
      // onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getDataAset() async {
    setState(() {
      isProcess = false;
    });

    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.dataAset;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          dataPiechart0 = content['data']['aset1'];
          dataPiechart1 = content['data']['aset2'];
          dataPiechart2 = content['data']['aset3'];
          pieVal0 = dataPiechart0[0]['aset1'];
          pieVal1 = dataPiechart1[0]['aset2'];
          pieVal2 = dataPiechart2[0]['aset3'];

          pieTxt0 = dataPiechart0[0]['title'];
          pieTxt1 = dataPiechart1[1]['title'];
          pieTxt2 = dataPiechart2[2]['title'];
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

  Future<void> editData(Map row) async {
    final route = MaterialPageRoute(
      builder: (context) => InfoUser(todo: row),
    );
    Navigator.push(context, route);
  }

  Future<void> scanQR(ctx) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);

      checkQr(ctx, barcodeScanRes.toString());
    } on PlatformException {
      barcodeScanRes = 'Gagal mendapatkan versi platform.';
    }
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  checkQr(ctx, code) {
    if (code != "-1") {
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (context) => ScanDokumen(
            url: code,
          ),
        ),
      );
    } else {
      toastShort(ctx, "Kode QR tidak ditemukan.");
    }
  }

  _launchURL(ctx, String urlQRCode) async {
    String url = urlQRCode;
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
      Navigator.of(ctx).push(
        MaterialPageRoute(
          builder: (context) => ScanDokumen(
            url: urlQRCode,
          ),
        ),
      );
    } else {
      throw 'Could not launch $url';
    }
  }

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

  List<int> years =
      List.generate(3, (int index) => DateTime.now().year - index);

  String selectedMonth = '';
  int selectedYear = 0;
  String selectedMonthIndex = '';

  @override
  void initState() {
    checkSession();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  int touchedIndex = -1;
  int touchedGroupIndex = -1;
  final double width = 7;

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  // late final bool show;
  late final AxisTitles leftTitles;
  late final AxisTitles topTitles;
  late final AxisTitles rightTitles;
  late final AxisTitles bottomTitles;

  List<String> getLast7Days() {
    DateTime today = DateTime.now();

    // Tambahkan tanggal 7 hari terakhir ke dalam list
    for (int i = 6; i >= 0; i--) {
      last7Days.add(
          DateFormat('dd-MM-yyyy').format(today.subtract(Duration(days: i))));
    }
    setState(() {
      line1 = last7Days[0];
      line2 = last7Days[1];
      line3 = last7Days[2];
      line4 = last7Days[3];
      line5 = last7Days[4];
      line6 = last7Days[5];
      line7 = last7Days[6];
    });

    return last7Days;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        elevation: 0,
        title: Padding(
            padding: const EdgeInsets.only(top: 35, bottom: 30),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingLogic(id: id),
                  ),
                );
              },
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 18,
                      backgroundImage: NetworkImage(
                        path,
                        scale: 10,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        fullName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        typeUser,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
        actions: [
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const ReportPage(),
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      color: clrPrimary),
                  child: const Icon(
                    Icons.note_add,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const NotifikasiPage(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                  color: clrPrimary),
              child: const Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: clrPrimary,
        onRefresh: () async {
          await Future.delayed(const Duration(milliseconds: 1500));
          setState(() {
            isProcess = true;
            listData.clear();
            _pullRefresh();
          });
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      height: 60,
                      decoration: const BoxDecoration(color: clrPrimary),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(15),
                      child: IntegrationSlider(),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(13),
                    ),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: clrShadow,
                              blurRadius: 1.0,
                              spreadRadius: 0.5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        height: 230,
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
                                     Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        const Text(
                                          'Data Monitoring Kegiatan',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          ' ( Periode - $tahun)',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 8),
                                      width: 310,
                                      height: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child: const MonitoringActivityChart(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, left: 5, right: 5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                          boxShadow: const [
                            BoxShadow(
                              color: clrShadow,
                              blurRadius: 1.0,
                              spreadRadius: 0.5,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                        height: 245,
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
                                     Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Data Monitoring Peserta Kegiatan Per-Bidang',
                                          style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          '( Periode - $tahun )',
                                          style: const TextStyle(
                                            color: Colors.black54,
                                            fontSize: 11,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(
                                          right: 15, top: 8),
                                      width: 310,
                                      height: 150,
                                      decoration: const BoxDecoration(
                                        color: Colors.white,
                                      ),
                                      child:
                                          const MonitoringActivityBidangChart(),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          scanQR(context);
        },
        label: const Text(
          'Pindai QR',
          style: TextStyle(color: Colors.white),
        ),
        icon: const Icon(
          Icons.qr_code_2,
          color: Colors.white,
        ),
        backgroundColor: clrBadge,
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
                color: clrPrimary,
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
            reservedSize: 30,
            getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 15,
              interval: 1,
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

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: lineVal0.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              toY: lineVal8.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: lineVal1.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              toY: lineVal9.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: lineVal2.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              toY: lineVal10.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: lineVal3.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              toY: lineVal11.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: lineVal4.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              toY: lineVal12.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: lineVal5.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              toY: lineVal13.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: lineVal6.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              toY: lineVal14.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: lineVal7.toDouble(),
              color: clrWait,
            ),
            BarChartRodData(
              toY: lineVal15.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0, 1],
        ),
      ];

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
        label = lineTxt0;
        break;
      case 1:
        label = lineTxt1;
        break;
      case 2:
        label = lineTxt2;
        break;
      case 3:
        label = lineTxt3;
        break;
      case 4:
        label = lineTxt4;
        break;
      case 5:
        label = lineTxt5;
        break;
      case 6:
        label = lineTxt6;
        break;
      case 7:
        label = lineTxt7;
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
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = line1;
        break;
      case 1:
        label = line2;
        break;
      case 2:
        label = line3;
        break;
      case 3:
        label = line4;
        break;
      case 4:
        label = line5;
        break;
      case 5:
        label = line6;
        break;
      case 6:
        label = line7;
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
