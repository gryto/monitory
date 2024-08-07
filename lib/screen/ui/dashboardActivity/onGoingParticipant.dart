import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loading_fake.dart';
import '../../../src/preference.dart';

class OnGoingParticipantPage extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final idKegiatan;
  const OnGoingParticipantPage({Key? key, required this.idKegiatan})
      : super(key: key);

  @override
  State<OnGoingParticipantPage> createState() => _OnGoingParticipantPageState();
}

class _OnGoingParticipantPageState extends State<OnGoingParticipantPage> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  List listDataBidang = [];
  List listFilterDataBidang = [];
  List arrBidangId = [];
  String dropdownName = "";

  final fieldKeyword = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 2;
  var status = "";

  @override
  void initState() {
    // getBidangList();

    checkSession();

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset + 10;
        });

        informasiLayanan(limit, offset, status, widget.idKegiatan);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void checkSession() async {
    informasiLayanan(limit, offset, status, widget.idKegiatan);
  }

  Future<void> informasiLayanan(id, status, limit, offset) async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.participant;
      var uri = "$url/$id";
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = (content['data']);
          } else {
            //listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        // onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      informasiLayanan(limit, offset, status, widget.idKegiatan);
    });
  }

  String dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: clrPrimary,
        scrolledUnderElevation: 0,
        title: const Text(
          "Sedang Berlangsung Peserta",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: !isProcess
          ? RefreshIndicator(
              color: clrPrimary,
              onRefresh: () async {
                await Future.delayed(const Duration(milliseconds: 1500));
                setState(() {
                  isProcess = true;
                  listData.clear();
                  _pullRefresh();
                });
              },
              child: listAset())
          : const LoadingListPage(),
    );
  }

  Widget listAset() {
    if (listData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(left: 11, top: 5),
        child: ListView.separated(
          padding: const EdgeInsets.only(right: 5.0),
          primary: true,
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = listData[index];
            return ListTile(
              title: Text(row['nama_peserta']),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
            height: 5,
          ),
          itemCount: listData.isEmpty ? 0 : listData.length,
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.laptop_mac,
              size: 90.0,
              color: Colors.grey.shade400,
            ),
            Text(
              "Ooops, Belum Ada Peserta Yang Hadir!",
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.grey.shade400,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
    }
  }
}
