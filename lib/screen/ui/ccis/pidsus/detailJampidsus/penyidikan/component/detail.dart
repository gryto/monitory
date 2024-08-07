import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../../../src/constant.dart';
import '../../../../../../../src/loader.dart';
import '../../../../../../../src/preference.dart';
import '../../../../../../../src/toast.dart';
import '../../../../constants/api.dart';
import 'detail2.dart';

// ignore: must_be_immutable
class PenyidikanPidsusDetail extends StatefulWidget {
  String accessToken, tahun, bulanAwal, bulanAkhir;
  PenyidikanPidsusDetail({
    Key? key,
    required this.accessToken,
    required this.tahun,
    required this.bulanAwal,
    required this.bulanAkhir,
  }) : super(key: key);

  @override
  State<PenyidikanPidsusDetail> createState() =>
      _PenyidikanPidsusDetailState();
}

class _PenyidikanPidsusDetailState extends State<PenyidikanPidsusDetail> {
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
  String selectedListLayer2 = "";
  String selectedListType = "";
  String selectedKejati = "";
  String selectedKejari = "";
  String selectedCabang = "";

  num totaldata = 0;
  List listData = [];
  List listDataSatker = [];
  List<String> kejati = [];
  List<String> kejari = [];
  List<String> cabang = [];
  List arrBidangId = [];
  List<String> arrSatker = [];
  String satkerLength = '';

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

  List<String> listLayer2 = ['DILANJUTKAN KE PENUNTUTAN', 'P8', 'PENYIDIKAN DIHENTIKAN'];

  List<String> listType = [
    'TP. KORUPSI', 'TPPU ASAL TP. KORUPSI'
  ];

  searchData(
      tahun, bulanAwal, bulanAkhir, layer2, tahapan, kejati, kejari, cabang) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
      selectedStartMonth = bulanAwal;
      selectedEndMonth = bulanAkhir;
      selectedListLayer2 = layer2;
      selectedListType = tahapan;
      selectedKejati = kejati;
      selectedKejari = kejari;
      selectedCabang = cabang;
    });

    getData(
        year.toString(),
        selectedStartMonth,
        selectedEndMonth,
        selectedListLayer2,
        selectedListType,
        selectedKejati,
        selectedKejari,
        selectedCabang);
    getDataSatker();
  }

  getData(tahun, bulanAwal, bulanAkhir, layer2, tahapan, kejati, kejari,
      cabang) async {
    try {
      var params = jsonEncode({
        "id_kejati": kejati,
        "id_kejari": kejari,
        "id_cabjari": cabang,
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
        "layer2": layer2, //spdp, tahap1, berkas_lengkap
        "type": tahapan //
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(
          Uri.parse(ApiService.countPidsusPenyidikan3),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          listData = content['data']['data'];
          totaldata = listData.length;
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
        Uri.parse(ApiService.pidumSatker),
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
            String satkerCode = listDataSatker[i]['satker_code'].toString();
            arrSatker.add(satkerCode);

            if (satkerCode.length == 2) {
              kejati.add(satkerCode);
            } else if (satkerCode.length == 4) {
              kejari.add(satkerCode);
            } else {
              cabang.add(satkerCode);
            }
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

  String getSatkerName(String satkerCode) {
    for (int i = 0; i < listDataSatker.length; i++) {
      if (listDataSatker[i]['satker_code'].toString() == satkerCode) {
        return listDataSatker[i]['satker_name'].toString();
      }
    }
    return ''; // Return an empty string or handle the case when satkerName is not found
  }

  sessionToken() async {
    getData(
        year.toString(),
        selectedStartMonth,
        selectedEndMonth,
        selectedListLayer2,
        selectedListType,
        selectedKejati,
        selectedKejari,
        selectedCabang);
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

  @override
  dispose() {
    super.dispose();
  }

  checkSession() async {
    setState(() {
      year = today.year;
      selectedStartMonth = "01";
      selectedEndMonth = "12";
      selectedListLayer2 = "P8";
      selectedListType = "TPPU ASAL TP. KORUPSI";
      selectedKejati = "00";
      selectedKejari = "00";
      selectedCabang = "00";
    });

    yearStart.text = year.toString();
    getData(
        year.toString(),
        selectedStartMonth,
        selectedEndMonth,
        selectedListLayer2,
        selectedListType,
        selectedKejati,
        selectedKejari,
        selectedCabang);
    getDataSatker();
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
                    "Detail Penyidikan",
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
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) {
                          return GestureDetector(
                            onTap: () => Navigator.of(context).pop(),
                            child: Container(
                              color: const Color.fromRGBO(0, 0, 0, 0.001),
                              child: GestureDetector(
                                onTap: () {},
                                child: DraggableScrollableSheet(
                                  initialChildSize: 0.8,
                                  minChildSize: 0.2,
                                  maxChildSize: 0.95,
                                  builder: (_, controller) {
                                    return Container(
                                      decoration: const BoxDecoration(
                                        color: Color.fromARGB(255, 13, 30, 46),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(25.0),
                                          topRight: Radius.circular(25.0),
                                        ),
                                      ),
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
                                          Expanded(
                                            child: SingleChildScrollView(
                                              controller: controller,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 2,
                                                    left: 15,
                                                    right: 15,
                                                    bottom: 15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child: TextField(
                                                        controller: yearStart,
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          labelText: "Tahun",
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintText:
                                                              'Pilih tahun',
                                                          focusColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
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
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          labelText:
                                                              "Awal Bulan",
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintText:
                                                              'Pilih bulan',
                                                          focusColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                13, 30, 46),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        value:
                                                            selectedStartMonth,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedStartMonth =
                                                                newValue!;
                                                            print(
                                                                selectedStartMonth);

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

                                                            print(
                                                                selectedStartMonthName);
                                                          });
                                                        },
                                                        items: monthNumbers.map(
                                                            (String
                                                                numericMonth) {
                                                          String monthName =
                                                              months[int.parse(
                                                                      numericMonth) -
                                                                  1];

                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: numericMonth,
                                                            child: Text(
                                                              monthName,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
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
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          labelText:
                                                              "Akhir Bulan",
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintText:
                                                              'Pilih bulan',
                                                          focusColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                13, 30, 46),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        value: selectedEndMonth,
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedEndMonth =
                                                                newValue!;
                                                            print(
                                                                selectedEndMonth);

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

                                                            print(
                                                                selectedEndMonthName);
                                                          });
                                                        },
                                                        items: monthNumbers.map(
                                                            (String
                                                                numericMonth) {
                                                          String monthName =
                                                              months[int.parse(
                                                                      numericMonth) -
                                                                  1];
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: numericMonth,
                                                            child: Text(
                                                              monthName,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
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
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          labelText: "Layer 2",
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintText:
                                                              'Pilih layer 2',
                                                          focusColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                13, 30, 46),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        items: listLayer2
                                                            .map((item) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedListLayer2 =
                                                                newValue!;
                                                            print(
                                                                selectedListLayer2);
                                                          });
                                                          print(
                                                              selectedListLayer2);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          labelText:
                                                              "Jenis Tahapan",
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintText:
                                                              'Pilih jenis tahapan',
                                                          focusColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                13, 30, 46),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        items: listType
                                                            .map((item) {
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: item,
                                                            child: Text(
                                                              item,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedListType =
                                                                newValue!;
                                                            print(
                                                                selectedListType);
                                                          });
                                                          print(
                                                              selectedListType);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          labelText: "Kejati",
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintText:
                                                              'Pilih Kejati',
                                                          focusColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                13, 30, 46),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        items: kejati
                                                            .map((satkerCode) {
                                                          String satkerName =
                                                              getSatkerName(
                                                                  satkerCode);
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: satkerCode,
                                                            child: Text(
                                                              satkerName,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedKejati =
                                                                newValue!;
                                                            print(
                                                                selectedKejati);
                                                          });
                                                          print(selectedKejati);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          labelText: "Kejari",
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintText:
                                                              'Pilih Kejari',
                                                          focusColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                13, 30, 46),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        items: kejari
                                                            .map((satkerCode) {
                                                          String satkerName =
                                                              getSatkerName(
                                                                  satkerCode);
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: satkerCode,
                                                            child: Text(
                                                              satkerName,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedKejari =
                                                                newValue!;
                                                            print(
                                                                selectedKejari);
                                                          });
                                                          print(selectedKejari);
                                                        },
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10.0,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 8.0),
                                                      child:
                                                          DropdownButtonFormField<
                                                              String>(
                                                        decoration:
                                                            InputDecoration(
                                                          fillColor:
                                                              Colors.white,
                                                          labelText: "Cabang",
                                                          labelStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintStyle:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                          hintText:
                                                              'Pilih Cabang',
                                                          focusColor:
                                                              Colors.white,
                                                          border:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                          ),
                                                        ),
                                                        dropdownColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                13, 30, 46),
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white),
                                                        items: cabang
                                                            .map((satkerCode) {
                                                          String satkerName =
                                                              getSatkerName(
                                                                  satkerCode);
                                                          return DropdownMenuItem<
                                                              String>(
                                                            value: satkerCode,
                                                            child: Text(
                                                              satkerName,
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          );
                                                        }).toList(),
                                                        onChanged:
                                                            (String? newValue) {
                                                          setState(() {
                                                            selectedCabang =
                                                                newValue!;
                                                            print(
                                                                selectedCabang);
                                                          });
                                                          print(selectedCabang);
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
                                                        searchData(
                                                          yearStart.text,
                                                          selectedStartMonth,
                                                          selectedEndMonth,
                                                          selectedListLayer2,
                                                          selectedListType,
                                                          selectedKejati,
                                                          selectedKejari,
                                                          selectedCabang,
                                                        );
                                                      },
                                                      child: Container(
                                                        width: MediaQuery.of(
                                                                context)
                                                            .size
                                                            .width,
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 20.0),
                                                        margin: const EdgeInsets
                                                            .symmetric(
                                                            horizontal: 5.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          color: clrBadge,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                        ),
                                                        child: const Center(
                                                          child: Text(
                                                            "Pencarian",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 14.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
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
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Daftar Pencarian",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "Total: $totaldata Data",
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                child: !isProcess
                    ? PenyidikanPidsusDetail2(
                        data: listData,
                        dataListLayer2: selectedListLayer2,
                      )
                    : loaderDialogLead(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
