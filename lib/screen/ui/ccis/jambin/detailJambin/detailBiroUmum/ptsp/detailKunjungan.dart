import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../../../src/constant.dart';
import '../../../../../../../src/loader.dart';
import '../../../../../../../src/preference.dart';
import '../../../../../../../src/toast.dart';
import '../../../../constants/api.dart';
import '../../../../constants/defines.dart';

class DetailKunjunganPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailKunjunganPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailKunjunganPage> createState() => _DetailKunjunganPageState();
}

class _DetailKunjunganPageState extends State<DetailKunjunganPage> {
  late Widget body;
  String title = "JAMPIDUM";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();

  List listData = [];
  List arrSatkerId = [];
  String dropdownValue = '';
  String dropdownName = "";

  num totalOrang = 0;

  searchData(tahun) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
    });

    getData(year.toString());
  }

  getData(tahun) async {
    try {
      var params = jsonEncode({
        "nama": null,
        "detail": null,
        "no_hp": null,
        "email": null,
        "alamat": null,
        "no_identitas": null,
        "tipe_tamu": null,
        "tipe_pelayanan": null,
        "nama_pejabat": null,
        "jabatan": null,
        "satker": null,
        "offset": 0,
        "limit": 25
      });
      var response = await http.post(
          Uri.parse(ApiService.countTamuKunjunganCasys),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          for (int i = 0; i < content['data'].length; i++) {
            listData.add(content['data'][i]);
          }

          totalOrang = content['data'].length;
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context, "Err detail data jampidum"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  sessionToken() async {
    getData(year.toString());
  }

  selectyear(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Tahun"),
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

  selectsatker(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Tahun"),
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
                    "assets/icons/JAMBIN_logo.png",
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
                    "PTSP (LIST DATA BUKU TAMU)",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    "BIRO UMUM - JAMBIN",
                    style: TextStyle(color: clrEdit, fontSize: 12),
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
                        "Periode Tahun ${yearStart.text}",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "Total:  $totalOrang Orang",
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                        child: !isProcess
                            ? _buildListInspektorat()
                            : loaderDialog(context)),
                  ),
                  const SizedBox(height: 15),
                ],
              )
            : loaderDialog(context),
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
                                      "Detail",
                                      style: TextStyle(
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
                                          padding:
                                              const EdgeInsetsDirectional.all(
                                                  15),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  // ignore: prefer_interpolation_to_compose_strings
                                                  imageUrl: "https://bukutamu.kejaksaan.go.id/"+row['photo'],
                                                  placeholder: (context, url) =>
                                                      const CircularProgressIndicator(),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    "Nama: ${row['nama']?? "-"}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.white,),
                                                  ),
                                                  
                                                  Text(
                                                    "Keperluan: ${row['detail']?? "-"}",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.white,),
                                                  ),
                                                  ListTile(
                                                    leading:
                                                        const Icon(Icons.mobile_friendly, color: Colors.white,),
                                                    title: const Text(
                                                      "Nomor HP",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['no_hp'] ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading:
                                                        const Icon(Icons.email, color: Colors.white,),
                                                    title: const Text(
                                                      "Email",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['email'] ?? "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.badge, color: Colors.white,),
                                                    title: const Text(
                                                      "Jabatan",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['jabatan'] ?? "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.numbers, color: Colors.white,),
                                                    title: const Text(
                                                      "No Identitas",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['no_identitas'] ?? "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.people, color: Colors.white,),
                                                    title: const Text(
                                                      "Tipe Tamu",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['tipe_tamu'] ?? "",
                                                      maxLines: 15,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.security, color: Colors.white,),
                                                    title: const Text(
                                                      "Tipe Pelayanan",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['tipe_pelayanan'] ?? "",
                                                      maxLines: 15,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.person, color: Colors.white,),
                                                    title: const Text(
                                                      "Nama Pejabat",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['nama_pejabat'] ?? "",
                                                      maxLines: 15,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.date_range, color: Colors.white,),
                                                    title: const Text(
                                                      "Tanggal Kunjungan",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['tanggal_kunjungan'] ?? "",
                                                      maxLines: 15,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.note, color: Colors.white,),
                                                    title: const Text(
                                                      "Satker",
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['satker'] ?? "",
                                                      maxLines: 15,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                ],
                                              ),
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
                      "Nama: ${row['nama']?? "-"}",
                      maxLines: 2,
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
                          "Alamat : ${row['alamat'] ?? "-"}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Tipe Tamu : ${row['tipe_tamu']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        SizedBox(
                          width: 40,
                          height: 40,
                          child: Image(
                            image: NetworkImage("https://bukutamu.kejaksaan.go.id/"+row['photo']),
                            fit: BoxFit.cover,
                          ),
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
                    Text(
                      "Pengadilan : $judgement",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Putusan : $decision",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Upaya : $effort",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Eksekusi : $excecution",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "Keterangan : $information",
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
}

