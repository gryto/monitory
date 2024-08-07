import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/preference.dart';
import '../../../../../../src/toast.dart';
import '../../../constants/api.dart';
import '../../../constants/defines.dart';

class ListJdihPage extends StatefulWidget {
  final String accessToken, tahun,kodeProgram,kodeSatker;
  const ListJdihPage(
      {Key? key, required this.accessToken, required this.tahun,required this.kodeProgram,required this.kodeSatker})
      : super(key: key);

  @override
  State<ListJdihPage> createState() => _ListJdihPageState();
}

class _ListJdihPageState extends State<ListJdihPage> {
  late Widget body;

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;

  List listData = [];
  String kodeProgram = '';
  List listDataSatker = [];
  List listDataLayer2 = [];
  List arrSatkerId = [];
  String dropdownValue = '';
  String dropdownName = "";
  List listDataBidang = [];
  List listFilterDataBidang = [];
  List arrBidangId = [];

  List namaSatker = [];
  List namaGolongan = [];
  List namaBidang = [];
  String idSatker = "";
  String kode = "";

  num totalData = 0;

  searchData(idSatker, kode) {
    setState(() {
      isProcess = true;
      listData.clear();
      listDataLayer2.clear();
      dropdownValue = idSatker;
      kodeProgram = kode;
    });

    getDataLayer(dropdownValue, kodeProgram);
  }

  

  getDataLayer(idSatker, kode) async {
    try {
      var params = jsonEncode({"kode_satker": idSatker, "kode_program": kode});
      var response = await http.post(
          Uri.parse(ApiService.countKeuanganLayer2Casys),
          headers: {
            "Content-Type": "application/json",
            "sidac_token": widget.accessToken
          },
          body: params);
      var content = json.decode(response.body);
      print("angkutan" + content.toString());

      if (content['status'] == 200) {
        setState(() {
          listDataLayer2 = content['data'];
        });
      } else {
        message = "Internal connection error";
        // ignore: use_build_context_synchronously
        toastShort(context, message);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // toastShort(context, "Err detail data SAKTI"); //e.toString());
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
      print("satker" + content.toString());

      if (content['status'] == 200) {
        setState(() {
          listDataSatker = content['data'];
          for (int i = 0; i < listDataSatker.length; i++) {
            arrBidangId.add(listDataSatker[i]['kodeSatker']);
          }
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
    
    getDataSatker();
    getDataLayer(dropdownValue, kodeProgram);
  }

  checkSession() async {
    setState(() {
      idSatker = widget.kodeSatker;
      kode = widget.kodeProgram;
    });

    dropdownValue = idSatker;
    kodeProgram = kode;
    
    getDataSatker();
    getDataLayer(dropdownValue, kodeProgram);
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "JDIH",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                  Text(
                    "BIRO KEUANGAN - JAMBIN",
                    style: TextStyle(color: clrEdit, fontSize: 12),
                  ),
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
      body: Padding(
        padding: const EdgeInsets.only(top: 0, left: 10, right: 10, bottom: 10),
        child: !isProcess
            ? ListView(
                children: [
                  const SizedBox(height: kSpacing),
                  Text(
                    "Nama Satker:  $dropdownName ",
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "DETAIL KEUANGAN BERDASARKAN KODE PROGRAM",
                          maxLines: 2,
                          style: TextStyle(
                              color: clrEdit,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: Container(
                      child: !isProcess
                          ? _buildListInspektorat()
                          : const Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Color(0xff3cd2a5)),
                              ),
                            ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3cd2a5)),
                ),
              ),
      ),
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
            builder: (BuildContext context) {
              return BottomSheet(
                enableDrag: false,
                onClosing: () {},
                builder: (BuildContext context) {
                  return StatefulBuilder(
                    builder: (BuildContext context, setState) => SafeArea(
                      child: Container(
                        color: const Color.fromARGB(255, 13, 30, 46),
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
                              padding: const EdgeInsets.only(top: 8.0),
                              child: DropdownButtonFormField<String>(
                                borderRadius: BorderRadius.circular(10),
                                dropdownColor:
                                    const Color.fromARGB(255, 13, 30, 46),
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  labelText: "Satker",
                                  labelStyle:
                                      const TextStyle(color: Colors.white),
                                  hintStyle:
                                      const TextStyle(color: Colors.white),
                                  hintText: 'Pilih satker',
                                  focusColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                style: const TextStyle(
                                    color: Colors
                                        .white), // Set text color to white
                                items: listDataSatker.map(
                                  (item) {
                                    return DropdownMenuItem<String>(
                                      value: item['kodeSatker'].toString(),
                                      child: Text(
                                        item['namaSatker'].toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
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

                                  setState(
                                    () {
                                      dropdownValue = newValue!;
                                      dropdownName = listDataSatker[indexBidang]
                                              ['namaSatker']
                                          .toString();
                                    },
                                  );
                                  print(dropdownValue);

                                  print(dropdownName.toString());
                                },
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null) {
                                    return 'Pilih Satker Terlebih Dahulu!';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                searchData(dropdownValue, kodeProgram);
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20.0),
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                decoration: BoxDecoration(
                                  color: clrBadge,
                                  borderRadius: BorderRadius.circular(10),
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
        backgroundColor: clrBadge,
        child: const Icon(
          Icons.search,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildListInspektorat() {
    if (listDataLayer2.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var item = listDataLayer2[index];

              return GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => DetailListJdihPage(
                  //       accessToken: widget.accessToken,
                  //       tahun: widget.tahun,
                  //       kodeProgram:widget.kodeProgram,
                  //       kodeSatker:widget.kodeSatker,
                  //       kodeKegiatan:item['kode_kegiatan']??""
                  //     ),
                  //   ),
                  // );
                },
                child: Container(
                  margin: const EdgeInsets.all(5.0),
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(255, 34, 68, 87),
                        Color.fromARGB(255, 13, 30, 46),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(255, 23, 56, 82),
                        blurRadius: 1.0,
                        spreadRadius: 0.5,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                  child: ListTile(
                    dense: true,
                    contentPadding:
                        const EdgeInsets.only(left: 5.0, right: 5.0),
                    title: Text(
                      "Kode Kegiatan : ${item['kode_kegiatan'] ?? "-"}",
                      maxLines: 2,
                      // textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: clrEdit,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Deskripsi : ${item['deskripsi'] ?? "-"}",
                          // textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          "Total : ${item['total'] ?? "-"}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                        Text(
                          "Kode Program : ${item['kode_program'] ?? "-"}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios_sharp,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (_, index) => const SizedBox(
                  height: 1,
                ),
            itemCount: listDataLayer2.isEmpty ? 0 : listDataLayer2.length),
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
              child: const Text("Data tidak ditemukan", style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      );
    }
  }
}
