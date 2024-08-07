import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/preference.dart';
import '../../../../../../src/toast.dart';
import '../../../../../widget/custom_button_primary.dart';
import '../../../../../widget/room_widget.dart';
import '../../../constants/api.dart';
import '../../../shared_components/chart/chart_indicator.dart';
import 'ptsp/detailKunjungan.dart';

class DetailPtspPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailPtspPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailPtspPage> createState() => _DetailPtspPageState();
}

class _DetailPtspPageState extends State<DetailPtspPage> {
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

  List listData = [];
  List arrSatkerId = [];
  List arrBidangId = [];
  List listDataSatker = [];
  String dropdownValue = '';
  String dropdownName = "";
  String slugSatker = "";

  num totalKunjungan = 0;
  num totalKendaraan = 0;

  List listTipeSurvei = [];
  num lineSurvei0 = 0;
  num lineSurvei1 = 0;
  num lineSurvei2 = 0;
  num lineSurvei3 = 0;
  num lineSurvei4 = 0;
  String textSurvei0 = "";
  String textSurvei1 = "";
  String textSurvei2 = "";
  String textSurvei3 = "";
  String textSurvei4 = "";

  List listTipePelayanan = [];
  num linePelayanan0 = 0;
  num linePelayanan1 = 0;
  num linePelayanan2 = 0;
  num linePelayanan3 = 0;
  num linePelayanan4 = 0;
  num linePelayanan5 = 0;
  num linePelayanan6 = 0;
  String textPelayanan0 = "";
  String textPelayanan1 = "";
  String textPelayanan2 = "";
  String textPelayanan3 = "";
  String textPelayanan4 = "";
  String textPelayanan5 = "";
  String textPelayanan6 = "";

  List listTipeTamu = [];
  num lineTamu0 = 0;
  num lineTamu1 = 0;
  num lineTamu2 = 0;
  num lineTamu3 = 0;
  num lineTamu4 = 0;
  num lineTamu5 = 0;
  String textTamu0 = "";
  String textTamu1 = "";
  String textTamu2 = "";
  String textTamu3 = "";
  String textTamu4 = "";
  String textTamu5 = "";

  int touchedIndexBpk = -1;
  int touchedIndex = -1;
  int touchedGroupIndex = -1;

  int cariTahun = 1;

  searchData(tahun) {
    setState(() {
      isProcess = true;
      // listData.clear();
      year = int.parse(tahun);
      dropdownValue = slugSatker;
    });

    getData(year.toString());
    // getData(year.toString(), dropdownValue);
  }

  searchDataSatker(slugSatker) {
    setState(() {
      isProcess = true;
      // listData.clear();
      dropdownValue = slugSatker;
    });

    getData(year.toString());
  }

  getData(tahun) async {
    try {
      var params = jsonEncode({"bulan": "", "tahun": tahun.toString()});
      var response = await http.post(Uri.parse(ApiService.countTamuCasys),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalKunjungan = content['data']['total_kunjungan'];
          totalKendaraan = content['data']['total_kendaraan'];

          listTipeSurvei = content['data']['tipe_survei'];
          lineSurvei0 = listTipeSurvei[0]['total'];
          lineSurvei1 = listTipeSurvei[1]['total'];
          lineSurvei2 = listTipeSurvei[2]['total'];
          lineSurvei3 = listTipeSurvei[3]['total'];
          lineSurvei4 = listTipeSurvei[4]['total'];
          textSurvei0 = listTipeSurvei[0]['kategori'];
          textSurvei1 = listTipeSurvei[1]['kategori'];
          textSurvei2 = listTipeSurvei[2]['kategori'];
          textSurvei3 = listTipeSurvei[3]['kategori'];
          textSurvei4 = listTipeSurvei[4]['kategori'];

          listTipePelayanan = content['data']['tipe_pelayanan'];
          linePelayanan0 = listTipePelayanan[0]['total'];
          linePelayanan1 = listTipePelayanan[1]['total'];
          linePelayanan2 = listTipePelayanan[2]['total'];
          linePelayanan3 = listTipePelayanan[3]['total'];
          linePelayanan4 = listTipePelayanan[4]['total'];
          linePelayanan5 = listTipePelayanan[5]['total'];
          linePelayanan6 = listTipePelayanan[6]['total'];
          textPelayanan0 = listTipePelayanan[0]['kategori'];
          textPelayanan1 = listTipePelayanan[1]['kategori'];
          textPelayanan2 = listTipePelayanan[2]['kategori'];
          textPelayanan3 = listTipePelayanan[3]['kategori'];
          textPelayanan4 = listTipePelayanan[4]['kategori'];
          textPelayanan5 = listTipePelayanan[5]['kategori'];
          textPelayanan6 = listTipePelayanan[6]['kategori'];

          listTipeTamu = content['data']['tipe_tamu'];
          lineTamu0 = listTipeTamu[0]['total'];
          lineTamu1 = listTipeTamu[1]['total'];
          lineTamu2 = listTipeTamu[2]['total'];
          lineTamu3 = listTipeTamu[3]['total'];
          lineTamu4 = listTipeTamu[4]['total'];
          lineTamu5 = listTipeTamu[5]['total'];
          textTamu0 = listTipeTamu[0]['kategori'];
          textTamu1 = listTipeTamu[1]['kategori'];
          textTamu2 = listTipeTamu[2]['kategori'];
          textTamu3 = listTipeTamu[3]['kategori'];
          textTamu4 = listTipeTamu[4]['kategori'];
          textTamu5 = listTipeTamu[5]['kategori'];
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

  getDataSatker() async {
    try {
      var response = await http.get(
        Uri.parse(ApiService.listTamuSatkerCasys),
        headers: {
          "Content-Type": "application/json",
          "sidac_token": widget.accessToken
        },
      );
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          listDataSatker = content['data'];
          for (int i = 0; i < listDataSatker.length; i++) {
            arrBidangId.add(listDataSatker[i]['slug']);
          }
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
    getDataSatker();
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
      slugSatker = "kejaksaan-agung-republik-indonesia";
      year = today.year;
    });

    dropdownValue = slugSatker;
    yearStart.text = year.toString();
    getData(year.toString());
    getDataSatker();
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
                    "PTSP",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "BIRO UMUM - JAMBIN",
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
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
                    builder: (BuildContext context, setState) => SafeArea(
                      child: Container(
                        color: const Color.fromARGB(255, 13, 30, 46),
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
                              padding: const EdgeInsets.only(top: 8.0),
                              child: DropdownButtonFormField<String>(
                                borderRadius: BorderRadius.circular(10),
                                dropdownColor:
                                    const Color.fromARGB(255, 13, 30, 46),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  labelText: "Satker",
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: 'Pilih satker',
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: const TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                                items: listDataSatker.map(
                                  (item) {
                                    return DropdownMenuItem<String>(
                                      value: item['slug'].toString(),
                                      child: Text(
                                        item['nama_satker'].toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  },
                                ).toList(),
                                onChanged: (newValue) async {
                                  int indexBidang = 0;
                                  for (int ix = 0;
                                      ix < arrBidangId.length;
                                      ix++) {
                                    if (arrBidangId[ix].toString() ==
                                        newValue) {
                                      indexBidang = ix;
                                    }
                                  }
                                  print(indexBidang);

                                  setState(
                                    () {
                                      dropdownValue = newValue!;
                                      dropdownName = listDataSatker[indexBidang]
                                              ['nama_satker']
                                          .toString();
                                    },
                                  );
                                  print(dropdownValue);

                                  print(dropdownName.toString());
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Pilih Satker Terlebih Dahulu!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                searchDataSatker(dropdownValue);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: clrBadge,
                                  borderRadius: BorderRadius.circular(10),
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
        backgroundColor: clrBadge,
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Periode Tahun ${yearStart.text}",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
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
                                            style: const TextStyle(
                                                color: Colors.white),
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
            Text(
              " Satker: $dropdownName",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600),
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
                                title: "Total Kunjungan",
                                colorIcon: clrWait,
                                count: totalKunjungan.toString()),
                            RoomContainer(
                                onTap: () {},
                                title: "Total Kendaraan",
                                colorIcon: clrBadge,
                                count: totalKendaraan.toString()),
                          ],
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
              alignment: Alignment.centerRight,
              child: CustomButtonPrimary(
                text: 'Detail Keseluruhan',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailKunjunganPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 15,
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
                                        'Data Survei Buku Tamu',
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
                                        sectionsSpace: 1,
                                        centerSpaceRadius: 30,
                                        sections: showingSectionsBpk(),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Indicator(
                                          color: clrWait,
                                          text: textSurvei3,
                                          isSquare: true,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrPrimary,
                                          text: textSurvei0,
                                          isSquare: true,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrBadge,
                                          text: textSurvei1,
                                          isSquare: true,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrDelete,
                                          text: textSurvei2,
                                          isSquare: true,
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Indicator(
                                          color: clrSecondary,
                                          text: textSurvei4,
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
                                        'Data Tipe Pelayanan',
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
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData,
                                  borderData: borderData,
                                  barGroups: barGroups,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceEvenly,
                                  maxY: 180000,
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
                                        'Data Tipe Tamu',
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
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData1,
                                  borderData: borderData,
                                  barGroups: barGroups1,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceEvenly,
                                  maxY: 170000,
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

  List<PieChartSectionData> showingSectionsBpk() {
    return List.generate(5, (i) {
      final isTouched = i == touchedIndexBpk;
      final fontSize = isTouched ? 20.0 : 14.0;
      final radius = isTouched ? 60.0 : 50.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: clrWait,
            value: lineSurvei0.toDouble(),
            title: lineSurvei0.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: clrPrimary,
            value: lineSurvei1.toDouble(),
            title: lineSurvei1.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: clrBadge,
            value: lineSurvei2.toDouble(),
            title: lineSurvei2.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 3:
          return PieChartSectionData(
            color: clrDelete,
            value: lineSurvei3.toDouble(),
            title: lineSurvei3.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          );
        case 4:
          return PieChartSectionData(
            color: clrSecondary,
            value: lineSurvei4.toDouble(),
            title: lineSurvei4.toString(),
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
              reservedSize: 25,
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
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = textPelayanan0;
        break;
      case 1:
        label = textPelayanan1;
        break;
      case 2:
        label = textPelayanan2;
        break;
      case 3:
        label = textPelayanan3;
        break;
      case 4:
        label = textPelayanan4;
        break;
      case 5:
        label = textPelayanan5;
        break;
      case 6:
        label = textPelayanan6;
        break;
    }

    Widget text;
    text = SizedBox(
        height: 20,
        width: 30,
        child: Text(
          label,
          style: style,
          maxLines: 2,
        ));

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }

  Widget bottomtitles1(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = textTamu0;
        break;
      case 1:
        label = textTamu1;
        break;
      case 2:
        label = textTamu2;
        break;
      case 3:
        label = textTamu3;
        break;
      case 4:
        label = textTamu4;
        break;
      case 5:
        label = textTamu5;
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
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: linePelayanan0.toDouble(),
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: linePelayanan1.toDouble(),
              color: clrWait,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: linePelayanan2.toDouble(),
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: linePelayanan3.toDouble(),
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: linePelayanan4.toDouble(),
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: linePelayanan5.toDouble(),
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: linePelayanan6.toDouble(),
              color: clrWait,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];

  List<BarChartGroupData> get barGroups1 => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: lineTamu0.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: lineTamu1.toDouble(),
              color: clrPink,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: lineTamu2.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: lineTamu3.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: lineTamu4.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              width: 30,
              borderRadius: BorderRadius.circular(5),
              toY: lineTamu5.toDouble(),
              color: clrPink,
            )
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
