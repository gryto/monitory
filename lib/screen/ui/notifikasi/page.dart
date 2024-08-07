import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loader.dart';
import '../../../src/preference.dart';
import 'component/list.dart';

class NotifikasiPage extends StatefulWidget {
  const NotifikasiPage({Key? key}) : super(key: key);

  @override
  State<NotifikasiPage> createState() => _NotifikasiPageState();
}

class _NotifikasiPageState extends State<NotifikasiPage> {
  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  List listData = [];
  List listData2 = [];
  List listData5 = [];
  List listDataUser1 = [];
  List listDataUser2 = [];
  String fullName = "";
  String typeUser = "";
  String id = "";
  String path = "";
  String userLevel = "";

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 10;

  final fieldKeyword = TextEditingController();
  String search = "";
  String userType = "";

  late FocusNode focusNode = FocusNode()
    ..addListener(() {
      setState(() {});
    });

  searchData(username) {
    setState(() {
      isProcess = true;

      search = username;

      offset = 0;
      listData = [];
      listData2 = [];
      listData5 = [];
      listDataUser1 = [];
      listDataUser2 = [];
    });

    getDataAdmin1(username, limit, offset);
    getDataAdmin2(username, limit, offset);
    getDataUser1(id, limit, offset);
    getDataAdmin5(username, limit, offset);
    getDataUser2(search, limit, offset, id);
    // getDataUser1(search, limit, offset);
  }

  getDataAdmin1(username, limit, offset) async {
    var accessToken = await sharedPref.getPref("access_token");

    try {
      var url = ApiService.notificationList;
      var uri = url;
      // print(uri);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      print("getDataAdmin1" + content.toString());

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = content['data'];
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
    }

    setState(() {
      isProcess = false;
    });
  }

  getDataAdmin2(username, limit, offset) async {
    var accessToken = await sharedPref.getPref("access_token");

    try {
      var url = ApiService.notificationList2;
      var uri = url;
      // print(uri);
      // final newURI = uri.replace(queryParameters: params);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      print("admin2" + content.toString());

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData2 = content['data'];
          } else {
            listData2.addAll(content['data'].toList());
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

  getDataAdmin5(username, limit, offset) async {
    var accessToken = await sharedPref.getPref("access_token");

    try {
      final params = {
        'username': username,
      };
      var url = Uri.parse(ApiService.notificationList5);
      var uri = url;
      final newURI = uri.replace(queryParameters: params);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(
        newURI,
        headers: {
          "Authorization": bearerToken.toString(),
        },
      );
      var content = json.decode(response.body);
      print("Admin5" + content.toString());

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData5 = content['data'];
          } else {
            listData5.addAll(content['data'].toList());
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

  getDataUser1(id, limit, offset) async {
    var accessToken = await sharedPref.getPref("access_token");
    var id = await sharedPref.getPref("id");

    try {
      var url = Uri.parse(ApiService.notificationListUser1);
      var uri = "$url/$id";
      // print(uri);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      print("User1" + content.toString());

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listDataUser1 = content['data'];
          } else {
            listDataUser1.addAll(content['data'].toList());
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

  getDataUser2(id, username, limit, offset) async {
    var accessToken = await sharedPref.getPref("access_token");
    var id = await sharedPref.getPref("id");

    try {
      var url = Uri.parse(ApiService.notificationListUser2);
      var uri = "$url/$id";
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listDataUser2 = content['data'];
          } else {
            listDataUser2.addAll(content['data'].toList());
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

  void checkSession() async {
    var userId = await sharedPref.getPref("id");
    var userFullname = await sharedPref.getPref("name");
    var userRole = await sharedPref.getPref("level");
    var userPath = await sharedPref.getPref("path");

    setState(() {
      fullName = userFullname;
      typeUser = userRole;
      id = userId;
      path = userPath;
    });

    getDataAdmin1(search, limit, offset);
    getDataAdmin2(search, limit, offset);
    getDataAdmin5(search, limit, offset);
    getDataUser1(id, limit, offset);
    getDataUser2(id, limit, offset, id);
  }

  @override
  void initState() {
    checkSession();

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset + 10;
        });

        getDataAdmin1(search, limit, offset);
        getDataAdmin2(search, limit, offset);
        _loadCounter();
        getDataUser1(id, limit, offset);
        getDataUser2(id, limit, offset, id);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _loadCounter() async {
    var userRole = await sharedPref.getPref("level");
    setState(() {
      userLevel = userRole;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Pemberitahuan",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: !isProcess
            ? NotifikasiList(
                data: listData,
                dataadmin: listData2,
                dataadmin5: listData5,
                userLevel: typeUser,
                datauser1: listDataUser1,
                datauser2: listDataUser2,
              )
            : Center(child: loaderDialog(context)),
      ),
    );
  }
}
