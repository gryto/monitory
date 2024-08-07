import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/preference.dart';
import '../../../../../../src/toast.dart';
import '../../../constants/api.dart';

class DetailSimkari2Page extends StatefulWidget {
  final String accessToken, tahun;
  const DetailSimkari2Page(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailSimkari2Page> createState() => _DetailSimkari2PageState();
}

class _DetailSimkari2PageState extends State<DetailSimkari2Page> {
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
                    "SIMKARI (Detail Kepegawaian)",
                    style: TextStyle(color: Colors.white, fontSize: 16),
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
        child: Padding(
          padding:
              const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
          child: Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(child: _buildListInspektorat()),
          ),
        ),
      ),
    );
  }

  Widget _buildListInspektorat() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(5.0),
        padding: const EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff3cd2a5)),
          borderRadius: BorderRadius.circular(10),
        ),
        child: const ListTile(
          dense: true,
          contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
          title: Text(
            "Nama Lengkap : -",
            maxLines: 2,
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
                "Jabatan : -",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                "Satuan Kerja : -",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
              Text(
                "Detail : -",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
