import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loader.dart';
import '../../../src/preference.dart';
import '../../widget/custom_button.dart';
import 'package:badges/badges.dart' as badges;
import '../monitoring/component/history.dart';
import 'cancelled.dart';
import 'finished.dart';
import 'onGoing.dart';
import 'unapproved.dart';
import 'waiting.dart';

class DashboardActivityPage extends StatefulWidget {
  const DashboardActivityPage({
    super.key,
  });

  @override
  State<DashboardActivityPage> createState() => _DashboardActivityPageState();
}

class _DashboardActivityPageState extends State<DashboardActivityPage>
    with SingleTickerProviderStateMixin {
  //create controller untuk tabBar
  late TabController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 5);
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  List listDataBidang = [];
  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 2;
  var id = '';

  void checkSession() async {}

  Future<void> informasiLayananBidang(id) async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.informasiLayananBidang;
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

  Future<void> _pullRefresh() async {
    setState(() {
      listData.clear();
      // informasiLayananBidang(widget.idBidang);
      // searchData(selectedMonthIndex, selectedYear);
      // getDataMonitoring(month, year);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isProcess ? bidangTabBar() : loaderDialog(context),
    );
  }

  Widget bidangTabBar() {
    return Column(
      children: [
        TabBar(
          isScrollable: true,
          labelColor: clrPrimary,
          indicatorColor: clrBadge,
          unselectedLabelColor: clrSubtitle,
          tabs: const <Tab>[
            Tab(text: 'Sedang Berlangsung'),
            Tab(text: 'Belum Berlangsung'),
            Tab(text: 'Selesai'),
            Tab(text: 'Batal'),
            Tab(text: 'Belum Disetujui'),
          ],
          controller: controller,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
              controller.animateTo(index);
            });
          },
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              RefreshIndicator(
                color: clrPrimary,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  setState(() {
                    isProcess = true;
                    listData.clear();
                    _pullRefresh();
                  });
                },
                child: const OnGoingPage(),
              ),
              RefreshIndicator(
                color: clrPrimary,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  setState(() {
                    isProcess = true;
                    listData.clear();
                    _pullRefresh();
                  });
                },
                child: const WaitingPage(),
              ),
              RefreshIndicator(
                color: clrPrimary,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  setState(() {
                    isProcess = true;
                    listData.clear();
                    _pullRefresh();
                  });
                },
                child: const FinishedPage(),
              ),
              RefreshIndicator(
                color: clrPrimary,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  setState(() {
                    isProcess = true;
                    listData.clear();
                    _pullRefresh();
                  });
                },
                child: const CancelledPage(),
              ),
              RefreshIndicator(
                color: clrPrimary,
                onRefresh: () async {
                  await Future.delayed(const Duration(milliseconds: 1500));
                  setState(() {
                    isProcess = true;
                    listData.clear();
                    _pullRefresh();
                  });
                },
                child: const UnapprovedPage(),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget listEntryBidang() {
    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: ListView.separated(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = listData[index];
            return Visibility(
              visible: row['flag'] == 1 ? true : false,
              maintainSize: false,
              child: Column(
                children: [
                  GestureDetector(
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
                                                    const EdgeInsetsDirectional
                                                        .all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      row['bidang_name'] ?? "",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            row['path'] ?? "",
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          row['kategori_barang'] ??
                                                              "",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          row['nama_aset'] ??
                                                              "",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color:
                                                                  clrPrimary),
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
                                                                            .circular(5),
                                                                    badgeColor: row['flag'].toString() ==
                                                                            "1"
                                                                        ? clrBadge
                                                                        : row['flag'].toString() ==
                                                                                "2"
                                                                            ? clrDelete
                                                                            : clrDelete,
                                                                  ),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .custom(
                                                                          start:
                                                                              10,
                                                                          top:
                                                                              10),
                                                                  badgeContent:
                                                                      Text(
                                                                    row['flag'].toString() ==
                                                                            "1"
                                                                        ? "Aset Masuk"
                                                                        : row['flag'].toString() ==
                                                                                "2"
                                                                            ? "Aset Keluar"
                                                                            : "Aset Keluar",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                                            .circular(5),
                                                                    badgeColor: row['kondisi'].toString() ==
                                                                            "1"
                                                                        ? clrBadge
                                                                        : row['kondisi'].toString() ==
                                                                                "2"
                                                                            ? clrEdit
                                                                            : clrDelete,
                                                                  ),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .custom(
                                                                          start:
                                                                              10,
                                                                          top:
                                                                              10),
                                                                  badgeContent:
                                                                      Text(
                                                                    row['kondisi'].toString() ==
                                                                            "1"
                                                                        ? "Baik"
                                                                        : row['kondisi'].toString() ==
                                                                                "2"
                                                                            ? "Rusak Ringan"
                                                                            : "Rusak Berat",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                                            .circular(5),
                                                                    badgeColor: row['status_aset'].toString() ==
                                                                            "1"
                                                                        ? clrBadge
                                                                        : clrDelete,
                                                                  ),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .custom(
                                                                          start:
                                                                              10,
                                                                          top:
                                                                              10),
                                                                  badgeContent:
                                                                      Text(
                                                                    row['status_aset'].toString() ==
                                                                            "1"
                                                                        ? "Aktif"
                                                                        : "Tidak Aktif",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                          leading: const Icon(Icons
                                                              .account_circle),
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
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
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
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons.date_range),
                                                          title: const Text(
                                                            "Tanggal Perolehan",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                height: 1.8),
                                                          ),
                                                          subtitle: Text(
                                                            formatDate(
                                                                row['tgl_perolehan'] ??
                                                                    ""),
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons.timelapse),
                                                          title: const Text(
                                                            "Masa Manfaat",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                height: 1.8),
                                                          ),
                                                          subtitle: Text(
                                                            "${row['masa']} Tahun",
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons
                                                                  .text_fields),
                                                          title: const Text(
                                                            "Keterangan Aset Masuk",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                height: 1.8),
                                                          ),
                                                          subtitle: Text(
                                                            row['keterangan'] ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black,
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
                    child: ListTile(
                      leading: Stack(
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(row['path'] ?? ""),
                              ),
                            ),
                          ),
                          badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                              shape: badges.BadgeShape.square,
                              borderRadius: BorderRadius.circular(5),
                              badgeColor: row['kondisi'] == 1
                                  ? clrBadge
                                  : row['kondisi'] == 1
                                      ? clrEdit
                                      : clrDelete,
                            ),
                            position:
                                badges.BadgePosition.custom(start: 10, top: 10),
                            badgeContent: Text(
                              row['kondisi'] == 1
                                  ? 'Baik'
                                  : row['status'] == 2
                                      ? 'Rusak Ringan'
                                      : 'Rusak Berat',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        row['nama_aset'] ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            height: 1.8,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            row['kategori_barang'] ?? "",
                            style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "${row['jumlah']} " "${row['satuan']} ",
                            style: const TextStyle(fontSize: 12, height: 1.5),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
          itemCount: listData.isEmpty ? 0 : listData.length,
          separatorBuilder: (_, index) => const SizedBox(
            height: 5,
          ),
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

  Widget listExitBidang() {
    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 8, top: 8),
        child: ListView.separated(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = listData[index];
            return Visibility(
              visible: row['flag'] == 2 ? true : false,
              maintainSize: false,
              child: Column(
                children: [
                  GestureDetector(
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
                                  initialChildSize: 0.9,
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
                                                    const EdgeInsetsDirectional
                                                        .all(15),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      row['bidang_name'] ?? "",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
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
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          color: Colors.grey),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8),
                                                      child: CachedNetworkImage(
                                                        imageUrl:
                                                            row['path'] ?? "",
                                                        placeholder: (context,
                                                                url) =>
                                                            const CircularProgressIndicator(),
                                                        errorWidget: (context,
                                                                url, error) =>
                                                            const Icon(
                                                                Icons.error),
                                                      ),
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        const SizedBox(
                                                          height: 10,
                                                        ),
                                                        Text(
                                                          row['kategori_barang'] ??
                                                              "",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 14,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .grey),
                                                        ),
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          row['nama_aset'] ??
                                                              "",
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                              color:
                                                                  clrPrimary),
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
                                                                            .circular(5),
                                                                    badgeColor: row['flag'].toString() ==
                                                                            "1"
                                                                        ? clrBadge
                                                                        : row['flag'].toString() ==
                                                                                "2"
                                                                            ? clrDelete
                                                                            : clrDelete,
                                                                  ),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .custom(
                                                                          start:
                                                                              10,
                                                                          top:
                                                                              10),
                                                                  badgeContent:
                                                                      Text(
                                                                    row['flag'].toString() ==
                                                                            "1"
                                                                        ? "Aset Masuk"
                                                                        : row['flag'].toString() ==
                                                                                "2"
                                                                            ? "Aset Keluar"
                                                                            : "Aset Keluar",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                                            .circular(5),
                                                                    badgeColor: row['kondisi'].toString() ==
                                                                            "1"
                                                                        ? clrBadge
                                                                        : row['kondisi'].toString() ==
                                                                                "2"
                                                                            ? clrEdit
                                                                            : clrDelete,
                                                                  ),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .custom(
                                                                          start:
                                                                              10,
                                                                          top:
                                                                              10),
                                                                  badgeContent:
                                                                      Text(
                                                                    row['kondisi'].toString() ==
                                                                            "1"
                                                                        ? "Baik"
                                                                        : row['kondisi'].toString() ==
                                                                                "2"
                                                                            ? "Rusak Ringan"
                                                                            : "Rusak Berat",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                                            .circular(5),
                                                                    badgeColor: row['status_aset'].toString() ==
                                                                            "1"
                                                                        ? clrBadge
                                                                        : clrDelete,
                                                                  ),
                                                                  position: badges
                                                                          .BadgePosition
                                                                      .custom(
                                                                          start:
                                                                              10,
                                                                          top:
                                                                              10),
                                                                  badgeContent:
                                                                      Text(
                                                                    row['status_aset'].toString() ==
                                                                            "1"
                                                                        ? "Aktif"
                                                                        : "Tidak Aktif",
                                                                    style: const TextStyle(
                                                                        color: Colors
                                                                            .white,
                                                                        fontSize:
                                                                            14,
                                                                        fontWeight:
                                                                            FontWeight.bold),
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
                                                          leading: const Icon(Icons
                                                              .account_circle),
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
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
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
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons.date_range),
                                                          title: const Text(
                                                            "Tanggal Perolehan",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                height: 1.8),
                                                          ),
                                                          subtitle: Text(
                                                            formatDate(
                                                                row['tgl_perolehan'] ??
                                                                    ""),
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons.timelapse),
                                                          title: const Text(
                                                            "Masa Manfaat",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                height: 1.8),
                                                          ),
                                                          subtitle: Text(
                                                            "${row['masa']} Tahun",
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons.date_range),
                                                          title: const Text(
                                                            "Tanggal Aset Keluar",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                height: 1.8),
                                                          ),
                                                          subtitle: Text(
                                                            formatDate(
                                                                row['tgl_aset_keluar'] ??
                                                                    ""),
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        ListTile(
                                                          leading: const Icon(
                                                              Icons
                                                                  .text_fields),
                                                          title: const Text(
                                                            "Keterangan Aset Keluar",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                height: 1.8),
                                                          ),
                                                          subtitle: Text(
                                                            row['ket_aset_keluar'] ??
                                                                "",
                                                            style: const TextStyle(
                                                                fontSize: 16,
                                                                height: 1.5,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          height: 25,
                                                        ),
                                                        CustomButton(
                                                          text:
                                                              'Lihat Sejarah Aset',
                                                          onTap: () {
                                                            Navigator.of(
                                                                    context)
                                                                .push(
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    AsetHistoryPage(
                                                                        layananId:
                                                                            row['layanan_id'].toString()),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                        const SizedBox(
                                                          height: 20,
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
                    child: ListTile(
                      leading: Stack(
                        children: [
                          Container(
                            height: 150,
                            width: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(row['path'] ?? ""),
                              ),
                            ),
                          ),
                          badges.Badge(
                            badgeStyle: badges.BadgeStyle(
                              shape: badges.BadgeShape.square,
                              borderRadius: BorderRadius.circular(5),
                              badgeColor: row['kondisi'] == 1
                                  ? clrBadge
                                  : row['kondisi'] == 1
                                      ? clrEdit
                                      : clrDelete,
                            ),
                            position:
                                badges.BadgePosition.custom(start: 10, top: 10),
                            badgeContent: Text(
                              row['kondisi'] == 1
                                  ? 'Baik'
                                  : row['status'] == 2
                                      ? 'Rusak Ringan'
                                      : 'Rusak Berat',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      title: Text(
                        row['nama_aset'] ?? "",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 14,
                            height: 1.8,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            row['kategori_barang'] ?? "",
                            style: const TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            // ignore: prefer_interpolation_to_compose_strings
                            "${row['jumlah']} " + row['satuan'],
                            style: const TextStyle(fontSize: 12, height: 1.5),
                          ),
                        ],
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios_sharp,
                        color: Colors.grey,
                        size: 15,
                      ),
                    ),
                  ),
                  const Divider(),
                ],
              ),
            );
          },
          itemCount: listData.isEmpty ? 0 : listData.length,
          separatorBuilder: (_, index) => const SizedBox(
            height: 5,
          ),
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
                  "Ooops, Belum Ada Aset Yang Keluar Nih!",
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
