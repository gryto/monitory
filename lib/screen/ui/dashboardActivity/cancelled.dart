import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loading_fake.dart';
import '../../../src/preference.dart';
import '../../widget/list_tile_activity.dart';

class CancelledPage extends StatefulWidget {
  const CancelledPage({super.key});

  @override
  State<CancelledPage> createState() => _CancelledPageState();
}

class _CancelledPageState extends State<CancelledPage> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  List listDataBidang = [];
  List listFilterDataBidang = [];
  List arrBidangId = [];
  String dropdownName = "";

  final fieldKeyword = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 2;
  var status = "";

  @override
  void initState() {
    getBidangList();

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset + 10;
        });

        informasiLayanan(limit, offset, status);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void checkSession() async {
    informasiLayanan(limit, offset, status);
  }

  Future<void> informasiLayanan(status, limit, offset) async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.cancelledActivity;
      var uri = url;
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
      // onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      informasiLayanan(limit, offset, status);
    });
  }

  String dropdownValue = '';

  Future<void> getBidangList() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.bidangList;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          listDataBidang = (content['data']);

          for (int i = 0; i < listDataBidang.length; i++) {
            arrBidangId.add(listDataBidang[i]['bidang_id']);
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    informasiLayanan(limit, offset, status);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: clrPrimary,
        scrolledUnderElevation: 0,
        title: const Text(
          "Batal",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !isProcess
          ? RefreshIndicator(
              color: clrPrimary,
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 1500));
                setState(() {
                  isProcess = true;
                  listData.clear();
                  _pullRefresh();
                });
              },
              child: listAset())
          : const LoadingListPage(),
    );
  }

  Widget listAset() {
    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 11, top: 11),
        child: ListView.separated(
          padding: const EdgeInsets.only(bottom: 5, top: 5, right: 5.0),
          primary: true,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = listData[index];
            return ListTileActivityWidget(
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
                                  color: Colors.white,
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
                                                  imageUrl: row['path'] ?? null,
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
                                                    row['nama_kegiatan'] ?? "",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: clrPrimary),
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  ListTile(
                                                    leading:
                                                        const Icon(Icons.radar),
                                                    title: const Text(
                                                      "Kategori Kegiatan",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['kategori_kegiatan'] ??
                                                          "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading:
                                                        const Icon(Icons.room),
                                                    title: const Text(
                                                      "Ruangan",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['ruangan_name'] ?? "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.date_range),
                                                    title: const Text(
                                                      "Tanggal Kegiatan",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['tgl_kegiatan'] ?? "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.date_range),
                                                    title: const Text(
                                                      "Waktu",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['waktu'] + " WIB",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(
                                                        Icons.text_fields),
                                                    title: const Text(
                                                      "Deskripsi",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['deskripsi'],
                                                      maxLines: 15,
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.black,
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
              appLogoUrl: row['path'] ?? "",
              lastMessage: row['kategori_kegiatan'] ?? "",
              secondMessage: row['ruangan_name'] ?? "",
              title: row['nama_kegiatan'] ?? "",
              date: row['tgl_kegiatan'] ?? "",
              time: row['waktu'] ?? "",
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
            height: 5,
          ),
          itemCount: listData.isEmpty ? 0 : listData.length,
        ),
      );
    } else {
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            Icon(
              Icons.laptop_mac,
              size: 90.0,
              color: Colors.grey.shade400,
            ),
            Text(
              "Tidak Ada Kegiatan (Batal)",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }
  }
}
