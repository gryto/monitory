import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../../src/constant.dart';
import '../../../../src/logout.dart';
import '../../../../src/preference.dart';
import '../../../../src/toast.dart';
import '../../../widget/icon_style.dart';
import '../../../widget/setting_item.dart';
import '../constants/api.dart';
import 'detailJampidsus/detailEksekusi.dart';
import 'detailJampidsus/detailHam.dart';
import 'detailJampidsus/detailPenuntutan.dart';
import 'detailJampidsus/detailPraPenuntutan.dart';
import 'detailJampidsus/detailUpayaHukum.dart';
import 'detailJampidsus/penyelidikan/page.dart';
import 'detailJampidsus/penyidikan/page.dart';

class DetailPidsus extends StatefulWidget {
  final String accessToken, tahun;

  const DetailPidsus({Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailPidsus> createState() => _DetailPidsusState();
}

class _DetailPidsusState extends State<DetailPidsus> {
  String title = "JAMPIDSUS";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";
  late final PlatformWebViewControllerCreationParams params;
  late Widget body;

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();

  String totalPenyelidikan = "";
  num totalPenyidikan = 0;
  num totalPrapenuntutan = 0;
  num totalPenuntutan = 0;
  num totalEksekusi = 0;
  num totalUpayaHukum = 0;
  num totalHam = 0;
  String selectedStartMonth = ""; // Bulan default
  String selectedStartMonthName = ""; // Bulan default
  String selectedEndMonth = ""; // Bulan default
  String selectedEndMonthName = ""; // Bulan default = ""; // Bulan default

  List<String> months = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember'
  ];

  searchData(tahun, bulanAwal, bulanAkhir) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
      selectedStartMonth = bulanAwal;
      selectedEndMonth = bulanAkhir;
    });

    getData(year.toString(), selectedStartMonth, selectedEndMonth);
    getData1(year.toString(), selectedStartMonth, selectedEndMonth);
    getData2(year.toString(), selectedStartMonth, selectedEndMonth);
    getData3(year.toString(), selectedStartMonth, selectedEndMonth);
    getData4(year.toString(), selectedStartMonth, selectedEndMonth);
    getData5(year.toString(), selectedStartMonth, selectedEndMonth);
    getData6(year.toString(), selectedStartMonth, selectedEndMonth);
  }

  getData(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidsus1),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          //Prapenuntutan - SPDP
          if (totalPenyelidikan.isNotEmpty) {
            totalPenyelidikan = content['data']['total'];
            print(totalPenyelidikan);
          } else {
            totalPenyelidikan = "0";
          }
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context,
          "Tidak ada data penyelidikan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData1(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(
          Uri.parse(ApiService.countPidsusPenyidikan1),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalPenyidikan = content['data']['total'];
          print(totalPenyelidikan);

          //Prapenuntutan - SPDP
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(
          context, "Tidak ada data penyidikan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData2(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidsusPratut1),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalPrapenuntutan = content['data']['total'];
          print(totalPrapenuntutan);
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(context,
          "Tidak ada data pra penuntutan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData3(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidsusPetut1),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalPenuntutan = content['data']['total'];
          print(totalPenuntutan);
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(
          context, "Tidak ada data penuntutan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData4(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidsusEksekusi1),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalEksekusi = content['data']['total'];
          print(totalPenuntutan);
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(
          context, "Tidak ada data penuntutan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData5(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidsusUHukum1),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalUpayaHukum = content['data']['total'];
          print(totalPenuntutan);
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(
          context, "Tidak ada data penuntutan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  getData6(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidsusHam1),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("object");
      print(content.toString());

      if (content['status'] == 200) {
        setState(() {
          totalHam = content['data']['total'];
          print(totalPenuntutan);
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      toastShort(
          context, "Tidak ada data penuntutan pada tahun ini"); //e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  selectyear(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 13, 30, 46),
          title: const Text(
            "Pilih Tahun",
            style: TextStyle(color: Colors.white),
          ),
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
      selectedStartMonth = "01";
      selectedEndMonth = "12";
    });

    yearStart.text = year.toString();
    getData(year.toString(), selectedStartMonth, selectedEndMonth);
    getData1(year.toString(), selectedStartMonth, selectedEndMonth);
    getData2(year.toString(), selectedStartMonth, selectedEndMonth);
    getData3(year.toString(), selectedStartMonth, selectedEndMonth);
    getData4(year.toString(), selectedStartMonth, selectedEndMonth);
    getData5(year.toString(), selectedStartMonth, selectedEndMonth);
    getData6(year.toString(), selectedStartMonth, selectedEndMonth);
  }

  @override
  dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkSession();

  }

  @override
  Widget build(BuildContext context) {
    Widget widgets;

    List<String> monthNumbers = months
        .asMap()
        .map((index, month) {
          int numericValue = index + 1; // Adding 1 to start from 1
          return MapEntry(month,
              numericValue.toString().padLeft(2, '0')); // Adding leading zeros
        })
        .values
        .toList();

    widgets = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: title,
            style: const TextStyle(
                fontSize: 16, fontWeight: FontWeight.w500, color: clrPink),
          ),
        ),
        RichText(
          textAlign: TextAlign.start,
          text: TextSpan(
            text: subtitle,
            style: const TextStyle(
                fontSize: 9, fontWeight: FontWeight.w300, color: Colors.white),
          ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 30, 46),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 40,
                  height: 40,
                  child: Image(
                    image: AssetImage(
                      "assets/icons/LOGO_PIDSUS_SELOKA.png",
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                widgets,
              ],
            ),
            GestureDetector(
              onTap: () {
                logoutDialog(context);
              },
              child: const Icon(
                Icons.logout,
                color: clrSecondary,
              ),
            ),
          ],
        ),
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Periode Tahun ${yearStart.text}",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                    Text(
                      "Bulan Awal: $selectedStartMonthName",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                    Text(
                      "Bulan Akhir: $selectedEndMonthName ",
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  ],
                ),
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
                                  color: const Color.fromARGB(255, 13, 30, 46),
                                  //height: 150,
                                  padding: const EdgeInsets.all(5),
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
                                        "Pencarian",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Divider(
                                        thickness: 2,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: TextField(
                                          controller: yearStart,
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            labelText: "Tahun",
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            hintStyle: const TextStyle(
                                                color: Colors.white),
                                            hintText: 'Pilih tahun',
                                            focusColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          readOnly: true,
                                          onTap: () async {
                                            selectyear(context);
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            labelText: "Awal Bulan",
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            hintStyle: const TextStyle(
                                                color: Colors.white),
                                            hintText: 'Pilih bulan',
                                            focusColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          dropdownColor: const Color.fromARGB(
                                              255, 13, 30, 46),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          value: selectedStartMonth,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedStartMonth = newValue!;
                                              print(selectedStartMonth);

                                              // Map selected numeric month to corresponding month name
                                              selectedStartMonthName = monthNumbers
                                                  .where((numericMonth) =>
                                                      numericMonth ==
                                                      selectedStartMonth)
                                                  .map((numericMonth) => months[
                                                      int.parse(numericMonth) -
                                                          1])
                                                  .first; // Get the first (and only) element

                                              print(selectedStartMonthName);
                                            });
                                          },
                                          items: monthNumbers
                                              .map((String numericMonth) {
                                            String monthName = months[
                                                int.parse(numericMonth) - 1];

                                            return DropdownMenuItem<String>(
                                              value: numericMonth,
                                              child: Text(
                                                monthName,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: DropdownButtonFormField<String>(
                                          decoration: InputDecoration(
                                            fillColor: Colors.white,
                                            labelText: "Akhir Bulan",
                                            labelStyle: const TextStyle(
                                                color: Colors.white),
                                            hintStyle: const TextStyle(
                                                color: Colors.white),
                                            hintText: 'Pilih bulan',
                                            focusColor: Colors.white,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          dropdownColor: const Color.fromARGB(
                                              255, 13, 30, 46),
                                          style: const TextStyle(
                                              color: Colors.white),
                                          value: selectedEndMonth,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedEndMonth = newValue!;
                                              print(selectedEndMonth);

                                              // Map selected numeric month to corresponding month name
                                              selectedEndMonthName = monthNumbers
                                                  .where((numericMonth) =>
                                                      numericMonth ==
                                                      selectedEndMonth)
                                                  .map((numericMonth) => months[
                                                      int.parse(numericMonth) -
                                                          1])
                                                  .first; // Get the first (and only) element

                                              print(selectedEndMonthName);
                                            });
                                          },
                                          items: monthNumbers
                                              .map((String numericMonth) {
                                            String monthName = months[
                                                int.parse(numericMonth) - 1];
                                            return DropdownMenuItem<String>(
                                              value: numericMonth,
                                              child: Text(
                                                monthName,
                                                style: const TextStyle(
                                                    color: Colors.white),
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () async {
                                          Navigator.pop(context);
                                          searchData(
                                            yearStart.text,
                                            selectedStartMonth,
                                            selectedEndMonth,
                                          );
                                        },
                                        child: Container(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20.0),
                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 5.0),
                                          decoration: BoxDecoration(
                                            color: clrBadge,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Pencarian",
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
                  child: const Icon(
                    Icons.date_range,
                    color: clrBadge,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          // Expanded(
          //   child: WebViewWidget(controller: _controller),
          // ),
          Padding(
            padding:
                const EdgeInsets.only(top: 2, left: 15, right: 15, bottom: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PenyelidikanPidsusPage(
                            accessToken: widget.accessToken,
                            tahun: yearStart.text,
                            bulanAwal: selectedStartMonth,
                            bulanAkhir: selectedEndMonth),
                      ),
                    );
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailPenyelidikanPidsus(
                    //         accessToken: widget.accessToken,
                    //         tahun: yearStart.text,
                    //         bulanAwal: selectedStartMonth,
                    //         bulanAkhir: selectedEndMonth),
                    //   ),
                    // );
                  },
                  icons: Icons.inventory,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPink,
                  ),
                  title: 'PENYELIDIKAN',
                  subtitle: totalPenyelidikan,
                  subtitleStyle: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 2,
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => PenyidikanPidsusPage(
                            accessToken: widget.accessToken,
                            tahun: yearStart.text,
                            bulanAwal: selectedStartMonth,
                            bulanAkhir: selectedEndMonth),
                      ),
                    );
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => DetailPenyidikanPidsus(
                    //         accessToken: widget.accessToken,
                    //         tahun: yearStart.text,
                    //         bulanAwal: selectedStartMonth,
                    //         bulanAkhir: selectedEndMonth),
                    //   ),
                    // );
                  },
                  icons: Icons.inventory_2,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPink,
                  ),
                  title: 'PENYIDIKAN',
                  subtitle: totalPenyidikan.toString(),
                  subtitleStyle: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 2,
                ),
                SettingsItem(
                  onTap: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (context) => PraPenuntutanPidsusPage(
                    //         accessToken: widget.accessToken,
                    //         tahun: yearStart.text,
                    //         bulanAwal: selectedStartMonth,
                    //         bulanAkhir: selectedEndMonth),
                    //   ),
                    // );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailPraPenuntutanPage(
                            accessToken: widget.accessToken,
                            tahun: yearStart.text,
                            bulanAwal: selectedStartMonth,
                            bulanAkhir: selectedEndMonth),
                      ),
                    );
                  },
                  icons: Icons.lock_clock_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPink,
                  ),
                  title: 'PRA PENUNTUTAN',
                  subtitle: totalPrapenuntutan.toString(),
                  subtitleStyle: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 2,
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailPenuntutanJampidsusPage(
                          accessToken: widget.accessToken,
                          tahun: yearStart.text,
                          bulanAwal: selectedStartMonth,
                          bulanAkhir: selectedEndMonth,
                        ),
                      ),
                    );
                  },
                  icons: Icons.lock_clock_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPink,
                  ),
                  title: 'PENUNTUTAN',
                  subtitle: totalPenuntutan.toString(),
                  subtitleStyle: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 2,
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailEksekusiJampidsusPage(
                          accessToken: widget.accessToken,
                          tahun: yearStart.text,
                          bulanAwal: selectedStartMonth,
                          bulanAkhir: selectedEndMonth,
                        ),
                      ),
                    );
                  },
                  icons: Icons.lock_clock_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPink,
                  ),
                  title: 'EKSEKUSI',
                  subtitle: totalEksekusi.toString(),
                  subtitleStyle: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 2,
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailUpayaHukumJampidsusPage(
                          accessToken: widget.accessToken,
                          tahun: yearStart.text,
                          bulanAwal: selectedStartMonth,
                          bulanAkhir: selectedEndMonth,
                        ),
                      ),
                    );
                  },
                  icons: Icons.lock_clock_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPink,
                  ),
                  title: 'UPAYA HUKUM',
                  subtitle: totalUpayaHukum.toString(),
                  subtitleStyle: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 2,
                ),
                SettingsItem(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => DetailHamJampidsusPage(
                          accessToken: widget.accessToken,
                          tahun: yearStart.text,
                          bulanAwal: selectedStartMonth,
                          bulanAkhir: selectedEndMonth,
                        ),
                      ),
                    );
                  },
                  icons: Icons.lock_clock_outlined,
                  iconStyle: IconStyle(
                    iconsColor: Colors.white,
                    withBackground: true,
                    backgroundColor: clrPink,
                  ),
                  title: 'PERKARA HAM',
                  subtitle: totalHam.toString(),
                  subtitleStyle: const TextStyle(color: Colors.white),
                ),
                const Divider(
                  height: 2,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
