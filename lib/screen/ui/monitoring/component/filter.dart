import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../../src/api.dart';
import '../../../../src/constant.dart';
import '../../../../src/dialog_info.dart';
import '../../../../src/preference.dart';
import '../../../widget/custom_button_primary.dart';
import '../page.dart';

class FilterBidangPage extends StatefulWidget {
  const FilterBidangPage(BuildContext context, {super.key});

  @override
  State<FilterBidangPage> createState() => _FilterBidangPageState();
}

class _FilterBidangPageState extends State<FilterBidangPage> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  List listDataBidang = [];
  final fieldKeyword = TextEditingController();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
    getBidangList();
  }

  String dropdownValue = 'Dog';

  Future<void> getBidangList() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.bidangList;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isNotEmpty) {
            listDataBidang = (content['data']);
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

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(20),
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          builder: (
            BuildContext context,
          ) {
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
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Column(
                              children: [
                                Container(
                                  width: 50,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius:
                                        BorderRadiusDirectional.circular(10),
                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                DropdownButtonFormField(
                                  borderRadius: BorderRadius.circular(10),
                                  focusNode: _focusNodes[0],
                                  decoration: const InputDecoration(
                                    hoverColor: clrPrimary,
                                    labelText: 'Pilih Bidang',
                                    hintText: 'Pilih Nama Bidang',
                                    focusColor: clrPrimary,
                                    labelStyle: TextStyle(color: Colors.grey),
                                    focusedBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white24,
                                    border: InputBorder.none,
                                  ),
                                  items: listDataBidang.map(
                                    (item) {
                                      return DropdownMenuItem<String>(
                                        value: item['bidang_id'].toString(),
                                        child: Text(
                                            item['bidang_name'].toString()),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (String? newValue) {
                                    setState(
                                      () {
                                        dropdownValue = newValue!;
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Container(
                            alignment: Alignment.centerRight,
                            child: CustomButtonPrimary(
                              text: 'Cari Aset',
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MonitoringPage(
                                      idBidang: dropdownValue,
                                    ),
                                  ),
                                );
                              },
                            ),
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
      backgroundColor: clrBadge,
      child: const Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }
}
