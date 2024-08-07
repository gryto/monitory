import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loading_fake.dart';
import '../../../src/preference.dart';
import '../../widget/custom_button_primary.dart';
import '../../widget/fill_image_aset_card.dart';
import 'page.dart';
import 'package:badges/badges.dart' as badges;

class ListAsetPage extends StatefulWidget {
  const ListAsetPage({super.key});

  @override
  State<ListAsetPage> createState() => _ListAsetPageState();
}

class _ListAsetPageState extends State<ListAsetPage> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  final _formKey = GlobalKey<FormState>();
  List listData = [];
  List listDataBidang = [];
  List listFilterDataBidang = [];
  List arrBidangId = [];
  String dropdownName = "";



  final fieldKeyword = TextEditingController();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 2;

  @override
  void initState() {
    getBidangList();

    //checkSession();

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset + 10;
        });

        informasiLayanan(limit, offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void checkSession() async {
    informasiLayanan(limit, offset);
  }

  Future<void> informasiLayanan(limit, offset) async {
    // setState(() {
    //   isProcess = false;
    // });

    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.informasiLayanan;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = (content['data']);
            
            // List<String> bidangs = [];
            // content.forEach((person) {
            //   bidangs.add(person.bidang_name);
            // });
            // for (var person in listData) {
            //   bidangs.add(person.name);
            // }
            // listFilterDataBidang.where((content) => content['bidang_id']).toList();
            // print(listFilterDataBidang);
            // listFilterDataBidang = (content['data']);
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
    }

    setState(() {
      isProcess = false;
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      informasiLayanan(limit, offset);
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

    informasiLayanan(limit, offset);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrPrimary,
        scrolledUnderElevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "List Seluruh Aset",
              style: TextStyle(color: Colors.white),
            ),
          ],
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
      // floatingActionButton: FilterBidangPage(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            clipBehavior: Clip.antiAliasWithSaveLayer,
            builder: (
              BuildContext context,
            ) {
              return BottomSheet(
                enableDrag: false,
                onClosing: () {},
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) => SafeArea(
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
                                Form(
                                  key: _formKey,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Column(
                                    children: [
                                      DropdownButtonFormField<String>(
                                        borderRadius: BorderRadius.circular(10),
                                        focusNode: _focusNodes[0],
                                        decoration: const InputDecoration(
                                          hoverColor: clrPrimary,
                                          labelText: 'Pilih Bidang',
                                          hintText: 'Pilih Nama Bidang',
                                          focusColor: clrPrimary,
                                          labelStyle:
                                              TextStyle(color: Colors.grey),
                                          focusedBorder: UnderlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          enabledBorder: UnderlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white24,
                                          border: InputBorder.none,
                                        ),
                                        items: listDataBidang.map(
                                          (item) {
                                            return DropdownMenuItem<String>(
                                              value:
                                                  item['bidang_id'].toString(),
                                              child: Text(item['bidang_name']
                                                  .toString()),
                                            );
                                          },
                                        ).toList(),
                                        onChanged: (newValue) async {
                                          int indexBidang = 0;
                                          for (int ix = 0;
                                              ix < arrBidangId.length;
                                              ix++) {
                                            if (arrBidangId[ix].toString() ==
                                                newValue) {
                                              indexBidang = ix;
                                            }
                                          }
                                          print(indexBidang);

                                          // listDataBidang.forEach((element) {

                                          //  });

                                          setState(
                                            () {
                                              dropdownValue = newValue!;
                                              dropdownName =
                                                  listDataBidang[indexBidang]
                                                          ['bidang_name']
                                                      .toString();
                                            },
                                          );

                                          print(dropdownName.toString());
                                        },
                                        autovalidateMode:
                                            AutovalidateMode.onUserInteraction,
                                        validator: (value) {
                                          if (value == null) {
                                            return 'Pilih Bidang Terlebih Dahulu!';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: CustomButtonPrimary(
                                          text: 'Cari Aset',
                                          onTap: () async {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MonitoringPage(
                                                    idBidang: dropdownValue,
                                                    namaBidang: dropdownName,
                                                  ),
                                                ),
                                              );
                                              print('Form is valid.');
                                            } else {
                                              // Form is invalid, display an error message.
                                              print('Form is invalid.');
                                            }
                                          },
                                        ),
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
        backgroundColor: clrBadge,
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }

  //  List outputList = listFilterDataBidang.where((o) => o['category_id'] == '1').toList();

  Widget listAset() {
    if (listData.isNotEmpty) {
      // if(listData.where((o) => o['category_id'] == '1').toList()){}
      return Padding(
        padding: const EdgeInsets.only(left: 11, top: 11),
        child: GridView.builder(
          itemCount: listData.isEmpty ? 0 : listData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 2.0, mainAxisSpacing: 12.0),
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
                                              Text(
                                                row['bidang_name'] ?? "",
                                                maxLines: 5,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                row['gedung_name'] +
                                                    " - " +
                                                    row['ruangan_name'],
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w400,
                                                    color: Colors.grey),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                child: CachedNetworkImage(
                                                  imageUrl: row['path'] ?? "",
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
                                                    row['kategori_barang'] ??
                                                        "",
                                                    maxLines: 2,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        color: Colors.grey),
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  Text(
                                                    row['nama_aset'] ?? "",
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
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          badges.Badge(
                                                            badgeStyle: badges
                                                                .BadgeStyle(
                                                              shape: badges
                                                                  .BadgeShape
                                                                  .square,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              badgeColor: row['kondisi']
                                                                          .toString() ==
                                                                      "1"
                                                                  ? clrBadge
                                                                  : row['kondisi']
                                                                              .toString() ==
                                                                          "2"
                                                                      ? clrEdit
                                                                      : clrDelete,
                                                            ),
                                                            position: badges
                                                                    .BadgePosition
                                                                .custom(
                                                                    start: 10,
                                                                    top: 10),
                                                            badgeContent: Text(
                                                              row['kondisi']
                                                                          .toString() ==
                                                                      "1"
                                                                  ? "Baik"
                                                                  : row['kondisi']
                                                                              .toString() ==
                                                                          "2"
                                                                      ? "Rusak Ringan"
                                                                      : "Rusak Berat",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          badges.Badge(
                                                            badgeStyle: badges
                                                                .BadgeStyle(
                                                              shape: badges
                                                                  .BadgeShape
                                                                  .square,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              badgeColor:
                                                                  row['status_aset']
                                                                              .toString() ==
                                                                          "1"
                                                                      ? clrBadge
                                                                      : clrDelete,
                                                            ),
                                                            position: badges
                                                                    .BadgePosition
                                                                .custom(
                                                                    start: 10,
                                                                    top: 10),
                                                            badgeContent: Text(
                                                              row['status_aset']
                                                                          .toString() ==
                                                                      "1"
                                                                  ? "Aktif"
                                                                  : "Tidak Aktif",
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
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
                                                        const Icon(Icons.radar),
                                                    title: const Text(
                                                      "Penanggung Jawab",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      row['pj'] ?? "",
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          height: 1.5,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                  ),
                                                  ListTile(
                                                    leading: const Icon(Icons
                                                        .confirmation_number),
                                                    title: const Text(
                                                      "Jumlah Barang",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          height: 1.8),
                                                    ),
                                                    subtitle: Text(
                                                      "${row['jumlah']} ${row['satuan']} ",
                                                      // "15 Buah",
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
              child: FillImageAsetCard(
                  width: MediaQuery.of(context).size.width * 0.45,
                  heightImage: MediaQuery.of(context).size.height * 0.13,
                  imageProvider: NetworkImage(row['path'] ?? ""),
                  title: row['bidang_name'] ?? "",
                  subtitle: row['nama_aset'].toString(),
                  condition: row['kondisi'] == 1
                      ? "Baik"
                      : row['kondisi'] == 2
                          ? "Rusak Ringan"
                          : "Rusak Berat",
                  user: "Kim Yong Ji",
                  count: row['jumlah'].toString(),
                  satuan: row['satuan'] ?? "",
                  category: row['kategori_barang'] ?? "",
                  description: "Kapasitas Maksimal 10 Orang"),
            );
          },
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
                  "Ooops, Belum Ada Aset Yang Masuk Nih!",
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
