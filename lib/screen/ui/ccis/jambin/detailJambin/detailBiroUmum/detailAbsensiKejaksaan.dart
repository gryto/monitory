import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:monitoriy/src/constant.dart';
import '../../../../../../src/dialog_info.dart';
import '../../../../../../src/preference.dart';
import '../../../../../../src/toast.dart';
import '../../../constants/api.dart';
import 'absensi/detailCuti.dart';

class DetailAbsensiPage extends StatefulWidget {
  final String accessToken, tahun;
  const DetailAbsensiPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailAbsensiPage> createState() => _DetailAbsensiPageState();
}

class _DetailAbsensiPageState extends State<DetailAbsensiPage> {
  late Widget body;
  String title = "JAMPIDUM";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  List listData = [];

  List totalAbsensi = [];

  getData() async {
    try {
      var response = await http.get(
        Uri.parse(ApiService.countAbsensiCasys),
        headers: {
          "Content-Type": "application/json",
          "sidac_token": widget.accessToken
        },
      );
      var content = json.decode(response.body);
      print("coba" + content.toString());

      if (content['status'] == 200) {
        setState(() {
          listData = content['data']['absen'];
          print(listData);
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

  getDataSatker() async {
    try {
      var response = await http.get(
        Uri.parse(ApiService.getSatuanKerjaCasys),
        headers: {
          "Content-Type": "application/json",
          "sidac_token": widget.accessToken
        },
      );
      var content = json.decode(response.body);
      print("coba" + content.toString());

      if (content['status'] == 200) {
        setState(() {
          listData = content['data'];
          print(listData);
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
    getData();
  }

  checkSession() async {
    getData();
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
        title: const Row(
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
                  "Absensi Kejaksaan Mobile",
                  style: TextStyle(color: Colors.white, fontSize: 18),
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
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
      ),
      body: !isProcess
          ? listAbsensi()
          : const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3cd2a5)),
              ),
            ),
    );
  }

  Widget listAbsensi() {
    double w = MediaQuery.of(context).size.width - 0;

    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 11, top: 11),
        child: GridView.builder(
          itemCount: listData.isEmpty ? 0 : listData.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 12.0, mainAxisSpacing: 12.0),
          itemBuilder: (_, index) {
            var row = listData[index];

            List<DeviceBoxWidget> locations = [
              DeviceBoxWidget(
                width: w / 6,
                smartDeviceName: row['nama_satatus'] ?? "",
                smartDeviceTotal: row['jumlah'].toString(),
                smartDeviceColor: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 68, 87),
                    Color.fromARGB(255, 13, 30, 46),
                  ],
                ),
              ),
              DeviceBoxWidget(
                width: w / 6,
                smartDeviceName: row['nama_satatus'] ?? "",
                smartDeviceTotal: row['jumlah'].toString(),
                smartDeviceColor: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 68, 87),
                    Color.fromARGB(255, 13, 30, 46),
                  ],
                ),
              ),
              DeviceBoxWidget(
                width: w / 6,
                smartDeviceName: row['nama_satatus'] ?? "",
                smartDeviceTotal: row['jumlah'].toString(),
                smartDeviceColor: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 68, 87),
                    Color.fromARGB(255, 13, 30, 46),
                  ],
                ),
              ),
              DeviceBoxWidget(
                width: w / 6,
                smartDeviceName: row['nama_satatus'] ?? "",
                smartDeviceTotal: row['jumlah'].toString(),
                smartDeviceColor: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 68, 87),
                    Color.fromARGB(255, 13, 30, 46),
                  ],
                ),
              ),
              DeviceBoxWidget(
                width: w / 6,
                smartDeviceName: row['nama_satatus'] ?? "",
                smartDeviceTotal: row['jumlah'].toString(),
                smartDeviceColor: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 68, 87),
                    Color.fromARGB(255, 13, 30, 46),
                  ],
                ),
              ),
              DeviceBoxWidget(
                width: w / 6,
                smartDeviceName: row['nama_satatus'] ?? "",
                smartDeviceTotal: row['jumlah'].toString(),
                smartDeviceColor: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 68, 87),
                    Color.fromARGB(255, 13, 30, 46),
                  ],
                ),
              ),
              DeviceBoxWidget(
                width: w / 6,
                smartDeviceName: row['nama_satatus'] ?? "",
                smartDeviceTotal: row['jumlah'].toString(),
                smartDeviceColor: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 68, 87),
                    Color.fromARGB(255, 13, 30, 46),
                  ],
                ),
              ),
              DeviceBoxWidget(
                width: w / 6,
                smartDeviceName: row['nama_satatus'] ?? "",
                smartDeviceTotal: row['jumlah'].toString(),
                smartDeviceColor: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 34, 68, 87),
                    Color.fromARGB(255, 13, 30, 46),
                  ],
                ),
              ),
            ];

            return GestureDetector(
              onTap: () {
                if (index == 0) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailCutiPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                        id: row['id'] ?? "",
                      ),
                    ),
                  );
                } else if (index == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailCutiPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                        id: row['id'] ?? "",
                      ),
                    ),
                  );
                } else if (index == 2) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailCutiPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                        id: row['id'] ?? "",
                      ),
                    ),
                  );
                } else if (index == 3) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailCutiPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                        id: row['id'] ?? "",
                      ),
                    ),
                  );
                } else if (index == 4) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailCutiPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                        id: row['id'] ?? "",
                      ),
                    ),
                  );
                } else if (index == 5) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailCutiPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                        id: row['id'] ?? "",
                      ),
                    ),
                  );
                } else if (index == 6) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailCutiPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                        id: row['id'] ?? "",
                      ),
                    ),
                  );
                } else if (index == 7) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailCutiPage(
                        accessToken: widget.accessToken,
                        tahun: widget.tahun,
                        id: row['id'] ?? "",
                      ),
                    ),
                  );
                } else {
                  onBasicAlertPressed(context, "500", "Menu belum dibuat");
                }
              },
              child: Container(
                padding: const EdgeInsets.all(1),
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                    decoration: BoxDecoration(
                      gradient: locations[index].smartDeviceColor,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 23, 56, 82),
                          blurRadius: 1.0,
                          spreadRadius: 0.5,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(locations[index].smartDeviceName,
                              style:
                                  const TextStyle(fontSize: 18, color: clrEdit),
                              textAlign: TextAlign.center),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(locations[index].smartDeviceTotal,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.white),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
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

class DeviceBoxWidget {
  final String smartDeviceName;
  final String smartDeviceTotal;
  final Gradient smartDeviceColor;
  final double? width;
  final double? heightImage;

  DeviceBoxWidget({
    required this.smartDeviceName,
    required this.smartDeviceTotal,
    required this.smartDeviceColor,
    required this.width,
    this.heightImage,
  });
}
