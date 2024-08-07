import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../../src/constant.dart';
import '../../../../src/loader.dart';
import '../../../../src/logout.dart';
import '../../../../src/preference.dart';
import '../../../../src/toast.dart';
import '../constants/api.dart';
import '../constants/defines.dart';
import '../shared_components/header_text.dart';

class DetailJamintel extends StatefulWidget {
  final String accessToken, tahun;

  const DetailJamintel(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DetailJamintelState createState() => _DetailJamintelState();
}

class _DetailJamintelState extends State<DetailJamintel> {
  late Widget body;
  String title = "JAMINTEL";
  String subtitle = "Sumber : SADAP ( https://satudatawas.id/ )";
  List listData = [];
  num totalPencarian = 0;
  num totalLapinhar = 0;
  num totalDaftang = 0;
  List listDataLapinhar = [];
  List listDataDaftang = [];
  List listBuruhTenagaKerjaData = [];
  var arrBuruhTenagaKerjaData = [];
  var tempData = [0];

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  final String lblTarget = "Target";
  final String lblRealization = "Realisasi";

  getData() async {
    try {
      var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.dpo),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      // print("coba$content");

      if (content['status'] == 200) {
        setState(() {
          if (listData.isEmpty) {
            for (int i = 0; i < content['data']['data'].length; i++) {
              listData.add(content['data']['data'][i]);
            }

            totalPencarian = (content['data']['recordsTotal']);
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

  getDataLapinhar() async {
    try {
      var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.lapinhar),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      // print("lapinhar"+content.toString());

      if (content['status'] == 200) {
        setState(() {
          if (listDataLapinhar.isEmpty) {
            for (int i = 0; i < content['data']['data'].length; i++) {
              listDataLapinhar.add(content['data']['data'][i]);
            }
            totalLapinhar = (content['data']['recordsTotal']);
            // print(totalLapinhar.toString());
            // print("coba$listDataLapinhar");
          } else {
            listDataLapinhar.addAll(content['data'].toList());
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

  getDataDaftang() async {
    try {
      var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.daftarTangkapan),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("daftang$content");

      if (content['status'] == 200) {
        setState(() {
          if (listDataDaftang.isEmpty) {
            for (int i = 0; i < content['data']['data'].length; i++) {
              listDataDaftang.add(content['data']['data'][i]);
            }
            totalDaftang = (content['data']['recordsTotal']);
            // print(totalDaftang.toString());
            // print("coba$listDataDaftang");
          } else {
            listDataDaftang.addAll(content['data'].toList());
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
    getDataLapinhar();
    getDataDaftang();
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
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            widgets,
            GestureDetector(
              onTap: () {
                logoutDialog(context);
              },
              child: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: clrPrimary,
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 250.0,
            width: 600.0,
            child: InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse(
                      'http://u4.cloudkejaksaan.my.id/dashboard-jamintel/dpo/maps')),
              initialOptions: InAppWebViewGroupOptions(
                crossPlatform: InAppWebViewOptions(
                  preferredContentMode: UserPreferredContentMode.MOBILE,
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          // Padding(padding: EdgeInsets.all(10), child: ,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 0, left: 10, right: 10, bottom: 10),
              child: !isProcess
                  ? ListView(
                      children: [
                        const SizedBox(height: kSpacing),
                        const Row(
                          children: [
                            // HeaderText('Jamwas - Periode 2022'),
                            HeaderText('Jamintel - Periode 2022'),
                            Spacer(),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HeaderText("Daftar Pencarian"),
                            Text(
                              "Total: $totalPencarian Orang",
                            ),
                          ],
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HeaderText("LAPINHAR"),
                            Text(
                              "Total: $totalLapinhar Orang",
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Container(
                            child: !isProcess
                                ? _buildListSumber()
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const HeaderText("Daftar Tangkapan"),
                            Text(
                              "Total: $totalDaftang Orang",
                            ),
                          ],
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
                        const SizedBox(height: kSpacing),
                      ],
                    )
                  : loaderDialog(context),
            ),
          ),
        ],
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
                  // alertJamwasDialog(
                  //   context,
                  //   // const Text("Detail Laporan Koneksitas"),
                  //   row['register'],
                  //   row['sprint'],
                  //   row['cases'],
                  //   row['sipil'],
                  //   row['militer'],
                  //   row['bukti'],
                  //   row['penahanan'],
                  //   row['keppera'],
                  //   row['pasal'],
                  //   row['pelimpahan'],
                  //   row['tuntutan'],
                  //   row['no_putusan'],
                  //   row['penahanan'],
                  //   row['pengadilan'],
                  //   row['putusan'],
                  //   row['upaya'],
                  //   row['eksekusi'],
                  //   row['keterangan'],
                  //   0,
                  // );
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

                      "Nama : ${row['nama_lengkap']}",
                      style: const TextStyle(
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
                          "Nomor Buronan : ${row['nomor_buron']}",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "NIK : ${row['nik'] ?? "-"}",
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Tahun : ${row['tahun'] ?? "-"}",
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Jenis Perkara : ${row['jenis_perkara'] ?? "-"}",
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Status : ${row['status_dpo'] ?? "-"}",
                          style: const TextStyle(fontSize: 12),
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
              child: const Text("Data tidak ditemukan"),
            ),
          ],
        ),
      );
    }
  }

  Widget _buildListSumber() {
    if (listDataLapinhar.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var row = listDataLapinhar[index];

              return GestureDetector(
                onTap: () {
                  alertJamwasDialog(
                    context,
                    // const Text("Detail Laporan Koneksitas"),
                    row['nomor_surat'],
                    row['tanggal_surat'],
                    row['isi_surat'],
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

                      "Nomor Surat : ${row['nomor_surat']}",
                      style: const TextStyle(
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
                          "Tanggal : ${row['tanggal_surat']}",
                          style: const TextStyle(fontSize: 12),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Isi Surat : ${row['isi_surat'] ?? "-"}",
                          style: const TextStyle(fontSize: 12),
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
            itemCount: listDataLapinhar.isEmpty ? 0 : listDataLapinhar.length),
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
              child: const Text("Data tidak ditemukan"),
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
  ) {
    return showDialog(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            status,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "tanggal_surat : $total",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "isi_surat : $incoming",
                      style: const TextStyle(fontSize: 12),
                      maxLines: 45,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 2,
                    ),
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

  alertJamwasKoordinasiDialog(
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
      all) {
    return showDialog(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            status,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Cases : $incoming",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Sipil : $process",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Militer : $jaksa",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Bukti : $teknis",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Penahanan : $remaining",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Keppera : $evidence",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Pasal : $proven",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Pelimpahan : $unproven",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Tuntutan : $clarification",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "No Putusan : $completion",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    all != 0
                        ? Text(
                            "Laporan Keseluruhan : $all",
                            style: const TextStyle(fontSize: 12),
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

  alertJamwasNonteknisDialog(
      ctx, status, total, incoming, process, jaksa, teknis, date, all) {
    return showDialog(
      context: ctx,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            status,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Bulan Laporan : $incoming",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Judul : $process",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Deskripsi : $jaksa",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Tipe : $teknis",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Tipe : $date",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    all != 0
                        ? Text(
                            "Status : $all",
                            style: const TextStyle(fontSize: 12),
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

    if (listDataDaftang.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var row = listDataDaftang[index];

              return GestureDetector(
                onTap: () {
                  // alertJamwasNonteknisDialog(
                  //     context,
                  //     row['nama_area'],
                  //     row['report_date'],
                  //     row['title'],
                  //     row['description'],
                  //     row['type'],
                  //     "${formatTime(row['submit_date'])} WIB",
                  //     // formatTime(row['submit_date']),
                  //     row['status'] == 1 ? "Aktif" : "Tidak Aktif",
                  //     0);
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
                      "Nama : ${row['nama'] ?? ""}",
                      style: const TextStyle(
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
                        // CircleAvatar(
                        //   radius: 20,
                        //   backgroundColor: clrPrimary,
                        //   child: CircleAvatar(
                        //     radius: 18,
                        //     backgroundImage:
                        //     NetworkImage(
                        //      'https://ccis.kejaksaan.go.id/upload/images/dd608a9f-eaaf-4504-88a3-db55f3e59d2a.png',
                        //       // scale: 5,
                        //     ),
                        //   ),
                        // ),
                        // Image.network(row['foto'] ?? ""),
                        // Text(
                        //   "Foto : ${row['foto']?? ""}",
                        //   style: const TextStyle(fontSize: 12),
                        //   maxLines: 2,
                        //   overflow: TextOverflow.ellipsis,
                        // ),
                        const SizedBox(height: 2),
                        Text(
                          "Tanggal : ${row['tanggal_penangkapan'] ?? ""}",
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Perkara : ${row['perkara'] ?? ""}",
                          style: const TextStyle(fontSize: 12),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Asal : ${row['asal'] ?? ""}",
                          style: const TextStyle(fontSize: 12),
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
            itemCount: listDataDaftang.isEmpty ? 0 : listDataDaftang.length),
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
              child: const Text("Data tidak ditemukan"),
            ),
          ],
        ),
      );
    }
  }
}
