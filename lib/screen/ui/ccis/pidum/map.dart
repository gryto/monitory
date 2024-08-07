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
import 'detailJampidum/detailHukumanMati.dart';
import 'detailJampidum/detailPenuntutan.dart';
import 'detailJampidum/detailPraPenuntutan.dart';
import 'detailJampidum/detailUpayaHukum.dart';

class DetailPidum extends StatefulWidget {
  final String accessToken, tahun;

  const DetailPidum({Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<DetailPidum> createState() => _DetailPidumState();
}

class _DetailPidumState extends State<DetailPidum> {
  late final PlatformWebViewControllerCreationParams params;
  late Widget body;
  String title = "JAMPIDUM";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();
  TextEditingController monthStart = TextEditingController();
  // DateTime _selectedMonth = DateTime.now();
  TextEditingController monthEnd = TextEditingController();
  // DateTime _selecteEndMonth = DateTime.now();

  num totalPranuntutan = 0;

  num totalPenuntutan = 0;

  num totalUpayaHukum = 0;

  num totalHukumanMati = 0;

  // String selectedMonth = "January"; // Bulan default
  String selectedStartMonth = ""; // Bulan default
  String selectedStartMonthName = ""; // Bulan default
  String selectedEndMonth = ""; // Bulan default
  String selectedEndMonthName = ""; // Bulan default = ""; // Bulan default

  searchData(tahun, bulanAwal, bulanAkhir) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
      selectedStartMonth = bulanAwal;
      selectedEndMonth = bulanAkhir;
    });

    getData(year.toString(), selectedStartMonth, selectedEndMonth);
    getData2(year.toString(), selectedStartMonth, selectedEndMonth);
    getData3(year.toString(), selectedStartMonth, selectedEndMonth);
    getData4(year.toString(), selectedStartMonth, selectedEndMonth);
  }

  getData(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidum2),
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
          totalPranuntutan = content['data']['total'];
          print(totalPranuntutan);
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

  getData2(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countAllPidum2),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          //Prapenuntutan - SPDP
          totalPenuntutan = content['data']['total'];
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

  getData3(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidumParent2),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          //Prapenuntutan - SPDP
          totalUpayaHukum = content['data']['total'];
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

  getData4(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidumKategori2),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);

      if (content['status'] == 200) {
        setState(() {
          //Prapenuntutan - SPDP
          totalHukumanMati = content['data']['total'];
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
    getData(year.toString(), selectedStartMonth, selectedEndMonth);
    getData2(year.toString(), selectedStartMonth, selectedEndMonth);
    getData3(year.toString(), selectedStartMonth, selectedEndMonth);
    getData4(year.toString(), selectedStartMonth, selectedEndMonth);
  }

  selectyear(context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          surfaceTintColor: const Color.fromARGB(255, 13, 30, 46),
          backgroundColor: const Color.fromARGB(255, 13, 30, 46),
          title:
              const Text("Pilih Tahun", style: TextStyle(color: Colors.white)),
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

  @override
  dispose() {
    super.dispose();
  }

  checkSession() async {
    setState(() {
      year = today.year;
      selectedStartMonth = "01";
      selectedEndMonth = "12";
    });

    yearStart.text = year.toString();
    getData(year.toString(), selectedStartMonth, selectedEndMonth);
    getData2(year.toString(), selectedStartMonth, selectedEndMonth);
    getData3(year.toString(), selectedStartMonth, selectedEndMonth);
    getData4(year.toString(), selectedStartMonth, selectedEndMonth);
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
                fontSize: 16, fontWeight: FontWeight.w500, color: clrDelete),
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
                      "assets/icons/LOGO_JAMPIDUM.png",
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
                                      const SizedBox(
                                        height: 10.0,
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
          !isProcess
              ? Padding(
                  padding: const EdgeInsets.only(
                      top: 2, left: 15, right: 15, bottom: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SettingsItem(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailPraPenuntutanPage(
                                accessToken: widget.accessToken,
                                tahun: year,
                                bulanAwal: selectedStartMonth,
                                bulanAkhir: selectedEndMonth,
                              ),
                            ),
                          );
                        },
                        icons: Icons.present_to_all,
                        iconStyle: IconStyle(
                          iconsColor: Colors.white,
                          withBackground: true,
                          backgroundColor: clrDelete,
                        ),
                        title: 'PRAPENUNTUTAN',
                        subtitle: totalPranuntutan.toString(),
                        subtitleStyle: const TextStyle(color: Colors.white),
                      ),
                      const Divider(
                        height: 2,
                      ),
                      SettingsItem(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => DetailPenuntutanPage(
                                accessToken: widget.accessToken,
                                tahun: year,
                                bulanAwal: selectedStartMonth,
                                bulanAkhir: selectedEndMonth,
                              ),
                            ),
                          );
                        },
                        icons: Icons.co_present,
                        iconStyle: IconStyle(
                          iconsColor: Colors.white,
                          withBackground: true,
                          backgroundColor: clrDelete,
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
                              builder: (context) => UpayaHukumPage(
                                accessToken: widget.accessToken,
                                tahun: year,
                                bulanAwal: selectedStartMonth,
                                bulanAkhir: selectedEndMonth,
                              ),
                            ),
                          );
                        },
                        icons: Icons.scale,
                        iconStyle: IconStyle(
                          iconsColor: Colors.white,
                          withBackground: true,
                          backgroundColor: clrDelete,
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
                              builder: (context) => DetailHukumanMatiPage(
                                accessToken: widget.accessToken,
                                tahun: year,
                                bulanAwal: selectedStartMonth,
                                bulanAkhir: selectedEndMonth,
                              ),
                            ),
                          );
                        },
                        icons: Icons.person_off,
                        iconStyle: IconStyle(
                          iconsColor: Colors.white,
                          withBackground: true,
                          backgroundColor: clrDelete,
                        ),
                        title: 'EKSEKUSI',
                        subtitle: totalHukumanMati.toString(),
                        subtitleStyle: const TextStyle(color: Colors.white),
                      ),
                      const Divider(
                        height: 2,
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.grey,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xff3cd2a5),
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
