import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:monitoriy/src/constant.dart';
import '../../../../../src/preference.dart';
import '../../../../../src/toast.dart';
import '../../constants/api.dart';
import '../../constants/defines.dart';

class LaporanNonteknis extends StatefulWidget {
  const LaporanNonteknis({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LaporanNonteknisState createState() => _LaporanNonteknisState();
}

class _LaporanNonteknisState extends State<LaporanNonteknis> {
  late Widget body;
  String title = "Laporan Non Teknis";
  String subtitle = "Sumber : SADAP ( https://satudatawas.id/ )";
  List listData = [];

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  final String lblTarget = "Target";
  final String lblRealization = "Realisasi";

  getData() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.nonteknis;
      var uri = url;
      print(uri);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = content['data'];
            print("coba$listData");
          } else {
            listData.addAll(content['data'].toList());
          }
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context, "Err list data jamwas"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
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
                      "JAMDPIDMIL",
                      style: TextStyle(color: clrBadge, fontSize: 12),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
        child: !isProcess
            ? ListView(
                children: [
                  const SizedBox(height: kSpacing),
                  const Row(
                    children: [
                      Text(
                        "Periode Tahun 2022",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      Spacer(),
                    ],
                  ),
                  const Text(
                    "Laporan Non Teknis",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      child: !isProcess
                          ? _buildListNonteknis()
                          : const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff3cd2a5),
                                ),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Color(0xff3cd2a5),
                  ),
                ),
              ),
      ),
    );
  }

  alertJamwasNonteknisDialog(
      ctx, status, total, incoming, process, jaksa, teknis, date, all) {
    return showDialog(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 13, 30, 46),
          title: Text(
            status,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nama Area : $total",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Bulan Laporan : $incoming",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Judul : $process",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Deskripsi : $jaksa",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Tipe : $teknis",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Tipe : $date",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    all != 0
                        ? Text(
                            "Status : $all",
                            style: const TextStyle(fontSize: 12, color: Colors.white),
                          )
                        : Container()
                  ],
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildListNonteknis() {
    String formatTime(String dateTimeString) {
      DateTime time = DateFormat("yyyy-mm-dd HH:MM:SS").parse(dateTimeString);

      String formattedTime = DateFormat("dd-mm-yyyy").format(time);
      return formattedTime;
    }

    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var row = listData[index];

              return GestureDetector(
                onTap: () {
                  alertJamwasNonteknisDialog(
                      context,
                      row['nama_area'],
                      row['report_date'],
                      row['title'],
                      row['description'],
                      row['type'],
                      "${formatTime(row['submit_date'])} WIB",
                      // formatTime(row['submit_date']),
                      row['status'] == 1 ? "Aktif" : "Tidak Aktif",
                      0);
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xff3cd2a5)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    dense: true,
                    contentPadding:
                        const EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Area : ${row['nama_area']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Bulan Laporan : ${row['report_date']}",
                          style: const TextStyle(fontSize: 12,color: Colors.white,),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Judul : ${row['title']}",
                          style: const TextStyle(fontSize: 12,color: Colors.white,),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: const Icon(Icons.more_vert),
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => const SizedBox(
                  height: 1,
                ),
            itemCount: listData.isEmpty ? 0 : listData.length),
      );
    } else {
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
              child: const Text("Data tidak ditemukan",
                style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      );
    }
  }
}
