import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loader.dart';
import '../../../src/preference.dart';
import '../../widget/custom_button_primary.dart';
import 'report_page.dart';

class ReportEditPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  const ReportEditPage({super.key, this.id});

  @override
  State<ReportEditPage> createState() => _ReportEditPageState();
}

class _ReportEditPageState extends State<ReportEditPage> {
  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = false;
  List listData = [];
  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  TextEditingController ctrlMom = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  String id = "";

  Future<void> getData(pelaporanId) async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.pelaporanDataById;
      var uri = '$url/$pelaporanId';
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = (content['data']);
          } else {
            // listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', "content['message']");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  @override
  void initState() {
    getData(widget.id);

    super.initState();
  }

  removeHtml(html) {
    var doc = parse(html);
    if (doc.documentElement != null) {
      String parsedstring = doc.documentElement!.text;
      return stripHtmlIfNeeded(parsedstring);
    }
  }

  String stripHtmlIfNeeded(String text) {
    return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
  }

  void checkSession() async {
    var pelaporanid = await sharedPref.getPref("pelaporan_id");

    setState(() {
      id = pelaporanid;
    });
  }

  Future<void> updateData(pelaporanId) async {
    try {
      final params = jsonEncode({
        "id": pelaporanId,
        "mom": ctrlMom.text,
      });

      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.pelaporanDataUpdate;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.post(Uri.parse(uri),
          headers: {
            "Content-Type": "application/json",
            "Authorization": bearerToken.toString()
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == true) {
        // ignore: use_build_context_synchronously
        _onAlertButtonPressed(context, true, "Data Berhasil Diperbaharui");

        setState(() {
          id;
          ctrlMom.text = "";
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
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

  void moveToSecondPage() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const ReportPage(),
      ),
    );
  }

  String formatTime(String dateTimeString) {
    DateTime time = DateFormat("HH:MM:SS").parse(dateTimeString);

    String formattedTime = DateFormat("HH:mm").format(time);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: clrPrimary,
        title: const Text(
          "Ubah MoM Kegiatan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: isProcess ? updateMom() : loaderDialog(context),
        ),
      ),
    );
  }

  Widget updateMom() {
    double w = MediaQuery.of(context).size.width - 0;

    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = listData[index] as Map;
            String document = stripHtmlIfNeeded(row["mom"] ?? "");
            ctrlMom.text = document;

            return Column(
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
                  title: Text("Nama Kegiatan: ${row['nama_kegiatan']}"),
                  subtitle: Text("Waktu: ${row['waktu']} WIB"),
                ),
                const SizedBox(
                  height: 25,
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
                          padding: EdgeInsets.only(top: 8, left: 12),
                          child: Text(
                            "Masukkan Catatan Laporan",
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
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
                                      color: _focusNodes[0].hasFocus
                                          ? clrPrimary
                                          : Colors.grey),
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
                              color: _focusNodes[0].hasFocus
                                  ? clrPrimary
                                  : Colors.grey,
                            ),
                            suffixIcon: Icon(
                              Icons.edit,
                              color: _focusNodes[0].hasFocus
                                  ? clrPrimary
                                  : Colors.grey,
                              size: 20,
                            ),
                          ),
                          maxLines: null,
                          // any number you need (It works as the rows for the textarea)
                          keyboardType: TextInputType.multiline,
                        ),
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
                    text: "Ubah MoM",
                    onTap: () {
                      updateData(row['pelaporan_id']);
                      moveToSecondPage();
                    },
                  ),
                ),
              ],
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
                  Icons.laptop_mac,
                  size: 90.0,
                  color: Colors.grey.shade400,
                ),
                Text(
                  "Ooops, Belum Ada Data Yang Dilaporkan Nih!",
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
