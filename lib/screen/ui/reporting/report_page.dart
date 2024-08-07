import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/preference.dart';
import '../main_home.dart';
import 'report_add.dart';
import 'report_download.dart';
import 'report_edit.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  List listData = [];
  List listDataUser = [];

  String username = "";
  String email = "";
  String phone = "";
  String location = "";
  String fullName = "";
  String typeUser= "";
  String id = "";
  String path = "";

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 10;

  Future<void> getData() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.pelaporanData;
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
          } else {
            // listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Peringatan', "Tidak Ada Data Yang Dilaporkan");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
      // toastShort(context, e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  Future<void> getDataUser(id) async {
    var userId = await sharedPref.getPref("id");
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.pelaporanDataUser;
      var uri = "$url/$userId";
      print(uri);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      // print("coba"+content.toString());

      if (content['status'] == true) {
        setState(() {
          if (listDataUser.isEmpty) {
            listDataUser = (content['data']);
          } else {
            // listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Peringatan', "Tidak Ada Data Yang Dilaporkan");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
      // toastShort(context, e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  void checkSession() async {
    var userId = await sharedPref.getPref("id");
    var userFullname = await sharedPref.getPref("name");
    var userRole = await sharedPref.getPref("level");
    var userPath = await sharedPref.getPref("path");

    setState(() {
      fullName = userFullname;
      typeUser = userRole;
      id = userId;
      path = userPath;
    });

    getData();
    getDataUser(id);

  }

  @override
  void initState() {
    checkSession();
    super.initState();
  }

  Future<void> reloadData() async {
    setState(() {
      isProcess = true;
      listData.clear();
      listDataUser.clear();
      getData();
      getDataUser(id);
    });
  }

  String formatDate(String dateTimeString) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'");
    DateFormat outputFormat = DateFormat("dd-MM-yyyy");
    DateTime dateTime = inputFormat.parse(dateTimeString);
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  }

  Future<void> deleteData(id) async {
    try {
      setState(() {
        isProcess = true;
      });
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.pelaporanDataDelete;
      var uri = "$url/$id";
      var bearerToken = 'Bearer $accessToken';
      var response = await http.delete(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      if (response.statusCode == 200) {
        reloadData();
        // ignore: use_build_context_synchronously
        _onAlertButtonPressed(context, true, "Data Berhasil Dihapus");
      } else {
        // ignore: use_build_context_synchronously
        _onAlertButtonPressed(context, false, "Data Belum Berhail Dihapus");
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      _onAlertButtonPressed(context, false, "Data Belum Berhail Dihapus");
    }
    setState(() {
      isProcess = false;
    });
  }

  Future editData(Map row) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ReportEditPage(
          id: row["pelaporan_id"] ?? "",
        ),
      ),
    );
  }

  _onAlertButtonPressed(context, status, message) {
    Alert(
      context: context,
      type: !status ? AlertType.error : AlertType.success,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          color: clrBadge,
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  dialogConfirm(BuildContext context, type, id, row) {
    Widget cancelButton = DialogButton(
      color: clrDelete,
      child: const Padding(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: Text(
          "Tidak",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(false);
      },
    );

    Widget continueButton = DialogButton(
      padding: const EdgeInsets.only(right: 10, left: 10),
      color: clrEdit,
      child: const Padding(
        padding: EdgeInsets.all(10),
        child: Text(
          "Ya",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop(false);
        type == 1 ? editData(row) : deleteData(id);
      },
    );

    AlertDialog alert = AlertDialog(
      surfaceTintColor: Colors.white,
      backgroundColor: Colors.white,
      title: const Column(
        children: [
          Text(
            "Konfirmasi",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: clrPrimary,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      content: type == 1
          ? const Text("Apakah anda yakin akan mengubah data ini ?")
          : const Text("Apakah anda yakin akan menghapus data ini"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            cancelButton,
            continueButton,
          ],
        ),
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _pullRefresh() async {
    setState(() {
      listData.clear();
      getData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrPrimary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MainHome(
                    id: '',
                  ),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        title: const Text(
          "Pelaporan Data",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
        actions: <Widget>[
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: Colors.white,
                barrierColor: Colors.white,
                context: context,
                builder: (BuildContext context) {
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
                                Padding(
                                  padding: const EdgeInsets.only(top: 10.0),
                                  child: TextField(
                                    maxLines: 1,
                                    decoration: InputDecoration(
                                      labelText: 'Kata Kunci',
                                      hintText: 'Masukkan kata kunci ...',
                                      focusColor: clrPrimary,
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                GestureDetector(
                                  onTap: () async {},
                                  child: Container(
                                    width: MediaQuery.of(context).size.width,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: BoxDecoration(
                                      color: clrPrimary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Search",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.w600,
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
            child: const Padding(
              padding: EdgeInsets.only(right: 15),
            ),
          ),
        ],
      ),
      body:  RefreshIndicator(
          color: clrPrimary,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 1500));
            setState(() {
              isProcess = true;
              listData.clear();
              _pullRefresh();
            });
          },
          child: SingleChildScrollView(
            controller: _scrollController,
            // ignore: unrelated_type_equality_checks
            child: typeUser == "1" ?
            reportingList(): reportingListUser() ,
          ),
        ),
      
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const ReportAddpage(),
              ),
              (Route<dynamic> route) => false);
        },
        backgroundColor: clrBadge,
        child: const Icon(
          Icons.note_add,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget reportingList() {
    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = listData[index] as Map;

            return GestureDetector(
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
                                      const Text(
                                        "Detail",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                      ListTile(
                                        title: Row(
                                          children: [
                                            const Text(
                                              "Pemohon: ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.8,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              row['created_by_pelaporan'] ?? "",
                                              style: const TextStyle(
                                                  color: clrPrimary,
                                                  fontSize: 16,
                                                  height: 1.8,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Tanggal Kegiatan: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      height: 1.8,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  row['tgl_kegiatan'] ?? "",
                                                  style: const TextStyle(
                                                      color: clrPrimary,
                                                      fontSize: 16,
                                                      height: 1.8,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Waktu Input: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      height: 1.8,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(row['waktu'] ?? "",
                                                  style: const TextStyle(
                                                      color: clrPrimary,
                                                      fontSize: 16,
                                                      height: 1.8,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Text(
                                              "Deskripsi: ",
                                              maxLines: 10,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              row['deskripsi'] ?? "",
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Text(
                                              "MOM: ",
                                              maxLines: 10,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              row['mom'] ?? "",
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
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
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 3.5, right: 5, left: 5, bottom: 3.5),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: clrShadow,
                            blurRadius: 1.0,
                            spreadRadius: 0.5,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 17, right: 17),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Pemohon: ",
                                          style: TextStyle(
                                              color: clrPrimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          row['created_by_pelaporan'] ?? "",
                                          style: const TextStyle(
                                              color: clrPrimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    PopupMenuButton(
                                      surfaceTintColor: Colors.white,
                                      color: Colors.white,
                                      offset: const Offset(
                                          -20, 35), // SET THE (X,Y) POSITION
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.grey,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onSelected: (value) {
                                        if (value == 'ubah') {
                                          //open edit page
                                          dialogConfirm(
                                              context,
                                              1,
                                              row['pelaporan_id'].toString(),
                                              row);

                                          // editData(row);
                                        } else if (value == "hapus") {
                                          //delete data
                                          dialogConfirm(
                                              context,
                                              2,
                                              row['pelaporan_id'].toString(),
                                              row);
                                        } else {
                                          // donlod pdf
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DownloadPage(
                                                name: row["nama_kegiatan"] + ".pdf",
                                                path:
                                                    "https://casys.kejaksaan.go.id/pelaporan-kegiatan/unduh-pdf/${row['pelaporan_id']}",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          const PopupMenuItem(
                                            value: 'ubah',
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit),
                                                Text(' Ubah'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'hapus',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete),
                                                Text(' Hapus'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'pdf',
                                            child: Row(
                                              children: [
                                                Icon(Icons.picture_as_pdf),
                                                Text(' PDF'),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  row['nama_kegiatan'] ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Tanggal kegiatan",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      row['tgl_kegiatan'] ?? "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: clrPrimary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Waktu Input",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      row['waktu'] ?? "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: clrPrimary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                  "Ooops, Belum Ada Data Yang Dilaporkan Nih!",
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

  Widget reportingListUser() {
    if (listDataUser.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = listDataUser[index] as Map;

            return GestureDetector(
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
                                      const Text(
                                        "Detail",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                      ListTile(
                                        title: Row(
                                          children: [
                                            const Text(
                                              "Pemohon: ",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  height: 1.8,
                                                  fontWeight: FontWeight.w400),
                                            ),
                                            Text(
                                              row['created_by_pelaporan'] ?? "",
                                              style: const TextStyle(
                                                  color: clrPrimary,
                                                  fontSize: 16,
                                                  height: 1.8,
                                                  fontWeight: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                        subtitle: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                const Text(
                                                  "Tanggal Kegiatan: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      height: 1.8,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(
                                                  row['tgl_kegiatan'] ?? "",
                                                  style: const TextStyle(
                                                      color: clrPrimary,
                                                      fontSize: 16,
                                                      height: 1.8,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Waktu Input: ",
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 16,
                                                      height: 1.8,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                                Text(row['waktu'] ?? "",
                                                  style: const TextStyle(
                                                      color: clrPrimary,
                                                      fontSize: 16,
                                                      height: 1.8,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8,
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Text(
                                              "Deskripsi: ",
                                              maxLines: 10,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              row['deskripsi'] ?? "",
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const SizedBox(
                                              height: 15,
                                            ),
                                            const Text(
                                              "MOM: ",
                                              maxLines: 10,
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  height: 1.5,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            Text(
                                              row['mom'] ?? "",
                                              maxLines: 5,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  height: 1.5,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500),
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
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 3.5, right: 5, left: 5, bottom: 3.5),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: clrShadow,
                            blurRadius: 1.0,
                            spreadRadius: 0.5,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 17, right: 17),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Pemohon: ",
                                          style: TextStyle(
                                              color: clrPrimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          row['created_by_pelaporan'] ?? "",
                                          style: const TextStyle(
                                              color: clrPrimary,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ],
                                    ),
                                    PopupMenuButton(
                                      surfaceTintColor: Colors.white,
                                      color: Colors.white,
                                      offset: const Offset(
                                          -20, 35), // SET THE (X,Y) POSITION
                                      icon: const Icon(
                                        Icons.more_vert,
                                        color: Colors.grey,
                                      ),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      onSelected: (value) {
                                        if (value == 'ubah') {
                                          //open edit page
                                          dialogConfirm(
                                              context,
                                              1,
                                              row['pelaporan_id'].toString(),
                                              row);

                                          // editData(row);
                                        } else if (value == "hapus") {
                                          //delete data
                                          dialogConfirm(
                                              context,
                                              2,
                                              row['pelaporan_id'].toString(),
                                              row);
                                        } else {
                                          // donlod pdf
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  DownloadPage(
                                                name: row["nama_kegiatan"] + ".pdf",
                                                path:
                                                    "https://casys.kejaksaan.go.id/pelaporan-kegiatan/unduh-pdf/${row['pelaporan_id']}",
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                      itemBuilder: (context) {
                                        return [
                                          const PopupMenuItem(
                                            value: 'ubah',
                                            child: Row(
                                              children: [
                                                Icon(Icons.edit),
                                                Text(' Ubah'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'hapus',
                                            child: Row(
                                              children: [
                                                Icon(Icons.delete),
                                                Text(' Hapus'),
                                              ],
                                            ),
                                          ),
                                          const PopupMenuItem(
                                            value: 'pdf',
                                            child: Row(
                                              children: [
                                                Icon(Icons.picture_as_pdf),
                                                Text(' PDF'),
                                              ],
                                            ),
                                          ),
                                        ];
                                      },
                                    ),
                                  ],
                                ),
                                Text(
                                  row['nama_kegiatan'] ?? "",
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Tanggal kegiatan",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      row['tgl_kegiatan'] ?? "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: clrPrimary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "Waktu Input",
                                      style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    const SizedBox(
                                      height: 3,
                                    ),
                                    Text(
                                      row['waktu'] ?? "",
                                      style: const TextStyle(
                                          fontSize: 14,
                                          color: clrPrimary,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: listDataUser.isEmpty ? 0 : listDataUser.length,
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
                  "Ooops, Belum Ada Data Yang Dilaporkan Nih!",
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
