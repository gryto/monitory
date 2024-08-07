import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/loader.dart';
import '../../../../../../src/preference.dart';
import '../../../../../../src/toast.dart';
import '../../../../../widget/room_widget.dart';
import '../../../constants/api.dart';
import 'package:badges/badges.dart' as badges;

class DetailRumahDinasPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailRumahDinasPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailRumahDinasPage> createState() => _DetailRumahDinasPageState();
}

class _DetailRumahDinasPageState extends State<DetailRumahDinasPage> {
  late Widget body;
  String title = "JDIH";
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

  num totalSuratMasuk = 0;
  List listSuratMasuk = [];
  num lineMasuk0 = 0;
  num lineMasuk1 = 0;
  num lineMasuk2 = 0;
  num lineMasuk3 = 0;
  num lineMasuk4 = 0;
  num lineMasuk5 = 0;
  num lineMasuk6 = 0;
  num lineMasuk7 = 0;
  num lineMasuk8 = 0;
  num lineMasuk9 = 0;
  num lineMasuk10 = 0;
  num lineMasuk11 = 0;

  num totalSuratKeluar = 0;
  List listSuratKeluar = [];
  num lineKeluar0 = 0;
  num lineKeluar1 = 0;
  num lineKeluar2 = 0;
  num lineKeluar3 = 0;
  num lineKeluar4 = 0;
  num lineKeluar5 = 0;
  num lineKeluar6 = 0;
  num lineKeluar7 = 0;
  num lineKeluar8 = 0;
  num lineKeluar9 = 0;
  num lineKeluar10 = 0;
  num lineKeluar11 = 0;

  num totalEsignKeluar = 0;
  List listEsignKeluar = [];
  num lineEsignKeluar0 = 0;
  num lineEsignKeluar1 = 0;
  num lineEsignKeluar2 = 0;
  num lineEsignKeluar3 = 0;
  num lineEsignKeluar4 = 0;
  num lineEsignKeluar5 = 0;
  num lineEsignKeluar6 = 0;
  num lineEsignKeluar7 = 0;
  num lineEsignKeluar8 = 0;
  num lineEsignKeluar9 = 0;
  num lineEsignKeluar10 = 0;
  num lineEsignKeluar11 = 0;

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
        "satker": "kejaksaan-agung-republik-indonesia",
        "tahun": tahun.toString()
      });
      var response = await http.post(Uri.parse(ApiService.countPersuratan),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          totalSuratMasuk = content['data']['surat_masuk'];
          listSuratMasuk = content['data']['surat_masuk_kategori'];
          lineMasuk0 = listSuratMasuk[0]['total'];
          lineMasuk1 = listSuratMasuk[1]['total'];
          lineMasuk2 = listSuratMasuk[2]['total'];
          lineMasuk3 = listSuratMasuk[3]['total'];
          lineMasuk4 = listSuratMasuk[4]['total'];
          lineMasuk5 = listSuratMasuk[5]['total'];
          lineMasuk6 = listSuratMasuk[6]['total'];
          lineMasuk7 = listSuratMasuk[7]['total'];
          lineMasuk8 = listSuratMasuk[8]['total'];
          lineMasuk9 = listSuratMasuk[9]['total'];
          lineMasuk10 = listSuratMasuk[10]['total'];
          lineMasuk11 = listSuratMasuk[11]['total'];

          totalSuratKeluar = content['data']['surat_keluar'];
          listSuratKeluar = content['data']['surat_keluar_kategori'];
          lineKeluar0 = listSuratKeluar[0]['total'];
          lineKeluar1 = listSuratKeluar[1]['total'];
          lineKeluar2 = listSuratKeluar[2]['total'];
          lineKeluar3 = listSuratKeluar[3]['total'];
          lineKeluar4 = listSuratKeluar[4]['total'];
          lineKeluar5 = listSuratKeluar[5]['total'];
          lineKeluar6 = listSuratKeluar[6]['total'];
          lineKeluar7 = listSuratKeluar[7]['total'];
          lineKeluar8 = listSuratKeluar[8]['total'];
          lineKeluar9 = listSuratKeluar[9]['total'];
          lineKeluar10 = listSuratKeluar[10]['total'];
          lineKeluar11 = listSuratKeluar[11]['total'];

          totalEsignKeluar = content['data']['surat_esign_keluar'];
          listEsignKeluar = content['data']['surat_esign_keluar_kategori'];
          lineEsignKeluar0 = listEsignKeluar[0]['total'];
          lineEsignKeluar1 = listEsignKeluar[1]['total'];
          lineEsignKeluar2 = listEsignKeluar[2]['total'];
          lineEsignKeluar3 = listEsignKeluar[3]['total'];
          lineEsignKeluar4 = listEsignKeluar[4]['total'];
          lineEsignKeluar5 = listEsignKeluar[5]['total'];
          lineEsignKeluar6 = listEsignKeluar[6]['total'];
          lineEsignKeluar7 = listEsignKeluar[7]['total'];
          lineEsignKeluar8 = listEsignKeluar[8]['total'];
          lineEsignKeluar9 = listEsignKeluar[9]['total'];
          lineEsignKeluar10 = listEsignKeluar[10]['total'];
          lineEsignKeluar11 = listEsignKeluar[11]['total'];
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context, "Err detail data jampidum"); //e.toString());
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rumah Dinas",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "BIRO UMUM - JAMBIN",
                      style: TextStyle(color: clrEdit, fontSize: 12),
                    ),
                  ],
                ),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Periode Tahun ${yearStart.text}",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            RoomContainer(
                                onTap: () {},
                                title: "Total Ruang",
                                colorIcon: clrWait,
                                count: "96"),
                            RoomContainer(
                                onTap: () {},
                                title: "Sudah Ditempati",
                                colorIcon: clrBadge,
                                count: "75"),
                            RoomContainer(
                                onTap: () {},
                                title: "Belum Ditempati",
                                colorIcon: clrDelete,
                                count: "21"),
                            RoomContainer(
                                onTap: () {},
                                title: "Total Gedung",
                                colorIcon: clrDelete,
                                count: "2"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                  child: !isProcess
                      ? _buildListInspektorat()
                      : loaderDialog(context)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListInspektorat() {
    return Padding(
      padding: const EdgeInsets.all(2),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 30, 52, 77)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Ruangan Yang Digunakan",
                      style: TextStyle(color: clrEdit),
                    ),
                  ),
                  const Divider(
                      height: 10, color: Color.fromARGB(255, 30, 52, 77)),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 30, 52, 77)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.only(left: 5.0, right: 5.0),
                          leading: const Icon(
                            Icons.home,
                            color: clrWait,
                          ),
                          title: const Text(
                            "A.1.2",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                  shape: badges.BadgeShape.square,
                                  borderRadius: BorderRadius.circular(5),
                                  badgeColor: clrDelete,
                                ),
                                position: badges.BadgePosition.custom(
                                    start: 10, top: 10),
                                badgeContent: const Text(
                                  "Kosong",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: clrWait),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Tempati Ruangan",
                              style: TextStyle(color: clrWait),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 30, 52, 77)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.only(left: 5.0, right: 5.0),
                          leading: const Icon(
                            Icons.home,
                            color: clrWait,
                          ),
                          title: const Text(
                            "A.1.2",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                  shape: badges.BadgeShape.square,
                                  borderRadius: BorderRadius.circular(5),
                                  badgeColor: clrDelete,
                                ),
                                position: badges.BadgePosition.custom(
                                    start: 10, top: 10),
                                badgeContent: const Text(
                                  "Kosong",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: clrWait),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Tempati Ruangan",
                              style: TextStyle(color: clrWait),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 30, 52, 77)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.only(left: 5.0, right: 5.0),
                          leading: const Icon(
                            Icons.home,
                            color: clrWait,
                          ),
                          title: const Text(
                            "A.1.2",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                  shape: badges.BadgeShape.square,
                                  borderRadius: BorderRadius.circular(5),
                                  badgeColor: clrDelete,
                                ),
                                position: badges.BadgePosition.custom(
                                    start: 10, top: 10),
                                badgeContent: const Text(
                                  "Kosong",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: clrWait),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Tempati Ruangan",
                              style: TextStyle(color: clrWait),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 30, 52, 77)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          dense: true,
                          contentPadding:
                              const EdgeInsets.only(left: 5.0, right: 5.0),
                          leading: const Icon(
                            Icons.home,
                            color: clrWait,
                          ),
                          title: const Text(
                            "A.1.2",
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 3,
                              ),
                              badges.Badge(
                                badgeStyle: badges.BadgeStyle(
                                  shape: badges.BadgeShape.square,
                                  borderRadius: BorderRadius.circular(5),
                                  badgeColor: clrDelete,
                                ),
                                position: badges.BadgePosition.custom(
                                    start: 10, top: 10),
                                badgeContent: const Text(
                                  "Kosong",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          trailing: Container(
                            margin: const EdgeInsets.all(5.0),
                            padding: const EdgeInsets.all(5.0),
                            decoration: BoxDecoration(
                              border: Border.all(color: clrWait),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: const Text(
                              "Tempati Ruangan",
                              style: TextStyle(color: clrWait),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 30, 52, 77)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "Aset Rumah Dinas",
                      style: TextStyle(color: clrEdit),
                    ),
                  ),
                  const Divider(
                      height: 10, color: Color.fromARGB(255, 30, 52, 77)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearPercentIndicator(
                      // width: 180.0,
                      lineHeight: 14.0,
                      percent: 0.8,
                      center: const Text(
                        "80.0%",
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      // ignore: deprecated_member_use
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor: const Color.fromARGB(255, 30, 52, 77),
                      progressColor: Colors.blue,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearPercentIndicator(
                      // width: 180.0,
                      lineHeight: 14.0,
                      percent: 0.9,
                      center: const Text(
                        "90.0%",
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      // ignore: deprecated_member_use
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor: const Color.fromARGB(255, 30, 52, 77),
                      progressColor: clrPrimary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearPercentIndicator(
                      // width: 180.0,
                      lineHeight: 14.0,
                      percent: 0.3,
                      center: const Text(
                        "3.0%",
                        style: TextStyle(fontSize: 12.0, color: Colors.white),
                      ),
                      // ignore: deprecated_member_use
                      linearStrokeCap: LinearStrokeCap.roundAll,
                      backgroundColor: const Color.fromARGB(255, 30, 52, 77),
                      progressColor: clrDelete,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
              padding: EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  "Total: 10",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error, color: Colors.white,),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: Efendi, S.H.,M.H.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.4.2",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: YEKTI LINGGA DINATA, S.Si.	",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.1.5",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: Efendi, S.H.,M.H.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.4.2",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: YEKTI LINGGA DINATA, S.Si.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.1.5",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: Efendi, S.H.,M.H.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.4.2",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: YEKTI LINGGA DINATA, S.Si.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.1.5",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: Efendi, S.H.,M.H.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.4.2",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: YEKTI LINGGA DINATA, S.Si.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.1.5",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: Efendi, S.H.,M.H.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.4.2",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xff3cd2a5)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      width: 50,
                      height: 50,
                      // ignore: prefer_interpolation_to_compose_strings
                      imageUrl:
                          "https://casys.kejaksaan.go.id/storage/user/default.jpg",
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  const ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Nama Penghuni: YEKTI LINGGA DINATA, S.Si.",
                      maxLines: 10,
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Ruangan : B.1.5",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "NIP : 197304151998031002",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          "Waktu Menempati : 2023-07-27",
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.more_vert),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
