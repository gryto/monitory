// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../../src/toast.dart';
import '../../../../widget/custom_button_primary.dart';
import '../../../../widget/room_widget.dart';
import '../../constants/api.dart';
import 'detailPenuntutan2.dart';

class DetailPenuntutanJampidsusPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final accessToken, tahun, bulanAwal, bulanAkhir;

  const DetailPenuntutanJampidsusPage({
    super.key,
    required this.accessToken,
    required this.tahun,
    required this.bulanAwal,
    required this.bulanAkhir,
  });

  @override
  State<DetailPenuntutanJampidsusPage> createState() =>
      _DetailPenuntutanJampidsusPageState();
}

class _DetailPenuntutanJampidsusPageState
    extends State<DetailPenuntutanJampidsusPage> {
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
  String totalTahap2 = '';
  String tahap2Korupsi = '';
  String tahap2KorupsiTppu = '';
  String tahap2Perpajakan = '';
  String tahap2PerpajakanTppu = '';
  String tahap2Kapabeanan = '';
  String tahap2KapabeananTppu = '';
  String tahap2Cukai = '';
  String tahap2CukaiTppu = '';

  String totalPelimpahan = "";
  String pelimpahanKorupsi = "";
  String pelimpahanKorupsiTppu = "";
  String pelimpahanPerpajakan = "";
  String pelimpahanPerpajakanTppu = "";
  String pelimpahanKapabeanan = "";
  String pelimpahanKapabeananTppu = "";
  String pelimpahanCukai = "";
  String pelimpahanCukaiTppu = "";

  String totalTuntutan = "";
  String tuntutanKorupsi = "";
  String tuntutanKorupsiTppu = "";
  String tuntutanPerpajakan = "";
  String tuntutanPerpajakanTppu = "";
  String tuntutanKapabeanan = "";
  String tuntutanKapabeananTppu = "";
  String tuntutanCukai = "";
  String tuntutanCukaiTppu = "";

  String totalSkkp = "";
  String skppKorupsi = "";
  String skppKorupsiTppu = "";
  String skppPerpajakan = "";
  String skppPerpajakanTppu = "";
  String skppKapabeanan = "";
  String skppKapabeananTppu = "";
  String skppCukai = "";
  String skppCukaiTppu = "";

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
      var response = await http.post(Uri.parse(ApiService.countPidsusPetut2),
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
          totalTahap2 = content['data']['tahap2Data']['jml_tahap2'];
          tahap2Korupsi = content['data']['tahap2Data']['tahap2_korupsi'];
          tahap2KorupsiTppu =
              content['data']['tahap2Data']['tahap2_korupsi_tppu'];
          tahap2Perpajakan = content['data']['tahap2Data']['tahap2_pajak'];
          tahap2PerpajakanTppu =
              content['data']['tahap2Data']['tahap2_pajak_tppu'];
          tahap2Kapabeanan = content['data']['tahap2Data']['tahap2_kepabeanan'];
          tahap2KapabeananTppu =
              content['data']['tahap2Data']['tahap2_kepabeanan_tppu'];
          tahap2Cukai = content['data']['tahap2Data']['tahap2_cukai'];
          tahap2CukaiTppu = content['data']['tahap2Data']['tahap2_cukai_tppu'];

          totalPelimpahan = content['data']['pelimpahanData']['jml_pelimpahan'];
          pelimpahanKorupsi =
              content['data']['pelimpahanData']['pelimpahan_korupsi'];
          pelimpahanKorupsiTppu =
              content['data']['pelimpahanData']['pelimpahan_korupsi_tppu'];
          pelimpahanPerpajakan =
              content['data']['pelimpahanData']['pelimpahan_pajak'];
          pelimpahanPerpajakanTppu =
              content['data']['pelimpahanData']['pelimpahan_pajak_tppu'];
          pelimpahanKapabeanan =
              content['data']['pelimpahanData']['pelimpahan_kepabeanan'];
          pelimpahanKapabeananTppu =
              content['data']['pelimpahanData']['pelimpahan_kepabeanan_tppu'];
          pelimpahanCukai =
              content['data']['pelimpahanData']['pelimpahan_cukai'];
          pelimpahanCukaiTppu =
              content['data']['pelimpahanData']['pelimpahan_cukai_tppu'];

          totalTuntutan = content['data']['tuntutanData']['jml_tuntutan'];
          tuntutanKorupsi = content['data']['tuntutanData']['tuntutan_korupsi'];
          tuntutanKorupsiTppu =
              content['data']['tuntutanData']['tuntutan_korupsi_tppu'];
          tuntutanPerpajakan =
              content['data']['tuntutanData']['tuntutan_pajak'];
          tuntutanPerpajakanTppu =
              content['data']['tuntutanData']['tuntutan_pajak_tppu'];
          tuntutanKapabeanan =
              content['data']['tuntutanData']['tuntutan_kepabeanan'];
          tuntutanKapabeananTppu =
              content['data']['tuntutanData']['tuntutan_kepabeanan_tppu'];
          tuntutanCukai = content['data']['tuntutanData']['tuntutan_cukai'];
          tuntutanCukaiTppu =
              content['data']['tuntutanData']['tuntutan_cukai_tppu'];

          totalSkkp = content['data']['skppData']['jml_skpp'];
          skppKorupsi = content['data']['skppData']['skpp_korupsi'];
          skppKorupsiTppu = content['data']['skppData']['skpp_korupsi_tppu'];
          skppPerpajakan = content['data']['skppData']['skpp_pajak'];
          skppPerpajakanTppu = content['data']['skppData']['skpp_pajak_tppu'];
          skppKapabeanan = content['data']['skppData']['skpp_kepabeanan'];
          skppKapabeananTppu =
              content['data']['skppData']['skpp_kepabeanan_tppu'];
          skppCukai = content['data']['skppData']['skpp_cukai'];
          skppCukaiTppu = content['data']['skppData']['skpp_cukai_tppu'];
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
        title: "Tahap2",
        count: totalTahap2,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Tahap2 Korupsi",
            colorIcon: clrWait,
            count: tahap2Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tahap2 Korupsi TPPU",
            colorIcon: clrBadge,
            count: tahap2Korupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tahap2 Perpajakan",
            colorIcon: clrBadge,
            count: tahap2Perpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tahap2 Perpajakan TPPU",
            colorIcon: clrBadge,
            count: tahap2PerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "Tahap2 Kapabeanan",
              colorIcon: clrBadge,
              count: tahap2Kapabeanan),
          RoomContainer(
              onTap: () {},
              title: "Tahap2 Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: tahap2KapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "Tahap2 Cukai",
              colorIcon: clrBadge,
              count: tahap2Cukai),
          RoomContainer(
              onTap: () {},
              title: "Tahap2 Cukai TPPU",
              colorIcon: clrBadge,
              count: tahap2CukaiTppu),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "Pelimpahan",
        count: totalPelimpahan,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Pelimpahan Korupsi",
            colorIcon: clrWait,
            count: pelimpahanKorupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "Pelimpahan Korupsi TPPU",
            colorIcon: clrBadge,
            count: pelimpahanKorupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "Pelimpahan Perpajakan",
            colorIcon: clrBadge,
            count: pelimpahanPerpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "Pelimpahan Perpajakan TPPU",
            colorIcon: clrBadge,
            count: pelimpahanPerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "Pelimpahan Kapabeanan",
              colorIcon: clrBadge,
              count: pelimpahanKapabeanan),
          RoomContainer(
              onTap: () {},
              title: "Pelimpahan Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: pelimpahanKapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "Pelimpahan Cukai",
              colorIcon: clrBadge,
              count: pelimpahanCukai),
          RoomContainer(
              onTap: () {},
              title: "Pelimpahan Cukai TPPU",
              colorIcon: clrBadge,
              count: pelimpahanCukaiTppu),
          // Add other RoomContainer objects as needed
        ],
      ),
      RoomCategoryData(
        title: "Tuntutan",
        count: totalTuntutan,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "Tuntutan Korupsi",
            colorIcon: clrWait,
            count: tuntutanKorupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tuntutan Korupsi TPPU",
            colorIcon: clrBadge,
            count: tuntutanKorupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tuntutan Perpajakan",
            colorIcon: clrBadge,
            count: tuntutanPerpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "Tuntutan Perpajakan TPPU",
            colorIcon: clrBadge,
            count: tuntutanPerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "Tuntutan Kapabeanan",
              colorIcon: clrBadge,
              count: tuntutanKapabeanan),
          RoomContainer(
              onTap: () {},
              title: "Tuntutan Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: tuntutanKapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "Tuntutan Cukai",
              colorIcon: clrBadge,
              count: tuntutanCukai),
          RoomContainer(
              onTap: () {},
              title: "Tuntutan Cukai TPPU",
              colorIcon: clrBadge,
              count: tuntutanCukaiTppu),
          // Add other RoomContainerData objects as needed
        ],
      ),
      RoomCategoryData(
        title: "SKPP",
        count: totalSkkp,
        roomContainers: [
          RoomContainer(
            onTap: () {},
            title: "SKPP Korupsi",
            colorIcon: clrWait,
            count: skppKorupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "SKPP Korupsi TPPU",
            colorIcon: clrBadge,
            count: skppKorupsi,
          ),
          RoomContainer(
            onTap: () {},
            title: "SKPP Perpajakan",
            colorIcon: clrBadge,
            count: skppPerpajakan,
          ),
          RoomContainer(
            onTap: () {},
            title: "SKPP Perpajakan TPPU",
            colorIcon: clrBadge,
            count: skppPerpajakanTppu,
          ),
          RoomContainer(
              onTap: () {},
              title: "SKPP Kapabeanan",
              colorIcon: clrBadge,
              count: skppKapabeanan),
          RoomContainer(
              onTap: () {},
              title: "SKPP Kapabeanan TPPU",
              colorIcon: clrBadge,
              count: skppKapabeananTppu),
          RoomContainer(
              onTap: () {},
              title: "SKPP Cukai",
              colorIcon: clrBadge,
              count: skppCukai),
          RoomContainer(
              onTap: () {},
              title: "SKPP Cukai TPPU",
              colorIcon: clrBadge,
              count: skppCukaiTppu),
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
                    "Penuntutan",
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
                      builder: (context) => DetailPenuntutan2Page(
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
