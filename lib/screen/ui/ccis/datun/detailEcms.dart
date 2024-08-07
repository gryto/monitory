// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/toast.dart';
import '../../../widget/custom_button_primary.dart';
import '../../../widget/room_widget.dart';
import '../constants/api.dart';
import 'detailEcms2.dart';
import 'detailEcms3.dart';
import 'detailEcms4.dart';

class DetailEcmsPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final accessToken;

  const DetailEcmsPage({
    super.key,
    required this.accessToken,
  });

  @override
  State<DetailEcmsPage> createState() => _DetailEcmsPageState();
}

class _DetailEcmsPageState extends State<DetailEcmsPage>
    with SingleTickerProviderStateMixin {
  //create controller untuk tabBar
  late TabController controller;
  int selectedIndex = 0;
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
  num total = 0;
  num total2 = 0;
  num total3 = 0;
  num total4 = 0;
  num total5 = 0;
  num total6 = 0;

  num total7 = 0;
  num total8 = 0;
  num total9 = 0;
  num total10 = 0;
  num total11 = 0;
  num total12 = 0;
  String total13 = "";
  num total14 = 0;

  num totalHukum1 = 0;
  num totalHukum2 = 0;
  num totalHukum3 = 0;
  num totalHukum4 = 0;

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
    getDataTun7(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun8(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun9(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun10(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun11(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun12(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun13(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun14(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataHukum1(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataHukum2(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataHukum3(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataHukum4(year.toString(), selectedStartMonth, selectedEndMonth,
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
      var response = await http.post(Uri.parse(ApiService.countDatun),
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
          total = content['data']['totalPermohonan'];
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
      var response = await http.post(Uri.parse(ApiService.countDatun2),
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
          total2 = content['data']['totalSp1'];
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
      var response = await http.post(Uri.parse(ApiService.countDatun3),
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
          total3 = content['data']['totalSkk'];
          print(total3);
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
      var response = await http.post(Uri.parse(ApiService.countDatun4),
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
          total4 = content['data']['totalSkks'];
          print(total4);
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
      var response = await http.post(Uri.parse(ApiService.countDatun5),
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
          total5 = content['data']['totalPutusan'];
          print(total5);
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
      var response = await http.post(Uri.parse(ApiService.countDatun6),
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
          total6 = content['data']['totalEksekusi'];
          print(total6);
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

  getDataTun7(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunTun),
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
          total7 = content['data']['totalPermohonan'];
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

  getDataTun8(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunTun2),
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
          total8 = content['data']['totalSp1'];
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

  getDataTun9(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunTun3),
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
          total9 = content['data']['totalSkk'];
          print(total9);
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

  getDataTun10(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunTun4),
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
          total10 = content['data']['totalSkks'];
          print(total10);
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

  getDataTun11(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunTun5),
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
          total11 = content['data']['totalPutusan'];
          print(total11);
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

  getDataTun12(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunTun6),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("objectiiiii");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          total12 = content['data']['totalEksekusi'];
          print(total12);
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

  getDataTun13(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunTun7),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("objectpenyelesaian");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          total13 = content['data']['totalPermohonan'];
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

  getDataTun14(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunTun8),
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
          total2 = content['data']['totalSp1'];
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

  getDataHukum1(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunHukum),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("objectHukum1");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalHukum1 = content['data']['totalPermohonan'];
          print(totalHukum1);
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

  getDataHukum2(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunHukum2),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("objectHukum2");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalHukum2 = content['data']['totalSp1'];
          print(totalHukum2);
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

  getDataHukum3(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunHukum3),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("objectHukum3");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalHukum3 = content['data']['totalSp2'];
          print(totalHukum3);
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

  getDataHukum4(tahun, bulanAwal, bulanAkhir, kejati, kejari, cabang) async {
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
      var response = await http.post(Uri.parse(ApiService.countDatunHukum4),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("objectHukum4");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalHukum4 = content['data']['totalPenyelesaian'];
          print(totalHukum4);
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
    getDataTun7(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun8(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun9(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun10(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun11(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun12(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun13(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataTun14(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataHukum1(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataHukum2(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataHukum3(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
    getDataHukum4(year.toString(), selectedStartMonth, selectedEndMonth,
        selectedKejati, selectedKejari, selectedCabang);
  }

  @override
  void initState() {
    controller = TabController(vsync: this, length: 3);
    checkSession();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _pullRefresh() async {
    setState(() {
      listData.clear();
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
    });
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
                    "e-CMS",
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
      body: !isProcess
          ? bidangTabBar()
          : const Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3cd2a5)),
                ),
              ),
            ),
    );
  }

  Widget bidangTabBar() {
    return Column(
      children: [
        TabBar(
          labelColor: clrBadge,
          indicatorColor: clrBadge,
          unselectedLabelColor: const Color.fromARGB(255, 186, 227, 217),
          tabs: const <Tab>[
            Tab(text: 'Perdata'),
            Tab(text: 'Tun'),
            Tab(text: 'Timbang \n Hukum'),
          ],
          controller: controller,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
              controller.animateTo(index);
            });
          },
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              RefreshIndicator(
                color: clrPrimary,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  setState(() {
                    isProcess = true;
                    listData.clear();
                    _pullRefresh();
                  });
                },
                child: SingleChildScrollView(
                  child: listPerdata(),
                ),
              ),
              RefreshIndicator(
                color: clrPrimary,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  setState(() {
                    isProcess = true;
                    listData.clear();
                    _pullRefresh();
                  });
                },
                child: SingleChildScrollView(
                  child: listTun(),
                ),
              ),
              RefreshIndicator(
                color: clrPrimary,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  setState(() {
                    isProcess = true;
                    listData.clear();
                    _pullRefresh();
                  });
                },
                child: SingleChildScrollView(
                  child: listHukum(),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget listPerdata() {
    List<String> monthNumbers = months
        .asMap()
        .map((index, month) {
          int numericValue = index + 1; // Adding 1 to start from 1
          return MapEntry(month,
              numericValue.toString().padLeft(2, '0')); // Adding leading zeros
        })
        .values
        .toList();
    return Column(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Tahun",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih tahun',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Awal Bulan",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih bulan',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    value: selectedStartMonth,
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
                                                        (String numericMonth) {
                                                      String monthName = months[
                                                          int.parse(
                                                                  numericMonth) -
                                                              1];

                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: numericMonth,
                                                        child: Text(
                                                          monthName,
                                                          style:
                                                              const TextStyle(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Akhir Bulan",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih bulan',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    value: selectedEndMonth,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedEndMonth =
                                                            newValue!;
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

                                                        print(
                                                            selectedEndMonthName);
                                                      });
                                                    },
                                                    items: monthNumbers.map(
                                                        (String numericMonth) {
                                                      String monthName = months[
                                                          int.parse(
                                                                  numericMonth) -
                                                              1];
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: numericMonth,
                                                        child: Text(
                                                          monthName,
                                                          style:
                                                              const TextStyle(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Kejati",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Kejati',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedKejati);
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Kejari",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Kejari',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedKejari);
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Cabang",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Cabang',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedCabang);
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20.0),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: clrBadge,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Pencarian",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w600,
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
            ? Padding(
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
                                  title: "Permohonan",
                                  colorIcon: clrWait,
                                  count: total.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SP1",
                                  colorIcon: clrBadge,
                                  count: total2.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SKK",
                                  colorIcon: clrDelete,
                                  count: total3.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SKKS",
                                  colorIcon: clrDelete,
                                  count: total4.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "Putusan",
                                  colorIcon: clrDelete,
                                  count: total5.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "Eksekusi",
                                  colorIcon: clrDelete,
                                  count: total6.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
        Container(
          alignment: Alignment.centerRight,
          child: CustomButtonPrimary(
            text: 'Detail Keseluruhan',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailEcms2Page(
                    accessToken: widget.accessToken,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget listTun() {
    List<String> monthNumbers = months
        .asMap()
        .map((index, month) {
          int numericValue = index + 1; // Adding 1 to start from 1
          return MapEntry(month,
              numericValue.toString().padLeft(2, '0')); // Adding leading zeros
        })
        .values
        .toList();
    return Column(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Tahun",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih tahun',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Awal Bulan",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih bulan',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    value: selectedStartMonth,
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
                                                        (String numericMonth) {
                                                      String monthName = months[
                                                          int.parse(
                                                                  numericMonth) -
                                                              1];

                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: numericMonth,
                                                        child: Text(
                                                          monthName,
                                                          style:
                                                              const TextStyle(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Akhir Bulan",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih bulan',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    value: selectedEndMonth,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedEndMonth =
                                                            newValue!;
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

                                                        print(
                                                            selectedEndMonthName);
                                                      });
                                                    },
                                                    items: monthNumbers.map(
                                                        (String numericMonth) {
                                                      String monthName = months[
                                                          int.parse(
                                                                  numericMonth) -
                                                              1];
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: numericMonth,
                                                        child: Text(
                                                          monthName,
                                                          style:
                                                              const TextStyle(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Kejati",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Kejati',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedKejati);
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Kejari",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Kejari',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedKejari);
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Cabang",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Cabang',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedCabang);
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20.0),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: clrBadge,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Pencarian",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w600,
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
            ? Padding(
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
                                  title: "Permohonan",
                                  colorIcon: clrWait,
                                  count: total7.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SP1",
                                  colorIcon: clrBadge,
                                  count: total8.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SP2",
                                  colorIcon: clrDelete,
                                  count: total9.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SKK",
                                  colorIcon: clrDelete,
                                  count: total10.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SKKS",
                                  colorIcon: clrDelete,
                                  count: total11.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "Putusan",
                                  colorIcon: clrDelete,
                                  count: total12.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "Penyelesaian",
                                  colorIcon: clrDelete,
                                  count: total13),
                              RoomContainer(
                                  onTap: () {},
                                  title: "Eksekusi",
                                  colorIcon: clrDelete,
                                  count: total14.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
        Container(
          alignment: Alignment.centerRight,
          child: CustomButtonPrimary(
            text: 'Detail Keseluruhan',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailEcms3Page(
                    accessToken: widget.accessToken,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget listHukum() {
    List<String> monthNumbers = months
        .asMap()
        .map((index, month) {
          int numericValue = index + 1; // Adding 1 to start from 1
          return MapEntry(month,
              numericValue.toString().padLeft(2, '0')); // Adding leading zeros
        })
        .values
        .toList();
    return Column(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Tahun",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih tahun',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
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
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Awal Bulan",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih bulan',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    value: selectedStartMonth,
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
                                                        (String numericMonth) {
                                                      String monthName = months[
                                                          int.parse(
                                                                  numericMonth) -
                                                              1];

                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: numericMonth,
                                                        child: Text(
                                                          monthName,
                                                          style:
                                                              const TextStyle(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Akhir Bulan",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih bulan',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
                                                    value: selectedEndMonth,
                                                    onChanged:
                                                        (String? newValue) {
                                                      setState(() {
                                                        selectedEndMonth =
                                                            newValue!;
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

                                                        print(
                                                            selectedEndMonthName);
                                                      });
                                                    },
                                                    items: monthNumbers.map(
                                                        (String numericMonth) {
                                                      String monthName = months[
                                                          int.parse(
                                                                  numericMonth) -
                                                              1];
                                                      return DropdownMenuItem<
                                                          String>(
                                                        value: numericMonth,
                                                        child: Text(
                                                          monthName,
                                                          style:
                                                              const TextStyle(
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Kejati",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Kejati',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedKejati);
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Kejari",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Kejari',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedKejari);
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
                                                    decoration: InputDecoration(
                                                      fillColor: Colors.white,
                                                      labelText: "Cabang",
                                                      labelStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintStyle:
                                                          const TextStyle(
                                                              color:
                                                                  Colors.white),
                                                      hintText: 'Pilih Cabang',
                                                      focusColor: Colors.white,
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                    ),
                                                    dropdownColor:
                                                        const Color.fromARGB(
                                                            255, 13, 30, 46),
                                                    style: const TextStyle(
                                                        color: Colors.white),
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
                                                          style:
                                                              const TextStyle(
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
                                                        print(selectedCabang);
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
                                                    width:
                                                        MediaQuery.of(context)
                                                            .size
                                                            .width,
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 20.0),
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                        horizontal: 5.0),
                                                    decoration: BoxDecoration(
                                                      color: clrBadge,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: const Center(
                                                      child: Text(
                                                        "Pencarian",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 14.0,
                                                          fontWeight:
                                                              FontWeight.w600,
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
            ? Padding(
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
                                  title: "Permohonan",
                                  colorIcon: clrWait,
                                  count: totalHukum1.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SP1",
                                  colorIcon: clrBadge,
                                  count: totalHukum2.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "SP2",
                                  colorIcon: clrDelete,
                                  count: totalHukum3.toString()),
                              RoomContainer(
                                  onTap: () {},
                                  title: "Penyelesaian",
                                  colorIcon: clrDelete,
                                  count: totalHukum4.toString()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
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
        Container(
          alignment: Alignment.centerRight,
          child: CustomButtonPrimary(
            text: 'Detail Keseluruhan',
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => DetailEcms4Page(
                    accessToken: widget.accessToken,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
