import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loader.dart';
import '../../../src/preference.dart';
import '../../widget/custom_list_item.dart';
import 'report_add.dart';
import 'report_create.dart';

// ignore: must_be_immutable
class ReportList extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  String tanggal;
  ReportList({super.key, required this.tanggal});

  @override
  State<ReportList> createState() => _ReportListState();
}

class _ReportListState extends State<ReportList> {
  SharedPref sharedPref = SharedPref();
  List listData = [];
  bool isProcess = true;

  String formatTime(String dateTimeString) {
    DateTime time = DateFormat("HH:MM:SS").parse(dateTimeString);

    String formattedTime = DateFormat("HH:mm").format(time);
    return formattedTime;
  }

  String formatDate(String dateTimeString) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd");
    DateFormat outputFormat = DateFormat("dd-mm-yyy");
    DateTime time = inputFormat.parse(dateTimeString);

    String formattedTime = outputFormat.format(time);
    return formattedTime;
  }

  final ScrollController _scrollController = ScrollController();

  Future<void> getByDate(tgl) async {
    try {
      final params = {
        "tgl_kegiatan": tgl,
      };

      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.pelaporanDataAdmin;
      var uri = Uri.parse(url);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.post(uri,
          headers: {"Authorization": bearerToken.toString()}, body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = content['data'];
            print(listData);
          } else {
            listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // onBasicAlertPressed(context, 'Peringatan', "Data Tidak Dapat Ditemukan");
    }

    setState(() {
      isProcess = false;
    });
  }

  @override
  void initState() {
    getByDate(widget.tanggal);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrPrimary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const ReportAddpage(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        title: const Text(
          "List Kegiatan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: !isProcess
              ? listKegiatan()
              :
              // Center(child: Text("No Data Found"),)

              loaderDialog(context),
        ),
      ),
    );
  }

  Widget listKegiatan() {
    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = listData[index] as Map;

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ReportCreatePage(
                      kegiatanId: row['kegiatan_id'].toString(),
                      kegiatanTime: row['waktu'] ?? "",
                      kegiatanName: row['nama_kegiatan'] ?? "-",
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: CustomListItemTwo(
                  thumbnail: const Icon(
                    Icons.list_alt,
                    color: clrPrimary,
                  ),
                  title: row['nama_kegiatan'] ?? "-",
                  subtitle: row['deskripsi'] ?? "-",
                  ipAddress: "${row['waktu']} WIB",
                  icon: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
              ),
            );
          },
          itemCount: listData.isEmpty ? 0 : listData.length,
          separatorBuilder: (_, index) => const SizedBox(
            height: 5,
          ),
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.meeting_room,
                  size: 90.0,
                  color: Colors.grey.shade400,
                ),
                Text(
                  "Ooops, Belum Ada Kegiatan Ditanggal Ini!",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      );
    }
  }
}
