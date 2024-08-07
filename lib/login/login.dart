// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../screen/ui/ccis/datun/map.dart';
import '../screen/ui/ccis/jambin/detail_jambin.dart';
import '../screen/ui/ccis/jamintel/detail_jamintel.dart';
import '../screen/ui/ccis/jampidmil/map.dart';
import '../screen/ui/ccis/jamwas/map.dart';
import '../screen/ui/ccis/page.dart';
import '../screen/ui/ccis/pidsus/map.dart';
import '../screen/ui/ccis/pidum/map.dart';
import '../screen/ui/main_home.dart';
import '../screen/widget/custom_button_primary.dart';
import '../src/api.dart';
import '../src/constant.dart';
import '../src/dialog_info.dart';
import '../src/preference.dart';
import '../src/toast.dart';
import 'background.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _token;
  bool _obscurePassword = true;
  final cntrlUsername = TextEditingController();
  final cntrlPassword = TextEditingController();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
  ];
  // String accessToken = "";
  String tahun = "2023";
  String tahun2 = "2022";
  String ccis_token = "";

  SharedPref sharedPref = SharedPref();
  String url = ApiService.setLogin;
  String message = "";
  bool isProcess = false;

  loginCheck(username, password) async {
    // setState(() {
    //   isProcess = true;
    // });

    try {
      var params = jsonEncode({
        "email": username.toString(),
        "password": password.toString(),
      });

      var response = await http.post(Uri.parse(ApiService.setLogin),
          headers: {"Content-Type": "application/json"}, body: params);
      var content = json.decode(response.body);
      print(response.toString());
      print(content.toString());

      if (content['status'] == true) {
        String userId = content['data']['id'].toString();
        String userBidang = content['data']['bidang_id'].toString();
        String userFullname = content['data']['name'].toString();
        String userEmail = content['data']['email'].toString();
        String userNip = content['data']['nip'].toString();
        String userPath = content['data']['path'].toString();
        String userRole = content['data']['user_level'].toString();
        String accessToken = content['session']['access_token'].toString();

        sharedPref.setPref("_token", _token);
        sharedPref.setPref("id", userId);
        sharedPref.setPref("user_bidang", userBidang);
        sharedPref.setPref("name", userFullname);
        sharedPref.setPref("email", userEmail);
        sharedPref.setPref("nip", userNip);
        sharedPref.setPref("path", userPath);
        sharedPref.setPref("level", userRole);
        sharedPref.setPref("access_token", accessToken);

        var paramss = jsonEncode({
          "username": "superadmin",
          "password": "P@ssw0rd#123",
        });

        //if (ccis_token == "") {
        var responses = await http.post(
            // Uri.parse("http://202.157.188.69:3000/v1/login"),
            Uri.parse("http://202.157.188.112:3000/v1/login"),
            headers: {"Content-Type": "application/json"},
            body: paramss);
        var contents = json.decode(responses.body);

        setState(() {
          if (content['status'] == 200) {
            ccis_token = contents['data']['session']['access_token'].toString();
          }
        });

        sharedPref.setPref("ccis_token", ccis_token.toString());

        tahun = "2023";
        tahun2 = "2022";

        if (userRole == "1") {
          goToApp(userId);
        } else if (userRole == "3") {
          goToApp(userId);
        } else if (userRole == "2") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => CcisPage(
                  role: userRole,
                  bidangId: userId,
                ),
              ),
              (Route<dynamic> route) => false);
        } else {
          if (userBidang == "9") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => CcisPage(
                    role: userRole,
                    bidangId: userId,
                  ),
                ),
                (Route<dynamic> route) => false);
          } else if (userBidang == "3") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      MapJamwas(accessToken: accessToken, tahun: tahun),
                ),
                (Route<dynamic> route) => false);
          } else if (userBidang == "5") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      DetailDatun(accessToken: accessToken, tahun: tahun),
                ),
                (Route<dynamic> route) => false);
          } else if (userBidang == "2") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPidsus(accessToken: accessToken, tahun: tahun),
                ),
                (Route<dynamic> route) => false);
          } else if (userBidang == "7") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      DetailPidum(accessToken: accessToken, tahun: tahun),
                ),
                (Route<dynamic> route) => false);
          } else if (userBidang == "1") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      DetailJambin(accessToken: accessToken, tahun: tahun),
                ),
                (Route<dynamic> route) => false);
          } else if (userBidang == "4") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>   MapJampidmil(
                              accessToken: accessToken, tahun: tahun2),
                ),
                (Route<dynamic> route) => false);
          } else if (userBidang == "6") {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) =>
                      DetailJamintel(accessToken: accessToken, tahun: tahun),
                ),
                (Route<dynamic> route) => false);
          } else {
            goToApp(userId);
          }
        }
      } else {
        onBasicAlertPressed(context, 'Error', content['message']);
        // toastShort(context, content['message']);
      }
    } catch (e) {
      onBasicAlertPressed(context, 'Error', e.toString());
      // toastShort(context, e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  goToApp(userId) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => MainHome(
            id: userId,
          ),
        ),
        (Route<dynamic> route) => false);
  }

  // getFcmToken() async {
  //   ccis_token = await sharedPref.getPref("ccis_token");

  //   String? token;
  //   if (defaultTargetPlatform == TargetPlatform.iOS) {
  //     token = await FirebaseMessaging.instance.getAPNSToken();
  //   } else {
  //     token = await FirebaseMessaging.instance.getToken();
  //   }

  //   _token = token.toString();
  //   print(_token);
  // }

  @override
  void initState() {
    super.initState();
    // getFcmToken();

    cntrlUsername.text = "";
    cntrlPassword.text = "";
    // cntrlUsername.text = "pimpinan@gmail.com";
    // cntrlPassword.text = "123456";

    for (var node in _focusNodes) {
      node.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 30,
                    height: 30,
                    child: Image(
                      image: AssetImage(
                        "assets/images/kejaksaan-logo.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "CASYS",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Text(
                "Command Center & Activity Monitoring System",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ),
      ),
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: size.height * 0.03),
            Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: const Text(
                    "Masuk",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: clrBehind,
                        fontSize: 24),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: clrShadow,
                          blurRadius: 1.0,
                          spreadRadius: 0.5,
                          offset: Offset(1, 1),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8),
                                child: TextFormField(
                                  focusNode: _focusNodes[0],
                                  controller: cntrlUsername,
                                  decoration: InputDecoration(
                                    hoverColor: clrPrimary,
                                    labelText: "Username",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    focusedBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    enabledBorder: const UnderlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(10),
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    prefixIcon: Icon(
                                      Icons.account_circle,
                                      color: _focusNodes[0].hasFocus
                                          ? clrPrimary
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                              const Divider(
                                height: 1,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8, right: 8, bottom: 8, top: 8),
                                child: TextFormField(
                                  focusNode: _focusNodes[1],
                                  controller: cntrlPassword,
                                  obscureText: _obscurePassword,
                                  decoration: InputDecoration(
                                    labelText: "Password",
                                    labelStyle:
                                        const TextStyle(color: Colors.grey),
                                    focusedBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    enabledBorder: const UnderlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10))),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color: _focusNodes[1].hasFocus
                                          ? clrPrimary
                                          : Colors.grey,
                                    ),
                                    filled: true,
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _obscurePassword = !_obscurePassword;
                                        });
                                      },
                                      child: Icon(
                                        _obscurePassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: clrPrimary,
                                      ),
                                    ),
                                    suffixStyle:
                                        const TextStyle(color: clrPrimary),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  alignment: Alignment.centerRight,
                  child: CustomButtonPrimary(
                    text: 'Masuk',
                    onTap: () {
                      loginCheck(
                        cntrlUsername.text,
                        cntrlPassword.text,
                      );
                    },
                  ),
                ),
                SizedBox(height: size.height * 0.03),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// // ignore_for_file: use_build_context_synchronously

// import 'dart:convert';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../screen/ui/ccis/datun/map.dart';
// import '../screen/ui/ccis/jambin/detail_jambin.dart';
// import '../screen/ui/ccis/jamintel/detail_jamintel.dart';
// import '../screen/ui/ccis/jampidmil/map.dart';
// import '../screen/ui/ccis/jamwas/map.dart';
// import '../screen/ui/ccis/page.dart';
// import '../screen/ui/ccis/pidsus/map.dart';
// import '../screen/ui/ccis/pidum/map.dart';
// import '../screen/ui/main_home.dart';
// import '../screen/widget/custom_button_primary.dart';
// import '../src/api.dart';
// import '../src/constant.dart';
// import '../src/preference.dart';
// import '../src/toast.dart';
// import 'background.dart';

// class LoginPage extends StatefulWidget {
//   const LoginPage({Key? key}) : super(key: key);

//   @override
//   State<LoginPage> createState() => _LoginPageState();
// }

// class _LoginPageState extends State<LoginPage> {
//   String? _token;
//   bool _obscurePassword = true;
//   final cntrlUsername = TextEditingController();
//   final cntrlPassword = TextEditingController();
//   final List<FocusNode> _focusNodes = [
//     FocusNode(),
//     FocusNode(),
//   ];
//   // String accessToken = "";
//   String tahun = "2023";
//   String tahun2 = "2022";
//   String ccis_token = "";

//   SharedPref sharedPref = SharedPref();
//   String url = ApiService.setLogin;
//   String message = "";
//   bool isProcess = false;

//   loginCheck(username, password) async {
//     setState(() {
//       isProcess = true;
//     });

//     try {
//       var params = jsonEncode({
//         "email": username.toString(),
//         "password": password.toString(),
//       });

//       var response = await http.post(Uri.parse(ApiService.setLogin),
//           headers: {"Content-Type": "application/json"}, body: params);
//       var content = json.decode(response.body);

//       if (content['status'] == true) {
//         String userId = content['data']['id'].toString();
//         String userBidang = content['data']['bidang_id'].toString();
//         String userFullname = content['data']['name'].toString();
//         String userEmail = content['data']['email'].toString();
//         String userNip = content['data']['nip'].toString();
//         String userPath = content['data']['path'].toString();
//         String userRole = content['data']['user_level'].toString();
//         String accessToken = content['session']['access_token'].toString();

//         sharedPref.setPref("_token", _token);
//         sharedPref.setPref("id", userId);
//         sharedPref.setPref("user_bidang", userBidang);
//         sharedPref.setPref("name", userFullname);
//         sharedPref.setPref("email", userEmail);
//         sharedPref.setPref("nip", userNip);
//         sharedPref.setPref("path", userPath);
//         sharedPref.setPref("level", userRole);
//         sharedPref.setPref("access_token", accessToken);

//         var paramss = jsonEncode({
//           "username": "superadmin",
//           "password": "P@ssw0rd#123",
//         });

//         //if (ccis_token == "") {
//         var responses = await http.post(
//             Uri.parse("http://202.157.188.69:3000/v1/login"),
//             headers: {"Content-Type": "application/json"},
//             body: paramss);
//         var contents = json.decode(responses.body);

//         setState(() {
//           if (content['status'] == 200) {
//             ccis_token = contents['data']['session']['access_token'];
//           }
//         });

//         sharedPref.setPref("ccis_token", ccis_token.toString());

//         tahun = "2023";
//         tahun2 = "2022";

//         if (userRole == "1") {
//           goToApp(userId);
//         } else if (userRole == "3") {
//           goToApp(userId);
//         } else if (userRole == "2") {
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(
//                 builder: (context) => CcisPage(
//                   role: userRole,
//                   bidangId: userId,
//                 ),
//               ),
//               (Route<dynamic> route) => false);
//         } else {
//           if (userBidang == "9") {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) => CcisPage(
//                     role: userRole,
//                     bidangId: userId,
//                   ),
//                 ),
//                 (Route<dynamic> route) => false);
//           } else if (userBidang == "3") {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       MapJamwas(accessToken: accessToken, tahun: tahun),
//                 ),
//                 (Route<dynamic> route) => false);
//           } else if (userBidang == "5") {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       DetailDatun(accessToken: accessToken, tahun: tahun),
//                 ),
//                 (Route<dynamic> route) => false);
//           } else if (userBidang == "2") {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       DetailPidsus(accessToken: accessToken, tahun: tahun),
//                 ),
//                 (Route<dynamic> route) => false);
//           } else if (userBidang == "7") {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       DetailPidum(accessToken: accessToken, tahun: tahun),
//                 ),
//                 (Route<dynamic> route) => false);
//           } else if (userBidang == "1") {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       DetailJambin(accessToken: accessToken, tahun: tahun),
//                 ),
//                 (Route<dynamic> route) => false);
//           } else if (userBidang == "4") {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) =>   MapJampidmil(
//                               accessToken: accessToken, tahun: tahun2),
//                 ),
//                 (Route<dynamic> route) => false);
//           } else if (userBidang == "6") {
//             Navigator.of(context).pushAndRemoveUntil(
//                 MaterialPageRoute(
//                   builder: (context) =>
//                       DetailJamintel(accessToken: accessToken, tahun: tahun),
//                 ),
//                 (Route<dynamic> route) => false);
//           } else {
//             goToApp(userId);
//           }
//         }
//       } else {
//         toastShort(context, content['message']);
//       }
//     } catch (e) {
//       toastShort(context, e.toString());
//     }

//     setState(() {
//       isProcess = false;
//     });
//   }

//   goToApp(userId) {
//     Navigator.of(context).pushAndRemoveUntil(
//         MaterialPageRoute(
//           builder: (context) => MainHome(
//             id: userId,
//           ),
//         ),
//         (Route<dynamic> route) => false);
//   }

//   getFcmToken() async {
//     ccis_token = await sharedPref.getPref("ccis_token");

//     String? token;
//     if (defaultTargetPlatform == TargetPlatform.iOS) {
//       token = await FirebaseMessaging.instance.getAPNSToken();
//     } else {
//       token = await FirebaseMessaging.instance.getToken();
//     }

//     _token = token.toString();
//     print(_token);
//   }

//   @override
//   void initState() {
//     super.initState();
//     getFcmToken();

//     // cntrlUsername.text = "";
//     // cntrlPassword.text = "";
//     // cntrlUsername.text = "pimpinan@gmail.com";
//     // cntrlPassword.text = "123456";

//     for (var node in _focusNodes) {
//       node.addListener(() {
//         setState(() {});
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: clrPrimary,
//         title: const Center(
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   SizedBox(
//                     width: 30,
//                     height: 30,
//                     child: Image(
//                       image: AssetImage(
//                         "assets/images/kejaksaan-logo.png",
//                       ),
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   SizedBox(
//                     width: 5,
//                   ),
//                   Text(
//                     "CASYS",
//                     style: TextStyle(
//                         color: Colors.white, fontWeight: FontWeight.w500),
//                   ),
//                 ],
//               ),
//               Text(
//                 "Command Center & Activity Monitoring System",
//                 style: TextStyle(color: Colors.white, fontSize: 14),
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: Background(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             SizedBox(height: size.height * 0.03),
//             Column(
//               children: <Widget>[
//                 Container(
//                   alignment: Alignment.centerLeft,
//                   padding: const EdgeInsets.symmetric(horizontal: 40),
//                   child: const Text(
//                     "Masuk",
//                     style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         color: clrBehind,
//                         fontSize: 24),
//                     textAlign: TextAlign.left,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                       boxShadow: const [
//                         BoxShadow(
//                           color: clrShadow,
//                           blurRadius: 1.0,
//                           spreadRadius: 0.5,
//                           offset: Offset(1, 1),
//                         ),
//                       ],
//                     ),
//                     child: Column(
//                       children: [
//                         Container(
//                           alignment: Alignment.center,
//                           child: Column(
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8),
//                                 child: TextFormField(
//                                   focusNode: _focusNodes[0],
//                                   controller: cntrlUsername,
//                                   decoration: InputDecoration(
//                                     hoverColor: clrPrimary,
//                                     labelText: "Username",
//                                     labelStyle:
//                                         const TextStyle(color: Colors.grey),
//                                     focusedBorder: const UnderlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(10),
//                                       ),
//                                     ),
//                                     enabledBorder: const UnderlineInputBorder(
//                                       borderSide: BorderSide.none,
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(10),
//                                       ),
//                                     ),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     border: InputBorder.none,
//                                     prefixIcon: Icon(
//                                       Icons.account_circle,
//                                       color: _focusNodes[0].hasFocus
//                                           ? clrPrimary
//                                           : Colors.grey,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const Divider(
//                                 height: 1,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.only(
//                                     left: 8, right: 8, bottom: 8, top: 8),
//                                 child: TextFormField(
//                                   focusNode: _focusNodes[1],
//                                   controller: cntrlPassword,
//                                   obscureText: _obscurePassword,
//                                   decoration: InputDecoration(
//                                     labelText: "Password",
//                                     labelStyle:
//                                         const TextStyle(color: Colors.grey),
//                                     focusedBorder: const UnderlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                     enabledBorder: const UnderlineInputBorder(
//                                         borderSide: BorderSide.none,
//                                         borderRadius: BorderRadius.all(
//                                             Radius.circular(10))),
//                                     prefixIcon: Icon(
//                                       Icons.lock,
//                                       color: _focusNodes[1].hasFocus
//                                           ? clrPrimary
//                                           : Colors.grey,
//                                     ),
//                                     filled: true,
//                                     fillColor: Colors.white,
//                                     border: InputBorder.none,
//                                     suffixIcon: GestureDetector(
//                                       onTap: () {
//                                         setState(() {
//                                           _obscurePassword = !_obscurePassword;
//                                         });
//                                       },
//                                       child: Icon(
//                                         _obscurePassword
//                                             ? Icons.visibility
//                                             : Icons.visibility_off,
//                                         color: clrPrimary,
//                                       ),
//                                     ),
//                                     suffixStyle:
//                                         const TextStyle(color: clrPrimary),
//                                   ),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.03),
//                 Container(
//                   alignment: Alignment.centerRight,
//                   child: CustomButtonPrimary(
//                     text: 'Masuk',
//                     onTap: () {
//                       loginCheck(
//                         cntrlUsername.text,
//                         cntrlPassword.text,
//                       );
//                     },
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.03),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
