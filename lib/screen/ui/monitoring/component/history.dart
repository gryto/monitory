import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../src/api.dart';
import '../../../../src/constant.dart';
import '../../../../src/dialog_info.dart';
import '../../../../src/loader.dart';
import '../../../../src/preference.dart';
import 'package:badges/badges.dart' as badges;

class AsetHistoryPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final layananId;
  const AsetHistoryPage({super.key, this.layananId});

  @override
  State<AsetHistoryPage> createState() => _AsetHistoryPageState();
}

class _AsetHistoryPageState extends State<AsetHistoryPage> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  String category = "";

  @override
  void initState() {
    informasiLayananHistory(widget.layananId);
    super.initState();
  }

  informasiLayananHistory(id) async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.informasiLayananHistory;
      var uri = '$url/$id';
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = (content['data']);
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

  String formatDate(String dateTimeString) {
    DateTime time = DateFormat("yyyy-mm-dd").parse(dateTimeString);

    String formattedTime = DateFormat("dd-mm-yyyy").format(time);
    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: clrPrimary,
        title: const Text(
          "Sejarah Masuk/Keluar Aset",
          style: TextStyle(color: Colors.white),
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
      ),
      body: !isProcess
          ? ListView.separated(
              itemBuilder: (_, index) {
                var row = listData[index];
                return Column(
                  children: [
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
                                      padding: const EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Column(
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
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const Divider(
                                                thickness: 2,
                                              ),
                                              ListTile(
                                                title: Row(
                                                  children: [
                                                    const Text(
                                                      "Penaggung Jawab: ",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          height: 1.8,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    Text(
                                                      "${row['log_pj']} ",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.8,
                                                          fontWeight:
                                                              FontWeight.w700),
                                                    ),
                                                  ],
                                                ),
                                                subtitle: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Text(
                                                          row['log_flag'] == 1
                                                              ? "Tanggal Perolehan: "
                                                              : "Tanggal Aset Keluar: ",
                                                          style: const TextStyle(
                                                              fontSize: 16,
                                                              height: 1.5,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        ),
                                                        Text(
                                                          row['log_flag'] == 1
                                                              ? formatDate(row[
                                                                  'log_tgl_perolehan'])
                                                              : formatDate(row[
                                                                  'log_tgl_aset_keluar']),
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              height: 1.5,
                                                              color:
                                                                  row['log_flag'] ==
                                                                          1
                                                                      ? clrBadge
                                                                      : clrDelete,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    badges.Badge(
                                                      badgeStyle:
                                                          badges.BadgeStyle(
                                                        shape: badges
                                                            .BadgeShape.square,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        badgeColor:
                                                            row['log_flag'] == 1
                                                                ? clrBadge
                                                                : clrDelete,
                                                      ),
                                                      position:
                                                          badges.BadgePosition
                                                              .custom(
                                                                  start: 10,
                                                                  top: 10),
                                                      badgeContent: Text(
                                                        row['log_flag'] == 1
                                                            ? 'Aset Masuk'
                                                            : row['status'] == 2
                                                                ? 'Aset Keluar'
                                                                : 'Aset Keluar',
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      "Kategori "
                                                      "${row['log_kategori_barang']} ",
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          height: 1.5,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    Text(
                                                      row['log_nama_aset'] ??
                                                          "",
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          height: 1.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Text(
                                                      // ignore: prefer_interpolation_to_compose_strings
                                                      "${row['log_jumlah']} " +
                                                          row['log_satuan'],
                                                      style: const TextStyle(
                                                          fontSize: 12,
                                                          height: 1.5),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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
                      child: ListTile(
                        leading: Stack(
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                  color: row['log_flag'] == 1
                                      ? clrBadge
                                      : clrDelete,
                                  borderRadius: BorderRadius.circular(10)),
                              child: row['log_flag'] == 1
                                  ? const Icon(
                                      Icons.login,
                                      color: Colors.white,
                                    )
                                  : const Icon(
                                      Icons.logout,
                                      color: Colors.white,
                                    ),
                            ),
                          ],
                        ),
                        title: Text(
                          row['log_pj'] ?? '',
                          style: const TextStyle(
                              fontSize: 14,
                              height: 1.8,
                              fontWeight: FontWeight.w700),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              row['log_flag'] == 1
                                  ? formatDate(row['log_tgl_perolehan'])
                                  : formatDate(row['log_tgl_aset_keluar']),
                              style: TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: row['log_flag'] == 1
                                      ? clrBadge
                                      : clrDelete,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              row['log_kategori_barang'] ?? "",
                              style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              row['log_nama_aset'] ?? "",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.5,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              // ignore: prefer_interpolation_to_compose_strings
                              "${row['log_jumlah']} " + row['log_satuan'],
                              style: const TextStyle(fontSize: 12, height: 1.5),
                            ),
                          ],
                        ),
                        trailing: badges.Badge(
                          badgeStyle: badges.BadgeStyle(
                            shape: badges.BadgeShape.square,
                            borderRadius: BorderRadius.circular(5),
                            badgeColor:
                                row['log_flag'] == 1 ? clrBadge : clrDelete,
                          ),
                          position:
                              badges.BadgePosition.custom(start: 10, top: 10),
                          badgeContent: Text(
                            row['log_flag'] == 1
                                ? 'Aset Masuk'
                                : row['status'] == 2
                                    ? 'Aset Keluar'
                                    : 'Aset Keluar',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
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
