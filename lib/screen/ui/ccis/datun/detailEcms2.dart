// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/toast.dart';
import '../../../widget/room_widget.dart';
import '../constants/api.dart';

class DetailEcms2Page extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final accessToken;

  const DetailEcms2Page({
    super.key,
    required this.accessToken,
  });

  @override
  State<DetailEcms2Page> createState() => _DetailEcms2PageState();
}

class _DetailEcms2PageState extends State<DetailEcms2Page> {
  String title = "JAMDATUN";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";
  List<String> last7Days = [];
  int monthNumber = 0;
  String message = "";
  bool isProcess = true;
  List listData = [];
  List listDataSatker = [];
  List<String> kejati = [];
  List<String> kejari = [];
  List<String> cabang = [];
  List arrBidangId = [];
  List<String> arrSatker = [];
  String satkerLength = '';

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();
  String totalProses = "";
  num totalAll = 0;
  num total = 0;
  num total2 = 0;
  num total3 = 0;
  num total4 = 0;
  num total5 = 0;
  num total6 = 0;
  num totalPenyelamatanAll = 0;
  num totalPenyelamatan = 0;
  num totalPenyelamatan2 = 0;
  num totalPenyelamatan3 = 0;
  num totalPenyelamatan4 = 0;
  num totalPenyelamatan5 = 0;
  num totalPenyelamatan6 = 0;
  num totalTegakHukumAll = 0;
  num totalTegakHukum = 0;
  num totalTegakHukum2 = 0;
  num totalTegakHukum3 = 0;
  num totalTegakHukum4 = 0;
  num totalTegakHukum5 = 0;
  num totalTegakHukum6 = 0;
  num totalArbitaseAll = 0;
  num totalArbitase = 0;
  num totalArbitase2 = 0;
  num totalArbitase3 = 0;
  num totalArbitase4 = 0;
  num totalArbitase5 = 0;
  num totalArbitase6 = 0;
  num totalTermohonAll = 0;
  num totalTermohon = 0;
  num totalTermohon2 = 0;
  num totalTermohon3 = 0;
  num totalTermohon4 = 0;
  num totalTermohon5 = 0;
  num totalTermohon6 = 0;
  num totalIccAll = 0;
  num totalIcc = 0;
  num totalIcc2 = 0;
  num totalIcc3 = 0;
  num totalIcc4 = 0;
  num totalIcc5 = 0;
  num totalIcc6 = 0;
  num totalClaimantAll = 0;
  num totalClaimant = 0;
  num totalClaimant2 = 0;
  num totalClaimant3 = 0;
  num totalClaimant4 = 0;
  num totalClaimant5 = 0;
  num totalClaimant6 = 0;
  String totalDitingkatkan = "";
  String totalTidakDitingkatkan = "";
  String totalDiserahkan = "";
  String totalPenyelidikan = "";
  String selectedStartMonth = ""; // Bulan default
  String selectedStartMonthName = ""; // Bulan default
  String selectedEndMonth = ""; // Bulan default
  String selectedEndMonthName = ""; // Bulan default = ""; // Bulan default
  String selectedKejati = "";
  String selectedKejari = "";
  String selectedCabang = "";

  searchData(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
      selectedStartMonth = bulanAwal;
      selectedEndMonth = bulanAkhir;
      selectedKejati = kejati;
      selectedKejari = kejari;
      selectedCabang = cabang;
    });

    getData(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData2(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData3(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData4(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData5(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData6(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
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
      // print("datasatker" + content.toString());

      if (content['status'] == 200) {
        setState(() {
          listDataSatker = content['data'];
          // print(listDataSatker);
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

          // print("kejati $kejati");
          // print("kejari $kejari");
          // print("cabang $cabang");
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

  getData(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
    try {
      var params = jsonEncode({
        "id_kejati": kejati,
        "id_kejari": kejari,
        "id_cabjari": cabang,
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countDatunPerdata),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          total = content['data']['permohonanData'];
          total2 = content['data']['sp1Data'];
          total3 = content['data']['skkData'];
          total4 = content['data']['skksData'];
          total5 = content['data']['penyelesaianData'];
          total6 = content['data']['eksekusiData'];

          totalAll = total + total2 + total3 + total4 + total5 + total6;
          print(total);
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context,
      //     "Tidak ada data penyelidikan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData2(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
    try {
      var params = jsonEncode({
        "id_kejati": kejati,
        "id_kejari": kejari,
        "id_cabjari": cabang,
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countDatunPerdata2),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalPenyelamatan = content['data']['permohonanData'];
          totalPenyelamatan2 = content['data']['sp1Data'];
          totalPenyelamatan3 = content['data']['skkData'];
          totalPenyelamatan4 = content['data']['skksData'];
          totalPenyelamatan5 = content['data']['penyelesaianData'];
          totalPenyelamatan6 = content['data']['eksekusiData'];
          totalPenyelamatanAll = totalPenyelamatan + totalPenyelamatan2 + totalPenyelamatan3 + totalPenyelamatan4 + totalPenyelamatan5 + totalPenyelamatan6;
          print(total2);
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context,
      //     "Tidak ada data penyelidikan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData3(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
    try {
      var params = jsonEncode({
        "id_kejati": kejati,
        "id_kejari": kejari,
        "id_cabjari": cabang,
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countDatunPerdata3),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalTegakHukum = content['data']['permohonanData'];
          totalTegakHukum2 = content['data']['sp1Data'];
          totalTegakHukum3 = content['data']['skkData'];
          totalTegakHukum4 = content['data']['skksData'];
          totalTegakHukum5 = content['data']['penyelesaianData'];
          totalTegakHukum6 = content['data']['eksekusiData'];
          totalTegakHukumAll = totalTegakHukum + totalTegakHukum2 + totalTegakHukum3 + totalTegakHukum4 + totalTegakHukum5 + totalTegakHukum6;
          
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context,
      //     "Tidak ada data penyelidikan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData4(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
    try {
      var params = jsonEncode({
        "id_kejati": kejati,
        "id_kejari": kejari,
        "id_cabjari": cabang,
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countDatunPerdata4),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalArbitase = content['data']['permohonanData'];
          totalArbitase2 = content['data']['sp1Data'];
          totalArbitase3 = content['data']['skkData'];
          totalArbitase4 = content['data']['skksData'];
          totalArbitase5 = content['data']['penyelesaianData'];
          totalArbitase6 = content['data']['eksekusiData'];
          totalArbitaseAll = totalArbitase + totalArbitase2 + totalArbitase3 + totalArbitase4 + totalArbitase5 + totalArbitase6;
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context,
      //     "Tidak ada data penyelidikan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData5(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
    try {
      var params = jsonEncode({
        "id_kejati": kejati,
        "id_kejari": kejari,
        "id_cabjari": cabang,
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countDatunPerdata5),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalTermohon = content['data']['permohonanData'];
          totalTermohon2 = content['data']['sp1Data'];
          totalTermohon3 = content['data']['skkData'];
          totalTermohon4 = content['data']['skksData'];
          totalTermohon5 = content['data']['penyelesaianData'];
          totalTermohon6 = content['data']['eksekusiData'];
          totalTermohonAll = totalTermohon + totalTermohon2 + totalTermohon3 + totalTermohon4 + totalTermohon5 + totalTermohon6;
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context,
      //     "Tidak ada data penyelidikan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData6(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
    try {
      var params = jsonEncode({
        "id_kejati": kejati,
        "id_kejari": kejari,
        "id_cabjari": cabang,
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countDatunPerdata6),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalClaimant = content['data']['permohonanData'];
          totalClaimant2 = content['data']['sp1Data'];
          totalClaimant3 = content['data']['skkData'];
          totalClaimant4 = content['data']['skksData'];
          totalClaimant5 = content['data']['penyelesaianData'];
          totalClaimant6 = content['data']['eksekusiData'];
          totalClaimantAll = totalClaimant + totalClaimant2 + totalClaimant3 + totalClaimant4 + totalClaimant5 + totalClaimant6;
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context,
      //     "Tidak ada data penyelidikan pada tahun ini"); //e.toString());
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
      selectedKejati = "00";
      selectedKejari = "00";
      selectedCabang = "00";
    });
    yearStart.text = year.toString();
    getData(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData2(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData3(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData4(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData5(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getData6(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
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

    List<RoomCategoryData> roomCategories = [
      RoomCategoryData(
        title: "Bantuan Hukum Pemulihan",
        count: totalAll.toString(),
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Permohonan",
            colorIcon: clrWait,
            count: total.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SP1",
            colorIcon: clrBadge,
            count: total2.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKK",
            colorIcon: clrBadge,
            count: total3.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKKS",
            colorIcon: clrBadge,
            count: total4.toString(),
          ),
          RoomContainer(
              onTap: () {},
              title: "Putusan",
              colorIcon: clrBadge,
              count: total5.toString()),
          RoomContainer(
              onTap: () {},
              title: "Penyelesaian",
              colorIcon: clrBadge,
              count: total6.toString()),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "Bantuan Hukum Penyelamatan",
        count: totalPenyelamatanAll.toString(),
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Permohonan",
            colorIcon: clrWait,
            count: totalPenyelamatan.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SP1",
            colorIcon: clrBadge,
            count: totalPenyelamatan2.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKK",
            colorIcon: clrBadge,
            count: totalPenyelamatan3.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKKS",
            colorIcon: clrBadge,
            count: totalPenyelamatan4.toString(),
          ),
          RoomContainer(
              onTap: () {},
              title: "Putusan",
              colorIcon: clrBadge,
              count: totalPenyelamatan5.toString()),
          RoomContainer(
              onTap: () {},
              title: "Penyelesaian",
              colorIcon: clrBadge,
              count: totalPenyelamatan6.toString()),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "Penegakan Hukum",
        count: totalTegakHukumAll.toString(),
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Permohonan",
            colorIcon: clrWait,
            count: totalTegakHukum.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SP1",
            colorIcon: clrBadge,
            count: totalTegakHukum2.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKK",
            colorIcon: clrBadge,
            count: totalTegakHukum3.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKKS",
            colorIcon: clrBadge,
            count: totalTegakHukum4.toString(),
          ),
          RoomContainer(
              onTap: () {},
              title: "Putusan",
              colorIcon: clrBadge,
              count: totalTegakHukum5.toString()),
          RoomContainer(
              onTap: () {},
              title: "Penyelesaian",
              colorIcon: clrBadge,
              count: totalTegakHukum6.toString()),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "Arbitase Bani Pemohon",
        count: totalArbitaseAll.toString(),
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Permohonan",
            colorIcon: clrWait,
            count: totalArbitase.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SP1",
            colorIcon: clrBadge,
            count: totalArbitase2.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKK",
            colorIcon: clrBadge,
            count: totalArbitase3.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKKS",
            colorIcon: clrBadge,
            count: totalArbitase4.toString(),
          ),
          RoomContainer(
              onTap: () {},
              title: "Putusan",
              colorIcon: clrBadge,
              count: totalArbitase5.toString()),
          RoomContainer(
              onTap: () {},
              title: "Penyelesaian",
              colorIcon: clrBadge,
              count: totalArbitase6.toString()),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "Arbitase Bani Termohon",
        count: totalTermohonAll.toString(),
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Permohonan",
            colorIcon: clrWait,
            count: totalTermohon.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SP1",
            colorIcon: clrBadge,
            count: totalTermohon2.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKK",
            colorIcon: clrBadge,
            count: totalTermohon3.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKKS",
            colorIcon: clrBadge,
            count: totalTermohon4.toString(),
          ),
          RoomContainer(
              onTap: () {},
              title: "Putusan",
              colorIcon: clrBadge,
              count: totalTermohon5.toString()),
          RoomContainer(
              onTap: () {},
              title: "Penyelesaian",
              colorIcon: clrBadge,
              count: totalTermohon6.toString()),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "Arbitase ICC Claimant",
        count: totalIccAll.toString(),
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Permohonan",
            colorIcon: clrWait,
            count: totalIcc.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SP1",
            colorIcon: clrBadge,
            count: totalIcc2.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKK",
            colorIcon: clrBadge,
            count: totalIcc3.toString(),
          ),
          RoomContainer(
            onTap: () {},
            title: "SKKS",
            colorIcon: clrBadge,
            count: totalIcc4.toString(),
          ),
          RoomContainer(
              onTap: () {},
              title: "Putusan",
              colorIcon: clrBadge,
              count: totalIcc5.toString()),
          RoomContainer(
              onTap: () {},
              title: "Penyelesaian",
              colorIcon: clrBadge,
              count: totalIcc6.toString()),
          // Add other RoomContainer objects as needed
        ],
      ),
      
    ];

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
                    "assets/icons/logo-kejaksaan.png",
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
                    "e-CMS (Detail Perdata)",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "JAMDATUN",
                    style: TextStyle(color: Colors.orange, fontSize: 12),
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
              height: 5,
            ),
            !isProcess
                ? Column(
                    children: roomCategories
                        .map((roomCategory) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        roomCategory
                                            .title, // Use the title from RoomCategoryData
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Total ${roomCategory.count}", // Use the title from RoomCategoryData
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: roomCategory.roomContainers
                                              .map((roomContainerData) =>
                                                  RoomContainer(
                                                    onTap:
                                                        roomContainerData.onTap,
                                                    title:
                                                        roomContainerData.title,
                                                    colorIcon: roomContainerData
                                                        .colorIcon,
                                                    count:
                                                        roomContainerData.count,
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  )
                : const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff3cd2a5)),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}

class RoomCategoryData {
  final String title;
  final String count;
  final List<RoomContainer> roomContainers;

  RoomCategoryData({
    required this.title,
    required this.count,
    required this.roomContainers,
  });
}
