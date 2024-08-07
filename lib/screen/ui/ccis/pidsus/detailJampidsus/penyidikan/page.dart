// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/loader.dart';
import '../../../../../../src/toast.dart';
import '../../../../../widget/custom_button_primary.dart';
import '../../../constants/api.dart';
import 'component/detail.dart';
import 'component/list.dart';

class PenyidikanPidsusPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final accessToken, tahun, bulanAwal, bulanAkhir;

  const PenyidikanPidsusPage({
    super.key,
    required this.accessToken,
    required this.tahun,
    required this.bulanAwal,
    required this.bulanAkhir,
  });

  @override
  State<PenyidikanPidsusPage> createState() => _PenyidikanPidsusPageState();
}

class _PenyidikanPidsusPageState extends State<PenyidikanPidsusPage> {
  int monthNumber = 0;
  String message = "";
  bool isProcess = true;
  List<String> listData = [];

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();
  String totalP8 = "";
  String totalPenyidikTpk = "";
  String totalPenyidikTppu = "";
  String totalLanjut = "";
  String totalTutTpk = "";
  String totalTutTppu = "";
  String totalHenti = "";
  String totalHentiTpk = "";
  String totalHentiTppu = "";
  String selectedStartMonth = ""; // Bulan default
  String selectedStartMonthName = ""; // Bulan default
  String selectedEndMonth = ""; // Bulan default
  String selectedEndMonthName = ""; // Bulan default = ""; // Bulan default

  searchData(tahun, bulanAwal, bulanAkhir) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
      selectedStartMonth = bulanAwal;
      selectedEndMonth = bulanAkhir;
    });

    getData(year.toString(), selectedStartMonth, selectedEndMonth);
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

  getData(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      var response = await http.post(
          Uri.parse(ApiService.countPidsusPenyidikan2),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          listData = [
          totalP8 = content['data']['p8Total'].toString(),
          totalPenyidikTpk = content['data']['p8Data']['jml_penyidikan_tpk'],
          totalPenyidikTppu = content['data']['p8Data']['jml_penyidikan_tppu'],
          totalLanjut = content['data']['lanjutTotal'].toString(),
          totalTutTpk = content['data']['lanjutData']['jml_lanjut_tut_tpk'],
          totalTutTppu = content['data']['lanjutData']['jml_lanjut_tut_tppu'],
          totalHenti = content['data']['hentiTotal'].toString(),
          totalHentiTpk = content['data']['hentiData']['jml_dihentikan_tpk'],
          totalHentiTppu = content['data']['hentiData']['jml_dihentikan_tppu'],
          ];
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context,
          "Tidak ada data penyelidikan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
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

  checkSession() async {
    setState(() {
      year = today.year;
      selectedStartMonth = "01";
      selectedEndMonth = "12";
    });
    yearStart.text = year.toString();
    getData(year.toString(), selectedStartMonth, selectedEndMonth);
  }

  @override
  void initState() {
    checkSession();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
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
                    "assets/icons/LOGO_PIDSUS_SELOKA.png",
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
                    "Penyidikan",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    "JAMPIDSUS",
                    style: TextStyle(color: clrPink, fontSize: 10),
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
            const SizedBox(
              height: 5,
            ),
            !isProcess
                ? PenyidikanPidsusList(data: listData)
                : loaderDialogLead(context),
            Container(
              alignment: Alignment.centerRight,
              child: CustomButtonPrimary(
                text: 'Detail Keseluruhan',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PenyidikanPidsusDetail(
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
          ],
        ),
      ),
    );
  }
}
