import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loader.dart';
import '../../../src/preference.dart';
import '../../widget/custom_button_primary.dart';
import 'report_page.dart';

class ReportCreatePage extends StatefulWidget {
  final String kegiatanId, kegiatanTime, kegiatanName;

  const ReportCreatePage({
    Key? key,
    required this.kegiatanId,
    required this.kegiatanTime,
    required this.kegiatanName,
  }) : super(key: key);

  @override
  State<ReportCreatePage> createState() => _ReportCreatePageState();
}

class _ReportCreatePageState extends State<ReportCreatePage> {
  SharedPref sharedPref = SharedPref();
  List listData = [];
  bool isProcess = false;
  bool isEdit = false;
  String fullName = "";
  String typeUser = "";
  String id = "";
  String path = "";
  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  TextEditingController ctrlMom = TextEditingController();

  Future<void> submitData(kegiatanId) async {
    var userId = await sharedPref.getPref("id");
    print("user" + userId);

    try {
      final params = {
        "kegiatan_id": kegiatanId,
        "mom": ctrlMom.text,
        "created_by": userId
      };

      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.pelaporanDataAdd;
      var uri = Uri.parse(url);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.post(uri,
          headers: {"Authorization": bearerToken.toString()}, body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == true) {
        // ignore: use_build_context_synchronously
        _onAlertButtonPressed(context, true, "Data Berhasil Dibuat");

        setState(() {
          kegiatanId;
          ctrlMom.text = "";
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Peringatan', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  void moveToSecondPage() async {
    !isProcess
        ? Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ReportPage()),
          )
        : loaderDialog(context);
  }

  _onAlertButtonPressed(context, status, message) {
    Alert(
      context: context,
      type: !status ? AlertType.error : AlertType.success,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          color: clrBadge,
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  void checkSession() async {
    var userFullname = await sharedPref.getPref("name");
    var userRole = await sharedPref.getPref("level");
    var userId = await sharedPref.getPref("id");
    var userPath = await sharedPref.getPref("path");

    setState(() {
      fullName = userFullname;
      typeUser = userRole == "1"
          ? 'Administrator'
          : userRole == "2"
              ? 'Pimpinan'
              : 'User';
      id = userId;
      path = userPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;
    final txtMom = TextFormField(
      focusNode: _focusNodes[0],
      controller: ctrlMom,
      decoration: InputDecoration(
        hoverColor: clrPrimary,
        hintText: '(Optional) Masukkan Deskripsi Laporan',
        label: Row(
          children: [
            Text(
              "Laporan",
              style: TextStyle(
                  color: _focusNodes[0].hasFocus ? clrPrimary : Colors.grey),
            ),
            const Padding(
              padding: EdgeInsets.all(3.0),
            ),
          ],
        ),
        focusedBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          borderSide: BorderSide(color: Colors.grey),
        ),
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.note_add,
          color: _focusNodes[0].hasFocus ? clrPrimary : Colors.grey,
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Text(
          "Ringkasan MoM",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const ReportPage(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
                child: Text(
                  "Detail kegiatan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              ListTile(
                title: Text("Nama Kegiatan: ${widget.kegiatanName}"),
                subtitle: Text("Waktu: ${widget.kegiatanTime} WIB"),
              ),
              // ReportActivityPage(
              //   condition: "Aktif",
              //   count: widget.bookingJumlahPeserta,
              //   user: widget.bookingPemohon,
              //   date: widget.bookingTanggal,
              //   startTime: widget.bookingWaktuMulai,
              //   endTime: widget.bookingWaktuSelesai,
              //   description: widget.bookingKegiatan,
              // ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
                child: Text(
                  "Laporan",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  width: w,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: const [
                      BoxShadow(
                        color: clrShadow,
                        blurRadius: 1.0,
                        spreadRadius: 0.5,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 8, left: 15),
                        child: Text(
                          "Masukkan Catatan Laporan",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.w500),
                        ),
                      ),
                      txtMom,
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20),
                child: CustomButtonPrimary(
                  text: "Buat MoM",
                  onTap: () {
                    submitData(widget.kegiatanId);
                    moveToSecondPage();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
