// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/toast.dart';
import '../../../../widget/custom_button_primary.dart';
import '../../../../widget/room_widget.dart';
import '../../constants/api.dart';
import 'detailPraPenuntutan2.dart';

class DetailPraPenuntutanPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final accessToken, tahun, bulanAwal, bulanAkhir;

  const DetailPraPenuntutanPage({
    super.key,
    required this.accessToken,
    required this.tahun,
    required this.bulanAwal,
    required this.bulanAkhir,
  });

  @override
  State<DetailPraPenuntutanPage> createState() =>
      _DetailPraPenuntutanPageState();
}

class _DetailPraPenuntutanPageState extends State<DetailPraPenuntutanPage> {
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
  String totalSpdp = '';
  String spdpKorupsi = '';
  String spdpKorupsiTppu = '';
  String spdpPerpajakan = '';
  String spdpPerpajakanTppu = '';
  String spdpKapabeanan = '';
  String spdpKapabeananTppu = '';
  String spdpCukai = '';
  String spdpCukaiTppu = '';

  String totalTahap1 = "";
  String tahap1Korupsi = "";
  String tahap1KorupsiTppu = "";
  String tahap1Perpajakan = "";
  String tahap1PerpajakanTppu = "";
  String tahap1Kapabeanan = "";
  String tahap1KapabeananTppu = "";
  String tahap1Cukai = "";
  String tahap1CukaiTppu = "";

  String totalP21 = "";
  String p21Korupsi = "";
  String p21KorupsiTppu = "";
  String p21Perpajakan = "";
  String p21PerpajakanTppu = "";
  String p21Kapabeanan = "";
  String p21KapabeananTppu = "";
  String p21Cukai = "";
  String p21CukaiTppu = "";

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
      var response = await http.post(Uri.parse(ApiService.countPidsusPratu2),
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
          totalSpdp = content['data']['spdpData']['jml_spdp'];
          spdpKorupsi = content['data']['spdpData']['spdp_korupsi'];
          spdpKorupsiTppu = content['data']['spdpData']['spdp_korupsi_tppu'];
          spdpPerpajakan = content['data']['spdpData']['spdp_perpajakan'];
          spdpPerpajakanTppu =
              content['data']['spdpData']['spdp_perpajakan_tppu'];
          spdpKapabeanan = content['data']['spdpData']['spdp_kepabeanan'];
          spdpKapabeananTppu =
              content['data']['spdpData']['spdp_kepabeanan_tppu'];
          spdpCukai = content['data']['spdpData']['spdp_cukai'];
          spdpCukaiTppu = content['data']['spdpData']['spdp_cukai_tppu'];

          totalTahap1 = content['data']['tahap1Data']['jml_tahap1'];
          tahap1Korupsi = content['data']['tahap1Data']['tahap1_korupsi'];
          tahap1KorupsiTppu =
              content['data']['tahap1Data']['tahap1_korupsi_tppu'];
          tahap1Perpajakan = content['data']['tahap1Data']['tahap1_perpajakan'];
          tahap1PerpajakanTppu =
              content['data']['tahap1Data']['tahap1_perpajakan_tppu'];
          tahap1Kapabeanan = content['data']['tahap1Data']['tahap1_kepabeanan'];
          tahap1KapabeananTppu =
              content['data']['tahap1Data']['tahap1_kepabeanan_tppu'];
          tahap1Cukai = content['data']['tahap1Data']['tahap1_cukai'];
          tahap1CukaiTppu = content['data']['tahap1Data']['tahap1_cukai_tppu'];

          totalP21 = content['data']['berkasLengkapData']['jml_p21'];
          p21Korupsi = content['data']['berkasLengkapData']['p21_korupsi'];
          p21KorupsiTppu =
              content['data']['berkasLengkapData']['p21_korupsi_tppu'];
          p21Perpajakan =
              content['data']['berkasLengkapData']['p21_perpajakan'];
          p21PerpajakanTppu =
              content['data']['berkasLengkapData']['p21_perpajakan_tppu'];
          p21Kapabeanan =
              content['data']['berkasLengkapData']['p21_kepabeanan'];
          p21KapabeananTppu =
              content['data']['berkasLengkapData']['p21_kepabeanan_tppu'];
          p21Cukai = content['data']['berkasLengkapData']['p21_cukai'];
          p21CukaiTppu = content['data']['berkasLengkapData']['p21_cukai_tppu'];
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
        title: "SPDP",
        count: totalSpdp,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "SPDP Korupsi",
            colorIcon: clrWait,
            count: spdpKorupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "SPDP Korupsi TPPU",
            colorIcon: clrBadge,
            count: spdpKorupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "SPDP Perpajakan",
            colorIcon: clrBadge,
            count: spdpPerpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "SPDP Perpajakan TPPU",
            colorIcon: clrBadge,
            count: spdpPerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "SPDP Kapabeanan",
              colorIcon: clrBadge,
              count: spdpKapabeanan),
          RoomContainer(
              onTap: () {},
              title: "SPDP Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: spdpKapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "SPDP Cukai",
              colorIcon: clrBadge,
              count: spdpCukai),
          RoomContainer(
              onTap: () {},
              title: "SPDP Cukai TPPU",
              colorIcon: clrBadge,
              count: spdpCukaiTppu),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "Tahap 1",
        count: totalTahap1,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Tahap1 Korupsi",
            colorIcon: clrWait,
            count: tahap1Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tahap1 Korupsi TPPU",
            colorIcon: clrBadge,
            count: tahap1Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tahap1 Perpajakan",
            colorIcon: clrBadge,
            count: tahap1Perpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tahap1 Perpajakan TPPU",
            colorIcon: clrBadge,
            count: tahap1PerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "Tahap1 Kapabeanan",
              colorIcon: clrBadge,
              count: tahap1Kapabeanan),
          RoomContainer(
              onTap: () {},
              title: "Tahap1 Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: tahap1KapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "Tahap1 Cukai",
              colorIcon: clrBadge,
              count: tahap1Cukai),
          RoomContainer(
              onTap: () {},
              title: "Tahap1 Cukai TPPU",
              colorIcon: clrBadge,
              count: tahap1CukaiTppu),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "P21",
        count: totalP21,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "P21 Korupsi",
            colorIcon: clrWait,
            count: p21Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "P21 Korupsi TPPU",
            colorIcon: clrBadge,
            count: p21Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "P21 Perpajakan",
            colorIcon: clrBadge,
            count: p21Perpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "P21 Perpajakan TPPU",
            colorIcon: clrBadge,
            count: p21PerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "P21 Kapabeanan",
              colorIcon: clrBadge,
              count: p21Kapabeanan),
          RoomContainer(
              onTap: () {},
              title: "P21 Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: p21KapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "P21 Cukai",
              colorIcon: clrBadge,
              count: p21Cukai),
          RoomContainer(
              onTap: () {},
              title: "P21 Cukai TPPU",
              colorIcon: clrBadge,
              count: p21CukaiTppu),
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
                    "Pra Penuntutan",
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
                      builder: (context) => DetailPraPenuntutan2Page(
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
