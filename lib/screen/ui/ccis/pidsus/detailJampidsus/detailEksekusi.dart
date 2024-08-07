// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/toast.dart';
import '../../../../widget/custom_button_primary.dart';
import '../../../../widget/room_widget.dart';
import '../../constants/api.dart';
import 'detailEksekusi2.dart';

class DetailEksekusiJampidsusPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final accessToken, tahun, bulanAwal, bulanAkhir;

  const DetailEksekusiJampidsusPage({
    super.key,
    required this.accessToken,
    required this.tahun,
    required this.bulanAwal,
    required this.bulanAkhir,
  });

  @override
  State<DetailEksekusiJampidsusPage> createState() =>
      _DetailEksekusiJampidsusPageState();
}

class _DetailEksekusiJampidsusPageState
    extends State<DetailEksekusiJampidsusPage> {
  List<String> last7Days = [];
  int monthNumber = 0;
  String message = "";
  bool isProcess = true;
  List listData = [];

  num year = 0;
  DateTime today = DateTime.now();
  TextEditingController yearStart = TextEditingController();
  DateTime _selectedYear = DateTime.now();
  String totalDitingkatkan = "";
  String totalTidakDitingkatkan = "";
  String totalDiserahkan = "";
  num totalPenyelidikan = 0;
  String selectedStartMonth = ""; // Bulan default
  String selectedStartMonthName = ""; // Bulan default
  String selectedEndMonth = ""; // Bulan default
  String selectedEndMonthName = ""; // Bulan default = ""; // Bulan default

  // num totalPenyelidikan = 0;
  String totalP48 = '';
  String p48Korupsi = '';
  String p48KorupsiTppu = '';
  String p48Perpajakan = '';
  String p48PerpajakanTppu = '';
  String p48Kapabeanan = '';
  String p48KapabeananTppu = '';
  String p48Cukai = '';
  String p48CukaiTppu = '';

  String totalBa17 = "";
  String ba17Korupsi = "";
  String ba17KorupsiTppu = "";
  String ba17Perpajakan = "";
  String ba17PerpajakanTppu = "";
  String ba17Kapabeanan = "";
  String ba17KapabeananTppu = "";
  String ba17Cukai = "";
  String ba17CukaiTppu = "";

  String totalD3 = "";
  String d3Korupsi = "";
  String d3KorupsiTppu = "";
  String d3Perpajakan = "";
  String d3PerpajakanTppu = "";
  String d3Kapabeanan = "";
  String d3KapabeananTppu = "";
  String d3Cukai = "";
  String d3CukaiTppu = "";

  searchData(tahun, bulanAwal, bulanAkhir) {
    setState(() {
      isProcess = true;
      year = int.parse(tahun);
      selectedStartMonth = bulanAwal;
      selectedEndMonth = bulanAkhir;
    });

    getData(year.toString(), selectedStartMonth, selectedEndMonth);
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

  getData(tahun, bulanAwal, bulanAkhir) async {
    try {
      var params = jsonEncode({
        "tahun": tahun.toString(),
        "bulan_awal": bulanAwal,
        "bulan_akhir": bulanAkhir,
      });
      // var params = jsonEncode({"tahun": widget.tahun});
      var response = await http.post(Uri.parse(ApiService.countPidsusEksekusi2),
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
          // listData = content['data'];
          totalP48 = content['data']['p48Data']['jml_p48'];
          p48Korupsi = content['data']['p48Data']['p48_korupsi'];
          p48KorupsiTppu = content['data']['p48Data']['p48_korupsi_tppu'];
          p48Perpajakan = content['data']['p48Data']['p48_pajak'];
          p48PerpajakanTppu = content['data']['p48Data']['p48_pajak_tppu'];
          p48Kapabeanan = content['data']['p48Data']['p48_kepabeanan'];
          p48KapabeananTppu = content['data']['p48Data']['p48_kepabeanan_tppu'];
          p48Cukai = content['data']['p48Data']['p48_cukai'];
          p48CukaiTppu = content['data']['p48Data']['p48_cukai_tppu'];

          totalBa17 = content['data']['p38Data']['jml_ba17'];
          ba17Korupsi = content['data']['p38Data']['ba17_korupsi'];
          ba17KorupsiTppu = content['data']['p38Data']['ba17_korupsi_tppu'];
          ba17Perpajakan = content['data']['p38Data']['ba17_pajak'];
          ba17PerpajakanTppu = content['data']['p38Data']['ba17_pajak_tppu'];
          ba17Kapabeanan = content['data']['p38Data']['ba17_kepabeanan'];
          ba17KapabeananTppu =
              content['data']['p38Data']['ba17_kepabeanan_tppu'];
          ba17Cukai = content['data']['p38Data']['ba17_cukai'];
          ba17CukaiTppu = content['data']['p38Data']['ba17_cukai_tppu'];

          totalD3 = content['data']['d3Data']['jml_d3'];
          d3Korupsi = content['data']['d3Data']['d3_korupsi'];
          d3KorupsiTppu = content['data']['d3Data']['d3_korupsi_tppu'];
          d3Perpajakan = content['data']['d3Data']['d3_pajak'];
          d3PerpajakanTppu = content['data']['d3Data']['d3_pajak_tppu'];
          d3Kapabeanan = content['data']['d3Data']['d3_kepabeanan'];
          d3KapabeananTppu = content['data']['d3Data']['d3_kepabeanan_tppu'];
          d3Cukai = content['data']['d3Data']['d3_cukai'];
          d3CukaiTppu = content['data']['d3Data']['d3_cukai_tppu'];
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
  }

  @override
  void initState() {
    checkSession();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<String> monthNumbers = months
        .asMap()
        .map((index, month) {
          int numericValue = index + 1; // Adding 1 to start from 1
          return MapEntry(month,
              numericValue.toString().padLeft(2, '0')); // Adding leading zeros
        })
        .values
        .toList();

    List<RoomCategoryData> roomCategories = [
      RoomCategoryData(
        title: "P48",
        count: totalP48,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "P48 Korupsi",
            colorIcon: clrWait,
            count: p48Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "P48 Korupsi TPPU",
            colorIcon: clrBadge,
            count: p48Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "P48 Perpajakan",
            colorIcon: clrBadge,
            count: p48Perpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "P48 Perpajakan TPPU",
            colorIcon: clrBadge,
            count: p48PerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "P48 Kapabeanan",
              colorIcon: clrBadge,
              count: p48Kapabeanan),
          RoomContainer(
              onTap: () {},
              title: "P48 Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: p48KapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "P48 Cukai",
              colorIcon: clrBadge,
              count: p48Cukai),
          RoomContainer(
              onTap: () {},
              title: "P48 Cukai TPPU",
              colorIcon: clrBadge,
              count: p48CukaiTppu),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "P38",
        count: totalBa17,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "P38 Korupsi",
            colorIcon: clrWait,
            count: ba17Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "P38 Korupsi TPPU",
            colorIcon: clrBadge,
            count: ba17Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "P38 Perpajakan",
            colorIcon: clrBadge,
            count: ba17Perpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "P38 Perpajakan TPPU",
            colorIcon: clrBadge,
            count: ba17PerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "P38 Kapabeanan",
              colorIcon: clrBadge,
              count: ba17Kapabeanan),
          RoomContainer(
              onTap: () {},
              title: "P38 Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: ba17KapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "P38 Cukai",
              colorIcon: clrBadge,
              count: ba17Cukai),
          RoomContainer(
              onTap: () {},
              title: "P38 Cukai TPPU",
              colorIcon: clrBadge,
              count: ba17CukaiTppu),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "D3",
        count: totalD3,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "D3 Korupsi",
            colorIcon: clrWait,
            count: d3Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "D3 Korupsi TPPU",
            colorIcon: clrBadge,
            count: d3Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "D3 Perpajakan",
            colorIcon: clrBadge,
            count: d3Perpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "D3 Perpajakan TPPU",
            colorIcon: clrBadge,
            count: d3PerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "D3 Kapabeanan",
              colorIcon: clrBadge,
              count: d3Kapabeanan),
          RoomContainer(
              onTap: () {},
              title: "D3 Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: d3KapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "D3 Cukai",
              colorIcon: clrBadge,
              count: d3Cukai),
          RoomContainer(
              onTap: () {},
              title: "D3 Cukai TPPU",
              colorIcon: clrBadge,
              count: d3CukaiTppu),
          // Add other RoomContainerData objects as needed
        ],
      ),
    ];

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
                    "assets/icons/LOGO_PIDSUS_SELOKA.png",
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
                    "Eksekusi",
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    "JAMPIDSUS",
                    style: TextStyle(color: clrPink, fontSize: 10),
                  ),
                  Text(
                    "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )",
                    style: TextStyle(color: Colors.white, fontSize: 9),
                  )
                ],
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
                                    color:
                                        const Color.fromARGB(255, 13, 30, 46),
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
                                          child:
                                              DropdownButtonFormField<String>(
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
                                                    .map((numericMonth) =>
                                                        months[int.parse(
                                                                numericMonth) -
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
                                          child:
                                              DropdownButtonFormField<String>(
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
                                                    .map((numericMonth) =>
                                                        months[int.parse(
                                                                numericMonth) -
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
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
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
            !isProcess
                ? Column(
                    children: roomCategories
                        .map((roomCategory) => Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        roomCategory
                                            .title, // Use the title from RoomCategoryData
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        "Total ${roomCategory.count}", // Use the title from RoomCategoryData
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: roomCategory.roomContainers
                                              .map((roomContainerData) =>
                                                  RoomContainer(
                                                    onTap:
                                                        roomContainerData.onTap,
                                                    title:
                                                        roomContainerData.title,
                                                    colorIcon: roomContainerData
                                                        .colorIcon,
                                                    count:
                                                        roomContainerData.count,
                                                  ))
                                              .toList(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ))
                        .toList(),
                  )
                : const Padding(
                    padding: EdgeInsets.only(bottom: 20),
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff3cd2a5)),
                      ),
                    ),
                  ),
            const SizedBox(
              height: 15,
            ),
            Container(
              alignment: Alignment.centerRight,
              child: CustomButtonPrimary(
                text: 'Detail Keseluruhan',
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => DetailEksekusi2Page(
                        accessToken: widget.accessToken,
                        tahun: year.toString(),
                        bulanAwal: selectedStartMonth,
                        bulanAkhir: selectedEndMonth,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RoomCategoryData {
  final String title;
  final String count;
  final List<RoomContainer> roomContainers;

  RoomCategoryData({
    required this.title,
    required this.count,
    required this.roomContainers,
  });
}
