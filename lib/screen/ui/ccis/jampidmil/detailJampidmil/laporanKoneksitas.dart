import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:monitoriy/src/constant.dart';
import '../../../../../src/preference.dart';
import '../../../../../src/toast.dart';
import '../../constants/api.dart';
import '../../constants/defines.dart';

class LaporanKoneksitas extends StatefulWidget {
  const LaporanKoneksitas({
    Key? key,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LaporanKoneksitasState createState() => _LaporanKoneksitasState();
}

class _LaporanKoneksitasState extends State<LaporanKoneksitas> {
  late Widget body;
  String title = "Laporan Koneksitas";
  List listData = [];

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  final String lblTarget = "Target";
  final String lblRealization = "Realisasi";

  getData() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.koneksitas;
      var uri = url;
      print(uri);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      print(response.statusCode);
      print("content");
      print(content.toString());

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
                    "Laporan Koneksitas",
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
                          ? _buildListInspektorat()
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

  Widget _buildListInspektorat() {
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
                  alertJamwasDialog(
                    context,
                    // const Text("Detail Laporan Koneksitas"),
                    row['register'],
                    row['sprint'],
                    row['cases'],
                    row['sipil'],
                    row['militer'],
                    row['bukti'],
                    row['penahanan'],
                    row['keppera'],
                    row['pasal'],
                    row['pelimpahan'],
                    row['tuntutan'],
                    row['no_putusan'],
                    row['penahanan'],
                    row['pengadilan'],
                    row['putusan'],
                    row['upaya'],
                    row['eksekusi'],
                    row['keterangan'],
                    0,
                  );
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
                      // row['register']?? "",

                      "Register : ${row['register']}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Sprint : ${row['sprint']}",
                          style: const TextStyle(fontSize: 12,color: Colors.white,),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Case : ${row['cases']}",
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
              child: const Text(
                "Data tidak ditemukan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }

  alertJamwasDialog(
      ctx,
      status,
      total,
      incoming,
      process,
      jaksa,
      teknis,
      remaining,
      evidence,
      proven,
      unproven,
      clarification,
      completion,
      judgement,
      decision,
      effort,
      excecution,
      information,
      date,
      all) {
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
                      "Sprint : $total",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Cases : $incoming",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Sipil : $process",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Militer : $jaksa",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Bukti : $teknis",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Penahanan : $remaining",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Keppera : $evidence",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Pasal : $proven",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Pelimpahan : $unproven",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Tuntutan : $clarification",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "No Putusan : $completion",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Pengadilan : $judgement",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Putusan : $decision",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Upaya : $effort",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Eksekusi : $excecution",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Keterangan : $information",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    all != 0
                        ? Text(
                            "Laporan Keseluruhan : $all",
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
}
