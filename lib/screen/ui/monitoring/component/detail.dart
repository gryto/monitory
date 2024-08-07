import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../src/api.dart';
import '../../../../src/constant.dart';
import '../../../../src/dialog_info.dart';
import '../../../../src/loader.dart';
import '../../../../src/preference.dart';
import 'package:badges/badges.dart' as badges;
import 'history.dart';

// ignore: must_be_immutable
class DetailAsetPage extends StatefulWidget {
  String id;
  String title;
  DetailAsetPage({super.key, required this.id, required this.title});

  @override
  State<DetailAsetPage> createState() => _DetailAsetPageState();
}

class _DetailAsetPageState extends State<DetailAsetPage> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  String category = "";

  @override
  void initState() {
    informasiLayananAset(widget.id);
    super.initState();
  }

  informasiLayananAset(id) async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.informasiLayananAset;
      var uri = '$url/$id';
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData.add(content['data'][0]);
          } else {
            //listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
      // toastShort(context, e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                widget.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AsetHistoryPage(layananId: widget.id),
                  ),
                );
              },
              child: const Icon(Icons.history),
            )
          ],
        ),
        elevation: 0,
      ),
      body: !isProcess
          ? ListView.separated(
              itemBuilder: (_, index) {
                var row = listData[index];
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Container(
                        width: w,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2.0),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            Container(
                              height: 300,
                              width: 530,
                              decoration: const BoxDecoration(),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  row['path'] ?? "",
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    row['kategori'] ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    row['nama_aset'] ?? "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w800,
                                        color: clrPrimary),
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          badges.Badge(
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              badgeColor:
                                                  row['flag'].toString() == "1"
                                                      ? clrBadge
                                                      : clrDelete,
                                            ),
                                            position:
                                                badges.BadgePosition.custom(
                                                    start: 10, top: 10),
                                            badgeContent: Text(
                                              row['flag'].toString() == "1"
                                                  ? "Aset Masuk"
                                                  : "Aset Keluar",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          badges.Badge(
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              badgeColor: row['kondisi']
                                                          .toString() ==
                                                      "1"
                                                  ? clrBadge
                                                  : row['kondisi'].toString() ==
                                                          "2"
                                                      ? clrEdit
                                                      : clrDelete,
                                            ),
                                            position:
                                                badges.BadgePosition.custom(
                                                    start: 10, top: 10),
                                            badgeContent: Text(
                                              row['kondisi'].toString() == "1"
                                                  ? "Baik"
                                                  : row['kondisi'].toString() ==
                                                          "2"
                                                      ? "Rusak Ringan"
                                                      : "Rusak Berat",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 5,
                                          ),
                                          badges.Badge(
                                            badgeStyle: badges.BadgeStyle(
                                              shape: badges.BadgeShape.square,
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              badgeColor: row['status_aset']
                                                          .toString() ==
                                                      "1"
                                                  ? clrBadge
                                                  : clrDelete,
                                            ),
                                            position:
                                                badges.BadgePosition.custom(
                                                    start: 10, top: 10),
                                            badgeContent: Text(
                                              row['status_aset'].toString() ==
                                                      "1"
                                                  ? "Aktif"
                                                  : "Tidak Aktif",
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  ListTile(
                                    leading:
                                        const Icon(Icons.confirmation_number),
                                    title: const Text(
                                      "Penaggung Jawab",
                                      style:
                                          TextStyle(fontSize: 12, height: 1.8),
                                    ),
                                    subtitle: Text(
                                      "${row['pj']}",
                                      // "15 Buah",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  ListTile(
                                    leading:
                                        const Icon(Icons.confirmation_number),
                                    title: const Text(
                                      "Tanggal Perolehan",
                                      style:
                                          TextStyle(fontSize: 12, height: 1.8),
                                    ),
                                    subtitle: Text(
                                      "${row['tgl_perolehan']}",
                                      // "15 Buah",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  ListTile(
                                    leading:
                                        const Icon(Icons.confirmation_number),
                                    title: const Text(
                                      "Jumlah Barang",
                                      style:
                                          TextStyle(fontSize: 12, height: 1.8),
                                    ),
                                    subtitle: Text(
                                      "${row['jumlah']} ${row['satuan']} ",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.radar),
                                    title: const Text(
                                      "Masa Manfaat",
                                      style:
                                          TextStyle(fontSize: 12, height: 1.8),
                                    ),
                                    subtitle: Text(
                                      "${row['masa']} Bulan",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.text_fields),
                                    title: const Text(
                                      "Keterangan",
                                      style:
                                          TextStyle(fontSize: 12, height: 1.8),
                                    ),
                                    subtitle: Text(
                                      row['keterangan'] ?? "",
                                      style: const TextStyle(
                                          fontSize: 16,
                                          height: 1.5,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              itemCount: listData.isEmpty ? 0 : listData.length,
              separatorBuilder: (_, index) => const SizedBox(
                height: 5,
              ),
            )
          : loaderDialog(context),
    );
  }
}
