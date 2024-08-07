import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/loader.dart';
import '../../../src/preference.dart';
import '../../widget/custom_button_primary.dart';
import 'component/list.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  SharedPref sharedPref = SharedPref();
  final _formKey = GlobalKey<FormState>();
  String message = "";
  bool isProcess = true;
  List listData = [];
  

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 10;

  final fieldKeyword = TextEditingController();
  String search = "";
  String userType = "";

  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

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
    });

    getData(username, limit, offset);
  }

  getData(username, limit, offset) async {
    var accessToken = await sharedPref.getPref("access_token");

    try {
      final params = {
        'username': username,
      };
      var url = Uri.parse(ApiService.logActivity);
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

  void checkSession() async {
    getData(search, limit, offset);
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

        getData(search, limit, offset);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    focusNode.dispose();
    super.dispose();
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
            Text("Log Aktivitas", style: TextStyle(color: Colors.white),),
          ],
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child:
            !isProcess ? ActivityList(data: listData) : loaderDialog(context),
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
                        padding: const EdgeInsets.all(5),
                        child: Column(
                          children: [
                            Column(
                              children: [
                                Icon(
                                  Icons.remove,
                                  color: Colors.grey[600],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        focusNode: _focusNodes[0],
                                        controller: fieldKeyword,
                                        maxLines: 1,
                                        decoration: InputDecoration(
                                          hoverColor: clrPrimary,
                                          labelText: 'Cari Username',
                                          hintText:
                                              'Masukkan username pencarian',
                                          focusColor: clrPrimary,
                                          labelStyle: const TextStyle(
                                              color: Colors.grey),
                                          focusedBorder:
                                              const UnderlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          enabledBorder:
                                              const UnderlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                            borderSide:
                                                BorderSide(color: Colors.grey),
                                          ),
                                          filled: true,
                                          fillColor: Colors.white24,
                                          border: InputBorder.none,
                                          prefixIcon: Icon(
                                            Icons.search,
                                            color: _focusNodes[0].hasFocus
                                                ? clrPrimary
                                                : Colors.grey,
                                          ),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Masukkan Username Terlebih Dahulu!';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(
                                        height: 10.0,
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        child: CustomButtonPrimary(
                                          text: 'Pencarian',
                                          onTap: () async {
                                            if (_formKey.currentState
                                                    ?.validate() ??
                                                false) {
                                              Navigator.pop(context);
                                              searchData(
                                                fieldKeyword.text,
                                              );
                                              print('Form is valid.');
                                            } else {
                                              print('Form is invalid.');
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
        child: const Icon(Icons.search, color: Colors.white,),
      ),
    );
  }
}
