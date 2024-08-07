import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';
import '../../../../src/constant.dart';
import '../../../../src/preference.dart';
import '../../../../src/toast.dart';
import '../constants/api.dart';

class DetailDatunIsi extends StatefulWidget {
  final String accessToken, tahun;
  const DetailDatunIsi(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailDatunIsiState createState() => _DetailDatunIsiState();
}

class _DetailDatunIsiState extends State<DetailDatunIsi> {
  late Widget body;
  String title = "HaloJPN";
  String subtitle = "Sumber : Hallo JPN ( https://halojpn.id/ )";
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  num year = 0;

  searchData(tahun) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
    });

    getData(year.toString());
    getDataQuestion(year.toString());
  }

  int maxY = 1;
  double divY = 1;
  var tempData = [0];

  var arrLabel = [
    'Buruh',
    'Hukum',
    'Hutang',
    'Legal',
    'Pendirian',
    'Pernikahan',
    'Pertanahan',
    'Pidana'
  ];

  num totalPengunjung = 0;

  String name0 = "";
  String name1 = "";
  String name2 = "";
  String name3 = "";
  String name4 = "";
  String name5 = "";
  String name6 = "";
  String name7 = "";

  List listBuruhTenagaKerjaData = [];
  num listBuruh0 = 0;
  num listBuruh1 = 0;
  num listBuruh2 = 0;
  num listBuruh3 = 0;
  num listBuruh4 = 0;
  num listBuruh5 = 0;
  num listBuruh6 = 0;
  num listBuruh7 = 0;
  num listBuruh8 = 0;
  num listBuruh9 = 0;
  num listBuruh10 = 0;
  num listBuruh11 = 0;
  num totalListBuruh = 0;

  var arrBuruhTenagaKerjaData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  List listHukumWarisData = [];
  num listHukum0 = 0;
  num listHukum1 = 0;
  num listHukum2 = 0;
  num listHukum3 = 0;
  num listHukum4 = 0;
  num listHukum5 = 0;
  num listHukum6 = 0;
  num listHukum7 = 0;
  num listHukum8 = 0;
  num listHukum9 = 0;
  num listHukum10 = 0;
  num listHukum11 = 0;
  num totalListHukum = 0;
  var arrHukumWarisData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  List listHutangPiutangData = [];
  num listHutang0 = 0;
  num listHutang1 = 0;
  num listHutang2 = 0;
  num listHutang3 = 0;
  num listHutang4 = 0;
  num listHutang5 = 0;
  num listHutang6 = 0;
  num listHutang7 = 0;
  num listHutang8 = 0;
  num listHutang9 = 0;
  num listHutang10 = 0;
  num listHutang11 = 0;
  num totalListHutang = 0;

  var arrHutangPiutangData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  List listLegalDraftingData = [];
  num listLegal0 = 0;
  num listLegal1 = 0;
  num listLegal2 = 0;
  num listLegal3 = 0;
  num listLegal4 = 0;
  num listLegal5 = 0;
  num listLegal6 = 0;
  num listLegal7 = 0;
  num listLegal8 = 0;
  num listLegal9 = 0;
  num listLegal10 = 0;
  num listLegal11 = 0;
  num totalListLegal = 0;

  var arrLegalDraftingData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  List listPendirianpembubaranPTData = [];
  num listPendirian0 = 0;
  num listPendirian1 = 0;
  num listPendirian2 = 0;
  num listPendirian3 = 0;
  num listPendirian4 = 0;
  num listPendirian5 = 0;
  num listPendirian6 = 0;
  num listPendirian7 = 0;
  num listPendirian8 = 0;
  num listPendirian9 = 0;
  num listPendirian10 = 0;
  num listPendirian11 = 0;
  num totalListPendirian = 0;

  var arrPendirianpembubaranPTData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  List listPernikahanPerceraianData = [];
  num listPernikahan0 = 0;
  num listPernikahan1 = 0;
  num listPernikahan2 = 0;
  num listPernikahan3 = 0;
  num listPernikahan4 = 0;
  num listPernikahan5 = 0;
  num listPernikahan6 = 0;
  num listPernikahan7 = 0;
  num listPernikahan8 = 0;
  num listPernikahan9 = 0;
  num listPernikahan10 = 0;
  num listPernikahan11 = 0;
  num totalListPernikahan = 0;

  var arrPernikahanPerceraianData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  List listPertanahanData = [];
  num listPertanahan0 = 0;
  num listPertanahan1 = 0;
  num listPertanahan2 = 0;
  num listPertanahan3 = 0;
  num listPertanahan4 = 0;
  num listPertanahan5 = 0;
  num listPertanahan6 = 0;
  num listPertanahan7 = 0;
  num listPertanahan8 = 0;
  num listPertanahan9 = 0;
  num listPertanahan10 = 0;
  num listPertanahan11 = 0;
  num totalListPertanahan = 0;

  var arrPertanahanData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  List listPidanaData = [];
  num listPidana0 = 0;
  num listPidana1 = 0;
  num listPidana2 = 0;
  num listPidana3 = 0;
  num listPidana4 = 0;
  num listPidana5 = 0;
  num listPidana6 = 0;
  num listPidana7 = 0;
  num listPidana8 = 0;
  num listPidana9 = 0;
  num listPidana10 = 0;
  num listPidana11 = 0;
  num totalListPidana = 0;

  var arrPidanaData = [
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0,
    0.0
  ];

  List listPertanyaan = [];
  num listPertanyaan0 = 0;
  num listPertanyaan1 = 0;
  num listPertanyaan2 = 0;
  num listPertanyaan3 = 0;
  num listPertanyaan4 = 0;
  num listPertanyaan5 = 0;
  num listPertanyaan6 = 0;
  num listPertanyaan7 = 0;
  num listPertanyaan8 = 0;
  num listPertanyaan9 = 0;
  num listPertanyaan10 = 0;
  num listPertanyaan11 = 0;
  num totalListPertanyaan = 0;

  List listJawaban = [];
  num listJawaban0 = 0;
  num listJawaban1 = 0;
  num listJawaban2 = 0;
  num listJawaban3 = 0;
  num listJawaban4 = 0;
  num listJawaban5 = 0;
  num listJawaban6 = 0;
  num listJawaban7 = 0;
  num listJawaban8 = 0;
  num listJawaban9 = 0;
  num listJawaban10 = 0;
  num listJawaban11 = 0;
  num totalListJawaban = 0;

  List listBelumDijawab = [];
  num listBelumDijawab0 = 0;
  num listBelumDijawab1 = 0;
  num listBelumDijawab2 = 0;
  num listBelumDijawab3 = 0;
  num listBelumDijawab4 = 0;
  num listBelumDijawab5 = 0;
  num listBelumDijawab6 = 0;
  num listBelumDijawab7 = 0;
  num listBelumDijawab8 = 0;
  num listBelumDijawab9 = 0;
  num listBelumDijawab10 = 0;
  num listBelumDijawab11 = 0;
  num totalListBelumDijawab = 0;

  getData(tahun) async {
    try {
      var params = jsonEncode({"tahun": tahun.toString()});
      var response = await http.post(Uri.parse(ApiService.chartJamdatun),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          arrBuruhTenagaKerjaData = [];
          arrHukumWarisData = [];
          arrHutangPiutangData = [];
          arrLegalDraftingData = [];
          arrPendirianpembubaranPTData = [];
          arrPernikahanPerceraianData = [];
          arrPertanahanData = [];
          arrPidanaData = [];

          name0 = content['data'][0]['kategori'];
          name1 = content['data'][1]['kategori'];
          name2 = content['data'][2]['kategori'];
          name3 = content['data'][3]['kategori'];
          name4 = content['data'][4]['kategori'];
          name5 = content['data'][5]['kategori'];
          name6 = content['data'][6]['kategori'];
          name7 = content['data'][7]['kategori'];

          listBuruhTenagaKerjaData = content['data'][0]['data'];
          listBuruh0 = listBuruhTenagaKerjaData[0];
          listBuruh1 = listBuruhTenagaKerjaData[1];
          listBuruh2 = listBuruhTenagaKerjaData[2];
          listBuruh3 = listBuruhTenagaKerjaData[3];
          listBuruh4 = listBuruhTenagaKerjaData[4];
          listBuruh5 = listBuruhTenagaKerjaData[5];
          listBuruh6 = listBuruhTenagaKerjaData[6];
          listBuruh7 = listBuruhTenagaKerjaData[7];
          listBuruh8 = listBuruhTenagaKerjaData[8];
          listBuruh9 = listBuruhTenagaKerjaData[9];
          listBuruh10 = listBuruhTenagaKerjaData[10];
          listBuruh11 = listBuruhTenagaKerjaData[11];

          totalListBuruh = listBuruh0 +
              listBuruh1 +
              listBuruh2 +
              listBuruh3 +
              listBuruh4 +
              listBuruh5 +
              listBuruh6 +
              listBuruh7 +
              listBuruh8 +
              listBuruh9 +
              listBuruh10 +
              listBuruh11;

          listHukumWarisData = content['data'][1]['data'];
          listHukum0 = listHukumWarisData[0];
          listHukum1 = listHukumWarisData[1];
          listHukum2 = listHukumWarisData[2];
          listHukum3 = listHukumWarisData[3];
          listHukum4 = listHukumWarisData[4];
          listHukum5 = listHukumWarisData[5];
          listHukum6 = listHukumWarisData[6];
          listHukum7 = listHukumWarisData[7];
          listHukum8 = listHukumWarisData[8];
          listHukum9 = listHukumWarisData[9];
          listHukum10 = listHukumWarisData[10];
          listHukum11 = listHukumWarisData[11];

          totalListHukum = listHukum0 +
              listHukum1 +
              listHukum2 +
              listHukum3 +
              listHukum4 +
              listHukum5 +
              listHukum6 +
              listHukum7 +
              listHukum8 +
              listHukum9 +
              listHukum10 +
              listHukum11;

          listHutangPiutangData = content['data'][2]['data'];
          listHutang0 = listHutangPiutangData[0];
          listHutang1 = listHutangPiutangData[1];
          listHutang2 = listHutangPiutangData[2];
          listHutang3 = listHutangPiutangData[3];
          listHutang4 = listHutangPiutangData[4];
          listHutang5 = listHutangPiutangData[5];
          listHutang6 = listHutangPiutangData[6];
          listHutang7 = listHutangPiutangData[7];
          listHutang8 = listHutangPiutangData[8];
          listHutang9 = listHutangPiutangData[9];
          listHutang10 = listHutangPiutangData[10];
          listHutang11 = listHutangPiutangData[11];

          totalListHutang = listHutang0 +
              listHutang1 +
              listHutang2 +
              listHutang3 +
              listHutang4 +
              listHutang5 +
              listHutang6 +
              listHutang7 +
              listHutang8 +
              listHutang9 +
              listHutang10 +
              listHutang11;

          listLegalDraftingData = content['data'][3]['data'];
          listLegal0 = listLegalDraftingData[0];
          listLegal1 = listLegalDraftingData[1];
          listLegal2 = listLegalDraftingData[2];
          listLegal3 = listLegalDraftingData[3];
          listLegal4 = listLegalDraftingData[4];
          listLegal5 = listLegalDraftingData[5];
          listLegal6 = listLegalDraftingData[6];
          listLegal7 = listLegalDraftingData[7];
          listLegal8 = listLegalDraftingData[8];
          listLegal9 = listLegalDraftingData[9];
          listLegal10 = listLegalDraftingData[10];
          listLegal11 = listLegalDraftingData[11];

          totalListLegal = listLegal0 +
              listLegal1 +
              listLegal2 +
              listLegal3 +
              listLegal4 +
              listLegal5 +
              listLegal6 +
              listLegal7 +
              listLegal8 +
              listLegal9 +
              listLegal10 +
              listLegal11;

          listPendirianpembubaranPTData = content['data'][4]['data'];
          listPendirian0 = listPendirianpembubaranPTData[0];
          listPendirian1 = listPendirianpembubaranPTData[1];
          listPendirian2 = listPendirianpembubaranPTData[2];
          listPendirian3 = listPendirianpembubaranPTData[3];
          listPendirian4 = listPendirianpembubaranPTData[4];
          listPendirian5 = listPendirianpembubaranPTData[5];
          listPendirian6 = listPendirianpembubaranPTData[6];
          listPendirian7 = listPendirianpembubaranPTData[7];
          listPendirian8 = listPendirianpembubaranPTData[8];
          listPendirian9 = listPendirianpembubaranPTData[9];
          listPendirian10 = listPendirianpembubaranPTData[10];
          listPendirian11 = listPendirianpembubaranPTData[11];

          totalListPendirian = listPendirian0 +
              listPendirian1 +
              listPendirian2 +
              listPendirian3 +
              listPendirian4 +
              listPendirian5 +
              listPendirian6 +
              listPendirian7 +
              listPendirian8 +
              listPendirian9 +
              listPendirian10 +
              listPendirian11;

          listPernikahanPerceraianData = content['data'][5]['data'];
          listPernikahan0 = listPernikahanPerceraianData[0];
          listPernikahan1 = listPernikahanPerceraianData[1];
          listPernikahan2 = listPernikahanPerceraianData[2];
          listPernikahan3 = listPernikahanPerceraianData[3];
          listPernikahan4 = listPernikahanPerceraianData[4];
          listPernikahan5 = listPernikahanPerceraianData[5];
          listPernikahan6 = listPernikahanPerceraianData[6];
          listPernikahan7 = listPernikahanPerceraianData[7];
          listPernikahan8 = listPernikahanPerceraianData[8];
          listPernikahan9 = listPernikahanPerceraianData[9];
          listPernikahan10 = listPernikahanPerceraianData[10];
          listPernikahan11 = listPernikahanPerceraianData[11];

          totalListPernikahan = listPernikahan0 +
              listPernikahan1 +
              listPernikahan2 +
              listPernikahan3 +
              listPernikahan4 +
              listPernikahan5 +
              listPernikahan6 +
              listPernikahan7 +
              listPernikahan8 +
              listPernikahan9 +
              listPernikahan10 +
              listPernikahan11;

          listPertanahanData = content['data'][6]['data'];
          listPertanahan0 = listPertanahanData[0];
          listPertanahan1 = listPertanahanData[1];
          listPertanahan2 = listPertanahanData[2];
          listPertanahan3 = listPertanahanData[3];
          listPertanahan4 = listPertanahanData[4];
          listPertanahan5 = listPertanahanData[5];
          listPertanahan6 = listPertanahanData[6];
          listPertanahan7 = listPertanahanData[7];
          listPertanahan8 = listPertanahanData[8];
          listPertanahan9 = listPertanahanData[9];
          listPertanahan10 = listPertanahanData[10];
          listPertanahan11 = listPertanahanData[11];

          totalListPertanahan = listPertanahan0 +
              listPertanahan1 +
              listPertanahan2 +
              listPertanahan3 +
              listPertanahan4 +
              listPertanahan5 +
              listPertanahan6 +
              listPertanahan7 +
              listPertanahan8 +
              listPertanahan9 +
              listPertanahan10 +
              listPertanahan11;

          listPidanaData = content['data'][7]['data'];
          listPidana0 = listPidanaData[0];
          listPidana1 = listPidanaData[1];
          listPidana2 = listPidanaData[2];
          listPidana3 = listPidanaData[3];
          listPidana4 = listPidanaData[4];
          listPidana5 = listPidanaData[5];
          listPidana6 = listPidanaData[6];
          listPidana7 = listPidanaData[7];
          listPidana8 = listPidanaData[8];
          listPidana9 = listPidanaData[9];
          listPidana10 = listPidanaData[10];
          listPidana11 = listPidanaData[11];

          totalListPidana = listPidana0 +
              listPidana1 +
              listPidana2 +
              listPidana3 +
              listPidana4 +
              listPidana5 +
              listPidana6 +
              listPidana7 +
              listPidana8 +
              listPidana9 +
              listPidana10 +
              listPidana11;

          totalPengunjung = totalListBuruh +
              totalListHukum +
              totalListHutang +
              totalListLegal +
              totalListPendirian +
              totalListPernikahan +
              totalListPertanahan +
              totalListPidana;
        });

        for (int i = 0; i < listBuruhTenagaKerjaData.length; i++) {
          if (listBuruhTenagaKerjaData[i] != 0) {
            arrBuruhTenagaKerjaData.add(listBuruhTenagaKerjaData[i].toDouble());
            tempData.add(listBuruhTenagaKerjaData[i]);
          } else {
            arrBuruhTenagaKerjaData.add(0.0);
          }
        }

        for (int i = 0; i < listHukumWarisData.length; i++) {
          if (listHukumWarisData[i] != 0) {
            arrHukumWarisData.add(listHukumWarisData[i].toDouble());
            tempData.add(listHukumWarisData[i]);
          } else {
            arrHukumWarisData.add(0.0);
          }
        }

        for (int i = 0; i < listHutangPiutangData.length; i++) {
          if (listHutangPiutangData[i] != 0) {
            arrHutangPiutangData.add(listHutangPiutangData[i].toDouble());
            tempData.add(listHutangPiutangData[i]);
          } else {
            arrHutangPiutangData.add(0.0);
          }
        }

        for (int i = 0; i < listLegalDraftingData.length; i++) {
          if (listLegalDraftingData[i] != 0) {
            arrLegalDraftingData.add(listLegalDraftingData[i].toDouble());
            tempData.add(listLegalDraftingData[i]);
          } else {
            arrLegalDraftingData.add(0.0);
          }
        }

        for (int i = 0; i < listPendirianpembubaranPTData.length; i++) {
          if (listPendirianpembubaranPTData[i] != 0) {
            arrPendirianpembubaranPTData
                .add(listPendirianpembubaranPTData[i].toDouble());
            tempData.add(listPendirianpembubaranPTData[i]);
          } else {
            arrPendirianpembubaranPTData.add(0.0);
          }
        }

        for (int i = 0; i < listPernikahanPerceraianData.length; i++) {
          if (listPernikahanPerceraianData[i] != 0) {
            arrPernikahanPerceraianData
                .add(listPernikahanPerceraianData[i].toDouble());
            tempData.add(listPernikahanPerceraianData[i]);
          } else {
            arrPernikahanPerceraianData.add(0.0);
          }
        }

        for (int i = 0; i < listPertanahanData.length; i++) {
          if (listPertanahanData[i] != 0) {
            arrPertanahanData.add(listPertanahanData[i].toDouble());
            tempData.add(listPertanahanData[i]);
          } else {
            arrPertanahanData.add(0.0);
          }
        }

        for (int i = 0; i < listPidanaData.length; i++) {
          if (listPidanaData[i] != 0) {
            arrPidanaData.add(listPidanaData[i].toDouble());
            tempData.add(listPidanaData[i]);
          } else {
            arrPidanaData.add(0.0);
          }
        }

        maxY = tempData.reduce(max);
        maxY = maxY + 2;
        divY = maxY / 8;
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context, "Err list data jamdatun"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getDataQuestion(tahun) async {
    try {
      var params = jsonEncode({"tahun": tahun.toString()});
      var response = await http.post(Uri.parse(ApiService.countJamdatun),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          arrBuruhTenagaKerjaData = [];
          arrHukumWarisData = [];
          arrHutangPiutangData = [];
          arrLegalDraftingData = [];
          arrPendirianpembubaranPTData = [];
          arrPernikahanPerceraianData = [];
          arrPertanahanData = [];
          arrPidanaData = [];

          listPertanyaan = content['data'][0]['data'];
          listPertanyaan0 = listPertanyaan[0];
          listPertanyaan1 = listPertanyaan[1];
          listPertanyaan2 = listPertanyaan[2];
          listPertanyaan3 = listPertanyaan[3];
          listPertanyaan4 = listPertanyaan[4];
          listPertanyaan5 = listPertanyaan[5];
          listPertanyaan6 = listPertanyaan[6];
          listPertanyaan7 = listPertanyaan[7];
          listPertanyaan8 = listPertanyaan[8];
          listPertanyaan9 = listPertanyaan[9];
          listPertanyaan10 = listPertanyaan[10];
          listPertanyaan11 = listPertanyaan[11];

          totalListPertanyaan = listPertanyaan0 +
              listPertanyaan1 +
              listPertanyaan2 +
              listPertanyaan3 +
              listPertanyaan4 +
              listPertanyaan5 +
              listPertanyaan6 +
              listPertanyaan7 +
              listPertanyaan8 +
              listPertanyaan9 +
              listPertanyaan10 +
              listPertanyaan11;

          listJawaban = content['data'][1]['data'];
          listJawaban0 = listJawaban[0];
          listJawaban1 = listJawaban[1];
          listJawaban2 = listJawaban[2];
          listJawaban3 = listJawaban[3];
          listJawaban4 = listJawaban[4];
          listJawaban5 = listJawaban[5];
          listJawaban6 = listJawaban[6];
          listJawaban7 = listJawaban[7];
          listJawaban8 = listJawaban[8];
          listJawaban9 = listJawaban[9];
          listJawaban10 = listJawaban[10];
          listJawaban11 = listJawaban[11];

          totalListJawaban = listJawaban0 +
              listJawaban1 +
              listJawaban2 +
              listJawaban3 +
              listJawaban4 +
              listJawaban5 +
              listJawaban6 +
              listJawaban7 +
              listJawaban8 +
              listJawaban9 +
              listJawaban10 +
              listJawaban11;

          listBelumDijawab = content['data'][2]['data'];
          listBelumDijawab0 = listBelumDijawab[0];
          listBelumDijawab1 = listBelumDijawab[1];
          listBelumDijawab2 = listBelumDijawab[2];
          listBelumDijawab3 = listBelumDijawab[3];
          listBelumDijawab4 = listBelumDijawab[4];
          listBelumDijawab5 = listBelumDijawab[5];
          listBelumDijawab6 = listBelumDijawab[6];
          listBelumDijawab7 = listBelumDijawab[7];
          listBelumDijawab8 = listBelumDijawab[8];
          listBelumDijawab9 = listBelumDijawab[9];
          listBelumDijawab10 = listBelumDijawab[10];
          listBelumDijawab11 = listBelumDijawab[11];

          totalListBelumDijawab = listBelumDijawab0 +
              listBelumDijawab1 +
              listBelumDijawab2 +
              listBelumDijawab3 +
              listBelumDijawab4 +
              listBelumDijawab5 +
              listBelumDijawab6 +
              listBelumDijawab7 +
              listBelumDijawab8 +
              listBelumDijawab9 +
              listBelumDijawab10 +
              listBelumDijawab11;
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context, "Err list data jamdatun"); //e.toString());
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

  checkSession() async {
    setState(() {
      year = today.year;
    });

    yearStart.text = year.toString();
    getData(year.toString());
    getDataQuestion(year.toString());
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
    Widget widgets;

    widgets = RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 30, 46),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: Image(
                    image: AssetImage(
                      "assets/images/kejaksaan-logo.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widgets,
                    const Text(
                      "JAMDATUN",
                      style: TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0, bottom: 10, right: 10, left: 10),
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Periode Tahun ${yearStart.text}",
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
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
                                      builder:
                                          (BuildContext context, setState) =>
                                              SafeArea(
                                        child: Container(
                                          color: const Color.fromARGB(
                                              255, 13, 30, 46),
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
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white),
                                              ),
                                              const Divider(
                                                thickness: 2,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
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
                                                          BorderRadius.circular(
                                                              10),
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
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                    ),
                    child: Column(
                      children: [
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
                          height: 250,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            'Statistik Pengunjung Halo JPN',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ' ( Periode - ${yearStart.text} )',
                                            style: const TextStyle(
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
                                        padding: const EdgeInsets.only(
                                            left: 8, top: 8),
                                        width: 350,
                                        height: 150,
                                        child: !isProcess
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0),
                                                child: BarChart(
                                                  BarChartData(
                                                    barTouchData: barTouchData,
                                                    titlesData: titlesData,
                                                    borderData: borderData,
                                                    barGroups: barGroups,
                                                    gridData:
                                                        FlGridData(show: true),
                                                    alignment: BarChartAlignment
                                                        .spaceBetween,
                                                    maxY: 400,
                                                  ),
                                                ),
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.grey,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xff3cd2a5)),
                                                ),
                                              ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width: 350,
                                        // width:  MediaQuery.of(context).size.width * 0.82,
                                        // height: MediaQuery.of(context).size.height * 0.02,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 8,
                                                  width: 8,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: clrEdit),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Total Pengunjung: $totalPengunjung",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
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
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(13),
                      ),
                    ),
                    child: Column(
                      children: [
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
                          height: 320,
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          const Text(
                                            'Statistik Tanya Jawab',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            ' ( Periode - ${yearStart.text} )',
                                            style: const TextStyle(
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
                                        padding: const EdgeInsets.only(
                                            left: 0, top: 8, right: 5),
                                        width: 350,
                                        height: 180,
                                        child: !isProcess
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 0,
                                                    left: 0,
                                                    bottom: 0,
                                                    right: 0),
                                                child: LineChart(
                                                  LineChartData(
                                                    borderData: FlBorderData(
                                                        show: false),
                                                    titlesData: FlTitlesData(
                                                      topTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: false),
                                                      ),
                                                      rightTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                            showTitles: false),
                                                      ),
                                                      leftTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          showTitles: true,
                                                          getTitlesWidget:
                                                              leftTitleWidgets,
                                                          reservedSize: 20,
                                                          // interval: divY,
                                                          interval: 100,
                                                          // maxY: 400,
                                                        ),
                                                      ),
                                                      bottomTitles: AxisTitles(
                                                        sideTitles: SideTitles(
                                                          showTitles: true,
                                                          interval: 1,
                                                          getTitlesWidget:
                                                              bottomTitleWidgets,
                                                          reservedSize: 20,
                                                        ),
                                                      ),
                                                    ),
                                                    lineBarsData: [
                                                      LineChartBarData(
                                                        color: clrWait,
                                                        spots: [
                                                          FlSpot(
                                                              0,
                                                              listPertanyaan0
                                                                  .toDouble()),
                                                          FlSpot(
                                                              1,
                                                              listPertanyaan1
                                                                  .toDouble()),
                                                          FlSpot(
                                                              2,
                                                              listPertanyaan2
                                                                  .toDouble()),
                                                          FlSpot(
                                                              3,
                                                              listPertanyaan3
                                                                  .toDouble()),
                                                          FlSpot(
                                                              4,
                                                              listPertanyaan4
                                                                  .toDouble()),
                                                          FlSpot(
                                                              5,
                                                              listPertanyaan5
                                                                  .toDouble()),
                                                          FlSpot(
                                                              6,
                                                              listPertanyaan6
                                                                  .toDouble()),
                                                          FlSpot(
                                                              7,
                                                              listPertanyaan7
                                                                  .toDouble()),
                                                          FlSpot(
                                                              8,
                                                              listPertanyaan8
                                                                  .toDouble()),
                                                          FlSpot(
                                                              9,
                                                              listPertanyaan9
                                                                  .toDouble()),
                                                          FlSpot(
                                                              10,
                                                              listPertanyaan10
                                                                  .toDouble()),
                                                          FlSpot(
                                                              11,
                                                              listPertanyaan11
                                                                  .toDouble()),
                                                        ],
                                                      ),
                                                      LineChartBarData(
                                                        color: clrPrimary,
                                                        spots: [
                                                          FlSpot(
                                                              0,
                                                              listJawaban0
                                                                  .toDouble()),
                                                          FlSpot(
                                                              1,
                                                              listJawaban1
                                                                  .toDouble()),
                                                          FlSpot(
                                                              2,
                                                              listJawaban2
                                                                  .toDouble()),
                                                          FlSpot(
                                                              3,
                                                              listJawaban3
                                                                  .toDouble()),
                                                          FlSpot(
                                                              4,
                                                              listJawaban4
                                                                  .toDouble()),
                                                          FlSpot(
                                                              5,
                                                              listJawaban5
                                                                  .toDouble()),
                                                          FlSpot(
                                                              6,
                                                              listJawaban6
                                                                  .toDouble()),
                                                          FlSpot(
                                                              7,
                                                              listJawaban7
                                                                  .toDouble()),
                                                          FlSpot(
                                                              8,
                                                              listJawaban8
                                                                  .toDouble()),
                                                          FlSpot(
                                                              9,
                                                              listJawaban9
                                                                  .toDouble()),
                                                          FlSpot(
                                                              10,
                                                              listJawaban10
                                                                  .toDouble()),
                                                          FlSpot(
                                                              11,
                                                              listJawaban11
                                                                  .toDouble()),
                                                        ],
                                                      ),
                                                      LineChartBarData(
                                                        color: clrBadge,
                                                        spots: [
                                                          FlSpot(
                                                              0,
                                                              listBelumDijawab0
                                                                  .toDouble()),
                                                          FlSpot(
                                                              1,
                                                              listBelumDijawab1
                                                                  .toDouble()),
                                                          FlSpot(
                                                              2,
                                                              listBelumDijawab2
                                                                  .toDouble()),
                                                          FlSpot(
                                                              3,
                                                              listBelumDijawab3
                                                                  .toDouble()),
                                                          FlSpot(
                                                              4,
                                                              listBelumDijawab4
                                                                  .toDouble()),
                                                          FlSpot(
                                                              5,
                                                              listBelumDijawab5
                                                                  .toDouble()),
                                                          FlSpot(
                                                              6,
                                                              listBelumDijawab6
                                                                  .toDouble()),
                                                          FlSpot(
                                                              7,
                                                              listBelumDijawab7
                                                                  .toDouble()),
                                                          FlSpot(
                                                              8,
                                                              listBelumDijawab8
                                                                  .toDouble()),
                                                          FlSpot(
                                                              9,
                                                              listBelumDijawab9
                                                                  .toDouble()),
                                                          FlSpot(
                                                              10,
                                                              listBelumDijawab10
                                                                  .toDouble()),
                                                          FlSpot(
                                                              11,
                                                              listBelumDijawab11
                                                                  .toDouble()),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : const Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  backgroundColor: Colors.grey,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                              Color>(
                                                          Color(0xff3cd2a5)),
                                                ),
                                              ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      SizedBox(
                                        height: 60,
                                        width: 350,
                                        // width:  MediaQuery.of(context).size.width * 0.82,
                                        // height: MediaQuery.of(context).size.height * 0.02,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  height: 8,
                                                  width: 8,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: clrWait),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Total Pertanyaan: $totalListPertanyaan",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
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
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: clrPrimary),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Total Jawaban: $totalListJawaban",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
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
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: clrBadge),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  "Total Belum Dijawab: $totalListBelumDijawab",
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
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
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 8,
    );

    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('Jan', style: style);
        break;
      case 1:
        text = const Text('Feb', style: style);
        break;
      case 2:
        text = const Text('Mar', style: style);
        break;
      case 3:
        text = const Text('Apr', style: style);
        break;
      case 4:
        text = const Text('Mei', style: style);
        break;
      case 5:
        text = const Text('Jun', style: style);
        break;
      case 6:
        text = const Text('Jul', style: style);
        break;
      case 7:
        text = const Text('Agu', style: style);
        break;
      case 8:
        text = const Text('Sep', style: style);
        break;
      case 9:
        text = const Text('Okt', style: style);
        break;
      case 10:
        text = const Text('Nov', style: style);
        break;
      case 11:
        text = const Text('Des', style: style);
        break;

      default:
        text = const Text('');
        break;
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 20,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );

  Widget leftTitleWidgetss(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontSize: 8,
    );
    String text;
    int temp = 0;
    temp = value.toInt();
    text = temp.toString();

    return Text(text, style: style, textAlign: TextAlign.left);
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
            reservedSize: 25,
            getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 15,
              interval: 100,
              getTitlesWidget: leftTitleWidgetss),
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

  Widget bottomtitles(double value, TitleMeta meta) {
    const style = TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 5,
        overflow: TextOverflow.ellipsis);

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = name0;
        break;
      case 1:
        label = name1;
        break;
      case 2:
        label = name2;
        break;
      case 3:
        label = name3;
        break;
      case 4:
        label = name4;
        break;
      case 5:
        label = name5;
        break;
      case 6:
        label = name6;
        break;
      case 7:
        label = name7;
        break;
    }

    Widget text;
    text = SizedBox(
        height: 30, width: 50, child: Text(label, maxLines: 2, style: style));

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

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          x: 0,
          barRods: [
            BarChartRodData(
              toY: totalListBuruh.toDouble(),
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [
            0,
          ],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              toY: totalListHukum.toDouble(),
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [
            0,
          ],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              toY: totalListHutang.toDouble(),
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [
            0,
          ],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              toY: totalListLegal.toDouble(),
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [
            0,
          ],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              toY: totalListPendirian.toDouble(),
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [
            0,
          ],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              toY: totalListPernikahan.toDouble(),
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [
            0,
          ],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              toY: totalListPertanahan.toDouble(),
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [
            0,
          ],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              toY: totalListPidana.toDouble(),
              color: clrEdit,
            ),
          ],
          showingTooltipIndicators: [
            0,
          ],
        ),
      ];
}
