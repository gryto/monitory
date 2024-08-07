import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/preference.dart';
import '../../../../../src/toast.dart';
import '../../constants/api.dart';
import '../../constants/defines.dart';

class Lapinhar extends StatefulWidget {
  final String accessToken, tahun;
  const Lapinhar({Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<Lapinhar> createState() => _LapinharState();
}

class _LapinharState extends State<Lapinhar> {
  late Widget body;
  String title = "LAPINHAR";
  String subtitle = "Sumber : SADAP ( https://satudatawas.id/ )";
  List listData = [];
  num totalLapinhar = 0;
  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  num year = 0;
  TextEditingController yearStart = TextEditingController();
  DateTime today = DateTime.now();
  DateTime _selectedYear = DateTime.now();

  final String lblTarget = "Target";
  final String lblRealization = "Realisasi";

  searchData(tahun) {
    setState(() {
      listData.clear();
      isProcess = true;
      year = int.parse(tahun);
    });

    getData(year.toString());
  }

  getData(tahun) async {
    try {
      var params = jsonEncode({"tahun": tahun.toString()});
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
          if (listData.isEmpty) {
            for (int i = 0; i < content['data']['data'].length; i++) {
              listData.add(content['data']['data'][i]);
            }
            totalLapinhar = (content['data']['recordsTotal']);
            // print(totalLapinhar.toString());
            // print("coba$listDataLapinhar");
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
                      "assets/icons/jamintel.png",
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
                      "JAMINTEL",
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
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
        child: !isProcess
            ? ListView(
                children: [
                  const SizedBox(height: kSpacing),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Jamintel - Periode Tahun ${yearStart.text}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
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
                                    builder: (BuildContext context, setState) =>
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
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600),
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 20.0),
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 5.0),
                                                decoration: BoxDecoration(
                                                  color: clrBadge,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
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
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "LAPINHAR",
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text(
                        "Total: $totalLapinhar Orang",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 14),
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

  Widget _buildListSumber() {
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
                          color: Colors.white),
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
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Isi Surat : ${row['isi_surat'] ?? "-"}",
                          style: const TextStyle(
                              fontSize: 12, color: Colors.white),
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
          backgroundColor: const Color.fromARGB(255, 13, 30, 46),
          title: Text(
            status,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
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
                      style: const TextStyle(fontSize: 12, color: Colors.white),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "isi_surat : $incoming",
                      style: const TextStyle(fontSize: 12, color: Colors.white),
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
}
