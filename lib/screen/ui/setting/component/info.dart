import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../../../src/api.dart';
import '../../../../src/constant.dart';
import '../../../../src/dialog_info.dart';
import '../../../../src/loader.dart';
import '../../../../src/preference.dart';
import '../../../widget/custom_button_primary.dart';
import '../page.dart';
import 'package:sizer/sizer.dart';

class InfoUser extends StatefulWidget {
  final Map? todo;
  const InfoUser({Key? key, required this.todo}) : super(key: key);

  @override
  State<InfoUser> createState() => _InfoUserState();
}

class _InfoUserState extends State<InfoUser> {
  SharedPref sharedPref = SharedPref();
  String accessToken = "";
  String message = "";
  bool isProcess = false;
  final cntrlId = TextEditingController();
  final cntrlUsername = TextEditingController();
  final cntrlUseremail = TextEditingController();
  final cntrlUsernip = TextEditingController();
  final cntrlUserphone = TextEditingController();
  final cntrlUserrole = TextEditingController();
  final cntrlUserphoto = TextEditingController();
  final cntrlUserbidang = TextEditingController();
  List listData = [];

  String id = "";
  String name = "";
  String email = "";
  String nip = "";
  String phone = "";
  String role = "";
  String userpath = "";

  @override
  void initState() {
    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }

    final todo = widget.todo;
    if (todo != null) {
      final id = todo['id'].toString();
      final name = todo['name'];
      final email = todo['email'];
      final nip = todo['nip'].toString();
      final phone = todo['nomor_hp'];
      final role = todo['role_level'].toString();
      final path = todo['path'].toString();
      final photo = todo['foto'].toString();
      final bidang = todo['bidang_name'].toString();
      userpath = path;
      cntrlId.text = id;
      cntrlUsername.text = name;
      cntrlUseremail.text = email;
      cntrlUsernip.text = nip;
      cntrlUserphone.text = phone;
      cntrlUserrole.text = role;
      cntrlUserphoto.text = photo;
      cntrlUserbidang.text = bidang;
    }
    super.initState();
  }

  Future<void> updateData() async {
    final todo = widget.todo;
    if (todo == null) {
      print("You can not call updated data");
      return;
    }

    final id = todo['id'];

    final name = cntrlUsername.text;
    final email = cntrlUseremail.text;
    final phone = cntrlUserphone.text;
    final photo = cntrlUserphoto.text;
    final body = {
      "id": id,
      "name": name,
      "email": email,
      "nomor_hp": phone,
      "foto": photo,
    };

    var url = ApiService.infoUserProfileUpdate;
    var accessToken = await sharedPref.getPref("access_token");
    var bearerToken = 'Bearer $accessToken';
    var response = await http.post(Uri.parse(url),
        headers: {
          "Content-Type": "application/json",
          "Authorization": bearerToken.toString()
        },
        body: jsonEncode(body));

    if (response.statusCode == 200) {
      setState(
        () {
          cntrlUsername.text = name;
          cntrlUseremail.text = email;
          cntrlUserphone.text = phone;

          sharedPref.setPref("name", name);
        },
      );
      // ignore: use_build_context_synchronously
      _onAlertButtonPressed(context, true, "Data Berhasil Diperbaharui");
    } else {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  _onAlertButtonPressed(context, status, message) {
    Alert(
      context: context,
      type: !status ? AlertType.error : AlertType.success,
      title: "",
      desc: message,
      buttons: [
        DialogButton(
          color: clrBadge,
          onPressed: () => Navigator.pop(context),
          width: 120,
          child: const Text(
            "OK",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        )
      ],
    ).show();
  }

  void moveToSecondPage() async {
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => const SettingLogic(),
        ),
        (Route<dynamic> route) => false);
  }

  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;
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
                  builder: (context) => const SettingLogic(),
                ),
                (Route<dynamic> route) => false);
          },
          child: const Icon(Icons.arrow_back),
        ),
        backgroundColor: clrPrimary,
        title: const Text(
          "Detail Profile",
          style: TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                decoration: const BoxDecoration(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        const SizedBox(height: 50),
                        SizedBox(
                          height: 11.5.h,
                          child: Stack(
                            clipBehavior: Clip.none,
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundColor: clrPrimary,
                                child: CircleAvatar(
                                  radius: 5.h,
                                  backgroundImage: NetworkImage(
                                    userpath,
                                    scale: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    TextFormField(
                      focusNode: _focusNodes[1],
                      controller: cntrlUsername,
                      decoration: InputDecoration(
                        hoverColor: clrPrimary,
                        labelText: "Satuan Kerja",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusColor: clrPrimary,
                        focusedBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.account_circle,
                          color: _focusNodes[1].hasFocus
                              ? clrPrimary
                              : Colors.grey,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: _focusNodes[1].hasFocus
                              ? clrPrimary
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    TextFormField(
                      focusNode: _focusNodes[2],
                      controller: cntrlUseremail,
                      decoration: InputDecoration(
                        hoverColor: clrPrimary,
                        labelText: "Email",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.mail,
                          color: _focusNodes[2].hasFocus
                              ? clrPrimary
                              : Colors.grey,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: _focusNodes[2].hasFocus
                              ? clrPrimary
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      focusNode: _focusNodes[3],
                      controller: cntrlUsernip,
                      decoration: InputDecoration(
                        hoverColor: clrPrimary,
                        labelText: "NIP",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.badge,
                          color: _focusNodes[3].hasFocus
                              ? clrPrimary
                              : Colors.grey,
                        ),
                      ),
                    ),
                    TextFormField(
                      focusNode: _focusNodes[4],
                      controller: cntrlUserphone,
                      decoration: InputDecoration(
                        hoverColor: clrPrimary,
                        labelText: "No. Telp",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.phone,
                          color: _focusNodes[4].hasFocus
                              ? clrPrimary
                              : Colors.grey,
                        ),
                        suffixIcon: Icon(
                          Icons.edit,
                          color: _focusNodes[4].hasFocus
                              ? clrPrimary
                              : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      focusNode: _focusNodes[5],
                      controller: cntrlUserrole,
                      decoration: InputDecoration(
                        hoverColor: clrPrimary,
                        labelText: "Level",
                        labelStyle: const TextStyle(color: Colors.grey),
                        focusedBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        enabledBorder: const UnderlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.verified_user,
                          color: _focusNodes[5].hasFocus
                              ? clrPrimary
                              : Colors.grey,
                        ),
                      ),
                    ),
                    TextFormField(
                      enabled: false,
                      controller: cntrlUserbidang,
                      decoration: const InputDecoration(
                        hoverColor: clrPrimary,
                        labelText: "Level",
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
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.branding_watermark,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    !isProcess
                        ? CustomButtonPrimary(
                            text: "Ubah",
                            onTap: () {
                              updateData();
                            },
                          )
                        : loaderDialog(context),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
