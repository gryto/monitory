import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../../../src/constant.dart';
import '../../../../../../../src/preference.dart';
import '../../../../../../../src/toast.dart';
import '../../../../constants/api.dart';
import '../../../../constants/defines.dart';

class DetailCutiPage extends StatefulWidget {
  final String accessToken, tahun, id;
  const DetailCutiPage(
      {Key? key,
      required this.accessToken,
      required this.tahun,
      required this.id})
      : super(key: key);

  @override
  State<DetailCutiPage> createState() => _DetailCutiPageState();
}

class _DetailCutiPageState extends State<DetailCutiPage> {
  late Widget body;

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  List listData = [];
  List arrSatkerId = [];
  String dropdownValue = '';
  String dropdownName = "";

  num totalOrang = 0;

  getData(id) async {
    try {
      var params = jsonEncode({
        "id": id,
        "page": 1, //ga di pake
        "start": 0
      });
      var response = await http.post(
          Uri.parse(ApiService.countAbsensiListCasys),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          for (int i = 0; i < content['data']['absensiData'].length; i++) {
            listData.add(content['data']['absensiData'][i]);
          }

          totalOrang = content['data']['totalData'];
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
    getData(widget.id);
  }

  checkSession() async {
    getData(widget.id);
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
                    "Detail Absensi (Kejaksaan Mobile)",
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
                          : const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xff3cd2a5)),
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
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3cd2a5)),
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
                                            padding:
                                                const EdgeInsetsDirectional.all(
                                                    15),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      "NIP: ${row['nip'] ?? "-"}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                      "Nama Lengkap: ${row['nama'] ?? "-"}",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w800,
                                                          color: Colors.white),
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                        Icons.mobile_friendly,
                                                        color: Colors.white,
                                                      ),
                                                      title: const Text(
                                                        "Satuan Kerja",
                                                        style: TextStyle(
                                                            fontSize: 12,
                                                            height: 1.8,
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      subtitle: Text(
                                                        row['nama_satker'] ??
                                                            "",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            height: 1.5,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                        Icons.email,
                                                        color: Colors.white,
                                                      ),
                                                      title: const Text(
                                                        "Status",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            height: 1.8),
                                                      ),
                                                      subtitle: Text(
                                                        row['status'] ?? "",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            height: 1.5,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                        Icons.badge,
                                                        color: Colors.white,
                                                      ),
                                                      title: const Text(
                                                        "Jam Masuk",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            height: 1.8),
                                                      ),
                                                      subtitle: Text(
                                                        row['in_absen'] ?? "",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            height: 1.5,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
                                                      ),
                                                    ),
                                                    ListTile(
                                                      leading: const Icon(
                                                        Icons.numbers,
                                                        color: Colors.white,
                                                      ),
                                                      title: const Text(
                                                        "Jam Keluar",
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 12,
                                                            height: 1.8),
                                                      ),
                                                      subtitle: Text(
                                                        row['out_absen'] ?? "",
                                                        style: const TextStyle(
                                                            fontSize: 16,
                                                            height: 1.5,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w400),
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
                      "NIP: ${row['nip'] ?? "-"}",
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
                          "Nama Lengkap : ${row['nama'] ?? "-"}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Satuan Kerja : ${row['nama_satker']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Status : ${row['status']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Jam Masuk : ${row['in_absen']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          "Jam Keluar : ${row['out_absen']}",
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
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
}
