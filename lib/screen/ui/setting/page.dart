import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loader.dart';
import '../../../src/logout.dart';
import '../../../src/preference.dart';
import '../../widget/custom_button.dart';
import '../main_home.dart';
import 'component/info.dart';
import 'package:sizer/sizer.dart';

class SettingLogic extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final id;
  const SettingLogic({Key? key, this.id}) : super(key: key);

  @override
  State<SettingLogic> createState() => _SettingLogicState();
}

class _SettingLogicState extends State<SettingLogic> {
  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  List listData = [];
  var formatter = DateFormat.yMMMMd('en_US');

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 10;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.infoUserProfile;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData.add(content['data'][0]);
          } else {
            listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
      // toastShort(context, e.toString());
    }

    setState(() {
      isProcess = true;
    });
  }

  String formatDate(String dateTimeString) {
    DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'");
    DateFormat outputFormat = DateFormat("dd-MM-yyyy");
    DateTime dateTime = inputFormat.parse(dateTimeString);
    String formattedDate = outputFormat.format(dateTime);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const MainHome(
                    id: "1",
                  ),
                ),
                (Route<dynamic> route) => false);
          },
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: clrPrimary,
        scrolledUnderElevation: 0,
        title: const Text("Pengaturan", style: TextStyle(color: Colors.white),),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: isProcess ? settingPage() : loaderDialog(context),
      ),
    );
  }

  Widget settingPage() {
    var mediaQueryHeight = MediaQuery.of(context).size.height;
    if (listData.isNotEmpty) {
      return ListView.separated(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          var row = listData[index] as Map;

          return Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: (mediaQueryHeight / 6) + 100,
                    decoration: const BoxDecoration(color: clrPrimary),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (context) => InfoUser(
                                todo: row,
                              ),
                            ),
                            (Route<dynamic> route) => false);
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              const Row(
                                children: [],
                              ),
                              SizedBox(
                                height: 11.0.h,
                                child: Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    CircleAvatar(
                                      // radius: 15,
                                      backgroundColor: Colors.white,
                                      child: CircleAvatar(
                                        radius: 5.h,
                                        backgroundImage: NetworkImage(
                                          row['path'] ?? "",
                                          scale: 10,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      right: 31.w,
                                      child: RawMaterialButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        InfoUser(
                                                      todo: row,
                                                    ),
                                                  ),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        elevation: 2.0,
                                        fillColor: clrEdit,
                                        padding: const EdgeInsets.all(5.0),
                                        shape: const CircleBorder(),
                                        child: const Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                row['name'] ?? "",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                row['role_level'] ?? "",
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.white,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.badge),
                title: const Text(
                  "NIP",
                  style: TextStyle(fontSize: 10, height: 1.8),
                ),
                subtitle: Text(
                  row['nip'] ?? "",
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.mail),
                title: const Text(
                  "Email",
                  style: TextStyle(fontSize: 10, height: 1.8),
                ),
                subtitle: Text(
                  row['email'] ?? "",
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.phone_android),
                title: const Text(
                  "No. Telepon",
                  style: TextStyle(fontSize: 10, height: 1.8),
                ),
                subtitle: Text(
                  row['nomor_hp'] ?? "",
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.branding_watermark),
                title: const Text(
                  "Nama Bidang",
                  style: TextStyle(fontSize: 10, height: 1.8),
                ),
                subtitle: Text(
                  row['bidang_name'] ?? "",
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.calendar_month),
                title: const Text(
                  "Tanggal Dibuat",
                  style: TextStyle(fontSize: 10, height: 1.8),
                ),
                subtitle: Text(
                  formatDate(row['created_at'] ?? ""),
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              const Divider(),
              ListTile(
                // String formattedDate = DateFormat.yMMMEd().
                leading: const Icon(Icons.calendar_month),
                title: const Text(
                  "Tanggal Diubah",
                  style: TextStyle(fontSize: 10, height: 1.8),
                ),
                subtitle: Text(
                  formatDate(row['updated_at'] ?? ""),
                  style: const TextStyle(fontSize: 14, height: 1.5),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              CustomButton(
                text: 'Keluar',
                onTap: () {
                  logoutDialog(context);
                },
              ),
              const SizedBox(
                height: 25,
              )
            ],
          );
        },
        separatorBuilder: (_, index) => const SizedBox(
          height: 5,
        ),
        itemCount: listData.isEmpty ? 0 : listData.length,
      );
    } else {
      return loaderDialog(context);
    }
  }
}
