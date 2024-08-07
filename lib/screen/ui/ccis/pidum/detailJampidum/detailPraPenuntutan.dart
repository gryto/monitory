import 'dart:convert';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/preference.dart';
import '../../../../../src/toast.dart';
import '../../../../widget/custom_button_primary.dart';
import '../../../../widget/room_widget.dart';
import '../../constants/api.dart';
import 'detailPraPenuntutan2.dart';

class DetailPraPenuntutanPage extends StatefulWidget {
  String accessToken, bulanAwal, bulanAkhir;
  num tahun;
  DetailPraPenuntutanPage({
    Key? key,
    required this.accessToken,
    required this.tahun,
    required this.bulanAwal,
    required this.bulanAkhir,
  }) : super(key: key);

  @override
  State<DetailPraPenuntutanPage> createState() =>
      _DetailPraPenuntutanPageState();
}

class _DetailPraPenuntutanPageState extends State<DetailPraPenuntutanPage> {
  late Widget body;
  String title = "JAMPIDUM";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();
  String selectedStartMonth = ""; // Bulan default
  String selectedStartMonthName = ""; // Bulan default
  String selectedEndMonth = ""; // Bulan default
  String selectedEndMonthName = ""; // Bulan default = ""; // Bulan default

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

  num totalPranuntutan = 0;
  num totalPranuntutanSpdp = 0;
  num totalPranuntutanLayer1 = 0;
  num totalPranuntutanBerkas = 0;

  num totalPenuntutan = 0;

  num totalUpayaHukum = 0;

  num totalHukumanMati = 0;

  List spdpData = [];
  num spdp1 = 0;
  num spdp2 = 0;
  num spdp3 = 0;
  num spdp4 = 0;
  num spdp5 = 0;
  num spdp6 = 0;
  num spdp7 = 0;
  num spdp8 = 0;
  num spdp9 = 0;
  num spdp10 = 0;
  num spdp11 = 0;
  num spdp12 = 0;

  List layerData = [];
  num layer1 = 0;
  num layer2 = 0;
  num layer3 = 0;
  num layer4 = 0;
  num layer5 = 0;
  num layer6 = 0;
  num layer7 = 0;
  num layer8 = 0;
  num layer9 = 0;
  num layer10 = 0;
  num layer11 = 0;
  num layer12 = 0;

  List berkasData = [];
  num berkas1 = 0;
  num berkas2 = 0;
  num berkas3 = 0;
  num berkas4 = 0;
  num berkas5 = 0;
  num berkas6 = 0;
  num berkas7 = 0;
  num berkas8 = 0;
  num berkas9 = 0;
  num berkas10 = 0;
  num berkas11 = 0;
  num berkas12 = 0;

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

  searchData(tahun, bulanAwal, bulanAkhir) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
      selectedStartMonth = bulanAwal;
      selectedEndMonth = bulanAkhir;
    });

    getData(year.toString(), selectedStartMonth, selectedEndMonth);
  }

  getData(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidumDetail2),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      // print("object");
      // print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          //Prapenuntutan - SPDP
          totalPranuntutanSpdp = content['data']['totalSpdp'];
          totalPranuntutanLayer1 = content['data']['totalLayer1'];
          totalPranuntutanBerkas = content['data']['totalBerkasLengkap'];
          // print(totalPranuntutanSpdp);

          spdpData = content['data']['spdpData'];
          spdp1 = spdpData[0]['total'];
          spdp2 = spdpData[1]['total'];
          spdp3 = spdpData[2]['total'];
          spdp4 = spdpData[3]['total'];
          spdp5 = spdpData[4]['total'];
          spdp6 = spdpData[5]['total'];
          spdp7 = spdpData[6]['total'];
          spdp8 = spdpData[7]['total'];
          spdp9 = spdpData[8]['total'];
          spdp10 = spdpData[9]['total'];
          spdp11 = spdpData[10]['total'];
          spdp12 = spdpData[11]['total'];
          // print(spdpData);

          layerData = content['data']['tahap1Data'];
          layer1 = layerData[0]['total'];
          layer2 = layerData[1]['total'];
          layer3 = layerData[2]['total'];
          layer4 = layerData[3]['total'];
          layer5 = layerData[4]['total'];
          layer6 = layerData[5]['total'];
          layer7 = layerData[6]['total'];
          layer8 = layerData[7]['total'];
          layer9 = layerData[8]['total'];
          layer10 = layerData[9]['total'];
          layer11 = layerData[10]['total'];
          layer12 = layerData[11]['total'];

          berkasData = content['data']['berkasLengkapData'];
          berkas1 = berkasData[0]['total'];
          berkas2 = berkasData[1]['total'];
          berkas3 = berkasData[2]['total'];
          berkas4 = berkasData[3]['total'];
          berkas5 = berkasData[4]['total'];
          berkas6 = berkasData[5]['total'];
          berkas7 = berkasData[6]['total'];
          berkas8 = berkasData[7]['total'];
          berkas9 = berkasData[8]['total'];
          berkas10 = berkasData[9]['total'];
          berkas11 = berkasData[10]['total'];
          berkas12 = berkasData[11]['total'];
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
    getData(year.toString(), selectedStartMonth, selectedEndMonth);
  }

  selectyear(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: const Color.fromARGB(255, 13, 30, 46),
          backgroundColor: const Color.fromARGB(255, 13, 30, 46),
          title:
              const Text("Pilih Tahun", style: TextStyle(color: Colors.white)),
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

  @override
  dispose() {
    super.dispose();
  }

  checkSession() async {
    setState(() {
      year = widget.tahun;
      selectedStartMonth = widget.bulanAwal;
      selectedEndMonth = widget.bulanAkhir;
    });

    yearStart.text = year.toString();
    getData(year.toString(), selectedStartMonth, selectedEndMonth);
  }

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  @override
  Widget build(BuildContext context) {
    List<String> monthNumbers = months
        .asMap()
        .map((index, month) {
          int numericValue = index + 1; // Adding 1 to start from 1
          return MapEntry(month,
              numericValue.toString().padLeft(2, '0')); // Adding leading zeros
        })
        .values
        .toList();
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
                    "assets/icons/LOGO_JAMPIDUM.png",
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
                    "Pra Penuntutan",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    "JAMPIDUM",
                    style: TextStyle(color: clrDelete, fontSize: 10),
                  ),
                  Text(
                    "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  )
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
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Periode Tahun ${yearStart.text}",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      Text(
                        "Bulan Awal: $selectedStartMonthName",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                      Text(
                        "Bulan Akhir: $selectedEndMonthName ",
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Colors.white),
                      ),
                    ],
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
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600),
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
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              labelText: "Awal Bulan",
                                              labelStyle: const TextStyle(
                                                  color: Colors.white),
                                              hintStyle: const TextStyle(
                                                  color: Colors.white),
                                              hintText: 'Pilih bulan',
                                              focusColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            dropdownColor: const Color.fromARGB(
                                                255, 13, 30, 46),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            value: selectedStartMonth,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedStartMonth = newValue!;
                                                print(selectedStartMonth);

                                                // Map selected numeric month to corresponding month name
                                                selectedStartMonthName = monthNumbers
                                                    .where((numericMonth) =>
                                                        numericMonth ==
                                                        selectedStartMonth)
                                                    .map((numericMonth) =>
                                                        months[int.parse(
                                                                numericMonth) -
                                                            1])
                                                    .first; // Get the first (and only) element

                                                print(selectedStartMonthName);
                                              });
                                            },
                                            items: monthNumbers
                                                .map((String numericMonth) {
                                              String monthName = months[
                                                  int.parse(numericMonth) - 1];

                                              return DropdownMenuItem<String>(
                                                value: numericMonth,
                                                child: Text(
                                                  monthName,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 8.0),
                                          child:
                                              DropdownButtonFormField<String>(
                                            decoration: InputDecoration(
                                              fillColor: Colors.white,
                                              labelText: "Akhir Bulan",
                                              labelStyle: const TextStyle(
                                                  color: Colors.white),
                                              hintStyle: const TextStyle(
                                                  color: Colors.white),
                                              hintText: 'Pilih bulan',
                                              focusColor: Colors.white,
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            dropdownColor: const Color.fromARGB(
                                                255, 13, 30, 46),
                                            style: const TextStyle(
                                                color: Colors.white),
                                            value: selectedEndMonth,
                                            onChanged: (String? newValue) {
                                              setState(() {
                                                selectedEndMonth = newValue!;
                                                print(selectedEndMonth);

                                                // Map selected numeric month to corresponding month name
                                                selectedEndMonthName = monthNumbers
                                                    .where((numericMonth) =>
                                                        numericMonth ==
                                                        selectedEndMonth)
                                                    .map((numericMonth) =>
                                                        months[int.parse(
                                                                numericMonth) -
                                                            1])
                                                    .first; // Get the first (and only) element

                                                print(selectedEndMonthName);
                                              });
                                            },
                                            items: monthNumbers
                                                .map((String numericMonth) {
                                              String monthName = months[
                                                  int.parse(numericMonth) - 1];
                                              return DropdownMenuItem<String>(
                                                value: numericMonth,
                                                child: Text(
                                                  monthName,
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const SizedBox(
                                          height: 10.0,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            Navigator.pop(context);
                                            searchData(
                                              yearStart.text,
                                              selectedStartMonth,
                                              selectedEndMonth,
                                            );
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
                                title: "Total SPDP",
                                colorIcon: clrWait,
                                count: totalPranuntutanSpdp.toString()),
                            RoomContainer(
                                onTap: () {},
                                title: "Tahap I",
                                colorIcon: clrBadge,
                                count: totalPranuntutanLayer1.toString()),
                            RoomContainer(
                                onTap: () {},
                                title: "Berkas lengkap",
                                colorIcon: clrDelete,
                                count: totalPranuntutanBerkas.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: CustomButtonPrimary(
                text: 'Detail Keseluruhan',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailPraPenuntutan2Page(
                        accessToken: widget.accessToken,
                        tahun: year.toString(),
                        bulanAwal: selectedStartMonth,
                        bulanAkhir: selectedEndMonth,
                      ),
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 5, right: 5),
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'SPDP',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ( Periode - 2023 )',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 0),
                                  width: 350,
                                  height: 150,
                                  child: !isProcess
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 8),
                                          width: 310,
                                          height: 150,
                                          child: LineChart(
                                            LineChartData(
                                              gridData: FlGridData(show: true),
                                              borderData:
                                                  FlBorderData(show: false),
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
                                                    getTitlesWidget:
                                                        leftTitleWidgets,
                                                    interval: 1000,
                                                    reservedSize: 20,
                                                  ),
                                                ),
                                                bottomTitles: AxisTitles(
                                                  sideTitles: SideTitles(
                                                    showTitles: true,
                                                    getTitlesWidget: getTitles,
                                                    interval: 1,
                                                    reservedSize: 10,
                                                  ),
                                                ),
                                              ),
                                              lineBarsData: [
                                                LineChartBarData(
                                                  color: clrPrimary,
                                                  spots: [
                                                    FlSpot(0, spdp1.toDouble()),
                                                    FlSpot(1, spdp2.toDouble()),
                                                    FlSpot(2, spdp3.toDouble()),
                                                    FlSpot(3, spdp4.toDouble()),
                                                    FlSpot(4, spdp5.toDouble()),
                                                    FlSpot(5, spdp6.toDouble()),
                                                    FlSpot(6, spdp7.toDouble()),
                                                    FlSpot(7, spdp8.toDouble()),
                                                    FlSpot(8, spdp9.toDouble()),
                                                    FlSpot(
                                                        9, spdp10.toDouble()),
                                                    FlSpot(
                                                        10, spdp11.toDouble()),
                                                    FlSpot(
                                                        11, spdp12.toDouble()),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),

            ///
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 5, right: 5),
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Tahap I',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ( Periode - 2023 )',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  width: 350,
                                  height: 150,
                                  child: !isProcess
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 8),
                                          width: 310,
                                          height: 150,
                                          child: LineChart(
                                            LineChartData(
                                              gridData: FlGridData(show: true),
                                              borderData:
                                                  FlBorderData(show: false),
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
                                                    getTitlesWidget:
                                                        leftTitleWidgets,
                                                    interval: 1000,
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
                                                  color: clrBadge,
                                                  spots: [
                                                    FlSpot(
                                                        0, layer1.toDouble()),
                                                    FlSpot(
                                                        1, layer2.toDouble()),
                                                    FlSpot(
                                                        2, layer3.toDouble()),
                                                    FlSpot(
                                                        3, layer4.toDouble()),
                                                    FlSpot(
                                                        4, layer5.toDouble()),
                                                    FlSpot(
                                                        5, layer6.toDouble()),
                                                    FlSpot(
                                                        6, layer7.toDouble()),
                                                    FlSpot(
                                                        7, layer8.toDouble()),
                                                    FlSpot(
                                                        8, layer9.toDouble()),
                                                    FlSpot(
                                                        9, spdp10.toDouble()),
                                                    FlSpot(
                                                        10, spdp11.toDouble()),
                                                    FlSpot(
                                                        11, spdp12.toDouble()),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
            ////
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 5, right: 5),
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
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'Berkas Lengkap',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ( Periode - 2023 )',
                                      style: TextStyle(
                                        color: Colors.white,
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
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  width: 350,
                                  height: 150,
                                  child: !isProcess
                                      ? Container(
                                          padding: const EdgeInsets.only(
                                              right: 15, top: 8),
                                          width: 310,
                                          height: 150,
                                          child: LineChart(
                                            LineChartData(
                                              gridData: FlGridData(show: true),
                                              borderData:
                                                  FlBorderData(show: false),
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
                                                    getTitlesWidget:
                                                        leftTitleWidgets,
                                                    interval: 1000,
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
                                                    FlSpot(
                                                        0, berkas1.toDouble()),
                                                    FlSpot(
                                                        1, berkas2.toDouble()),
                                                    FlSpot(
                                                        2, berkas3.toDouble()),
                                                    FlSpot(
                                                        3, berkas4.toDouble()),
                                                    FlSpot(
                                                        4, berkas5.toDouble()),
                                                    FlSpot(
                                                        5, berkas6.toDouble()),
                                                    FlSpot(
                                                        6, berkas7.toDouble()),
                                                    FlSpot(
                                                        7, berkas8.toDouble()),
                                                    FlSpot(
                                                        8, berkas9.toDouble()),
                                                    FlSpot(
                                                        9, spdp10.toDouble()),
                                                    FlSpot(
                                                        10, spdp11.toDouble()),
                                                    FlSpot(
                                                        11, spdp12.toDouble()),
                                                  ],
                                                ),
                                              ],
                                            ),
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
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
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

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 8,
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
