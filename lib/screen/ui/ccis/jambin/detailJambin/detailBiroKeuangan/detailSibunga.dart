import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/loader.dart';
import '../../../../../../src/preference.dart';
import '../../../../../../src/toast.dart';
import '../../../constants/api.dart';

class DetailSibungaPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailSibungaPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailSibungaPage> createState() => _DetailSibungaPageState();
}

class _DetailSibungaPageState extends State<DetailSibungaPage> {
  late Widget body;
  String title = "SAKTI";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();

  List listData = [];
  List listDataTop = [];
  String kegiatan = "";
  String total = "";

  int value1 = 0;
  int value2 = 0;
  int touchedIndexBpk = -1;
  int touchedIndex = -1;
  int touchedGroupIndex = -1;

  searchData(tahun) {
    setState(() {
      listData.clear();
      isProcess = true;
      year = int.parse(tahun);
    });

    getData(year.toString());
    getDataTop(year.toString());
  }

  getData(tahun) async {
    try {
      var params = jsonEncode({
        "satker": "kejaksaan-agung-republik-indonesia",
        "tahun": tahun.toString()
      });
      var response = await http.post(Uri.parse(ApiService.countKeuangan),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          for (int i = 0;
              i < content['data']['kategori_kegiatan'].length;
              i++) {
            listData.add(content['data']['kategori_kegiatan'][i]);
          }
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

  getDataTop(tahun) async {
    try {
      var params = jsonEncode({
        "satker": "kejaksaan-agung-republik-indonesia",
        "tahun": tahun.toString()
      });
      var response = await http.post(Uri.parse(ApiService.topKeuangan),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          listDataTop = content['data'];
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
    getDataTop(year.toString());
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
    getDataTop(year.toString());
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
                    "SI-BUNGA",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "BIRO KEUANGAN - JAMBIN",
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
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                  child: !isProcess
                      ? _buildListInspektorat()
                      : loaderDialog(context)),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
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
                height: 420,
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
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'Informasi Biaya Mutasi',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(left: 8, top: 8),
                              width: 350,
                              height: 150,
                              child:PieChart(
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
                                              touchedIndex = -1;
                                              return;
                                            }
                                            touchedIndex = pieTouchResponse
                                                .touchedSection!
                                                .touchedSectionIndex;
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
                                  ),
                               
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            SizedBox(
                              height: 20,
                              width: 350,
                              // width:  MediaQuery.of(context).size.width * 0.82,
                              // height: MediaQuery.of(context).size.height * 0.02,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        height: 8,
                                        width: 8,
                                        decoration: const BoxDecoration(
                                            color: clrDelete),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Telah Digunakan",style:TextStyle(color: Colors.white)),
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
                                            color: clrBadge),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Sisa Anggaran",style:TextStyle(color: Colors.white)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            const SizedBox(
                              height: 150,
                              width: 350,
                              // width:  MediaQuery.of(context).size.width * 0.82,
                              // height: MediaQuery.of(context).size.height * 0.02,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Pagu          : Rp. 36.462.252.000",style:TextStyle(color: Colors.white)),
                                  Text("Digunakan : 	Rp. 28.104.448.965",style:TextStyle(color: Colors.white)),
                                  Text("Sisa Pagu. :	Rp. 8.357.803.035",style:TextStyle(color: Colors.white)),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text("Jumlah Berkas Diterima	:	2.274 Berkas",style:TextStyle(color: Colors.white)),
                                  Text(
                                      "Telah Selesai                   	:	1.890 Berkas",style:TextStyle(color: Colors.white)),
                                  Text(
                                      "Dalam Proses                  	:	384 Berkas",style:TextStyle(color: Colors.white)),
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

  Widget _buildListInspektorat() {
    // double w = MediaQuery.of(context).size.width - 0;
    // if (listData.isNotEmpty) {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Aang Masuda",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,color: Colors.white
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                          
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Achmad Aliudin",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Adhyaksa Darma Yuliano, SH, MH",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Adi Prayitno",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Agus Sabungan, SH, S.Kom",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Apsari Dewi, SH, LL, M, Ph D",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Asri Puspita Paraswati, SE",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Bagus Nur Jakfar Adi Saputro, SH",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: Beti Wulandari, SH MH",
                      maxLines: 10,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Column(
                children: [
                  ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama PPK: 	Bunga Roselina Pandiangan, SH MH",
                      maxLines: 10,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "NIP PPK : 19760816995121001",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Pagu PPK : Rp. 2.851.816.281.000",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Jumlah Pencairan : Rp. 456.219.694.930",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Persentase Pencairan : 16.00%",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Keterangan : Keterangan",
                          style: TextStyle(fontSize: 12,color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> showingSections(val1, val2) {
    return List.generate(
      2,
      (i) {
        final isTouched = i == touchedIndex;
        const color0 = clrBadge;
        const color1 = clrDelete;

        switch (i) {
          case 0:
            return PieChartSectionData(
              color: color0,
              value: 5,
              title: 'Sisa Anggaran \n 8357803035',
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
              value: 8,
              title: 'Telah Digunakan \n 28462252000',
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
