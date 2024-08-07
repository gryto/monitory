import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:monitoriy/src/constant.dart';
import '../../src/api.dart';
import '../../src/dialog_info.dart';
import '../../src/preference.dart';
import '../ui/dashboardActivity/cancelled.dart';
import '../ui/dashboardActivity/finished.dart';
import '../ui/dashboardActivity/onGoing.dart';
import '../ui/dashboardActivity/unapproved.dart';
import '../ui/dashboardActivity/waiting.dart';
import 'package:http/http.dart' as http;

class IntegrationSlider extends StatefulWidget {
  const IntegrationSlider({super.key});

  @override
  State<IntegrationSlider> createState() => _IntegrationSliderState();
  
}

class _IntegrationSliderState extends State<IntegrationSlider> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  String totalOnGoing    = "";
  String totalWaiting    = "";
  String totalFinished   = "";
  String totalCancelled  = "";
  String totalUnapproved = "";
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

    checkSession();

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset + 10;
        });

        onGoing();
        waiting();
        finished();
        cancelled();
        unapproved();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void checkSession() async {
    onGoing();
    waiting();
    finished();
    cancelled();
    unapproved();
  }

  Future<void> onGoing() async {

    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.onGoingActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        totalOnGoing = content['count'].toString();

        setState(() {
          totalOnGoing;
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

  Future<void> waiting() async {

    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.waitingActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        totalWaiting = content['count'].toString();

        setState(() {
          totalWaiting;
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

  Future<void> finished() async {

    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.finishedActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        totalFinished = content['count'].toString();

        setState(() {
          totalFinished;
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

  Future<void> cancelled() async {

    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.cancelledActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        totalCancelled = content['count'].toString();

        setState(() {
          totalCancelled;
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

  Future<void> unapproved() async {

    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.unapprovedActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        totalUnapproved = content['count'].toString();

        setState(() {
          totalUnapproved;
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

  Future<void> _pullRefresh() async {
    setState(() {
      onGoing();
    });
  }

  
  @override
  Widget build(BuildContext context) {
    List<Location> locations = [
      Location(
        address: "Sedang Berlangsung",
        color: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: [
            clrWait,
            Color.fromARGB(255, 199, 233, 255),
          ],
        ),
        state: "Total $totalOnGoing",
        imagePath: "assets/icons/task.png",
      ),
      Location(
        address: "Belum Berlangsung",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            clrEdit,
            Color.fromARGB(255, 255, 246, 199),
          ],
        ),
        state: "Total $totalWaiting",
        imagePath: "assets/icons/task.png",
      ),
      Location(
        address: "Selesai",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            clrBadge,
            Color.fromARGB(255, 199, 255, 234),
          ],
        ),
        state: "Total $totalFinished",
        imagePath: "assets/icons/task.png",
      ),
      Location(
        address: "Batal",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            clrDelete,
            Color.fromARGB(255, 255, 199, 199),
          ],
        ),
        state: "Total $totalCancelled",
        imagePath: "assets/icons/task.png",
      ),
      Location(
        address: "Belum Disetujui",
        color: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            clrTitle,
            Color.fromARGB(255, 213, 213, 213),
          ],
        ),
        state: "Total $totalUnapproved",
        imagePath: "assets/icons/task.png",
      ),
    ];
    return SizedBox(
      height: 90.0,
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const OnGoingPage(),
                  ),
                );
              } else if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const WaitingPage(),
                  ),
                );
              } else if (index == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const FinishedPage(),
                  ),
                );
              } else if (index == 3) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const CancelledPage(),
                  ),
                );
              } else if (index == 4) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const UnapprovedPage(),
                  ),
                );
              } else {
                onBasicAlertPressed(context, "500", "Menu belum dibuat");
              }
            },
            child: Container(
              width: 250.0,
              decoration: BoxDecoration(
                gradient: locations[index].color,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(169, 176, 185, 0.42),
                    spreadRadius: 0.5,
                    blurRadius: 8.0,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12.0,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned(
                    right: -5.0,
                    top: 0.0,
                    child: Opacity(
                      opacity: 0.7,
                      child: Image.asset(
                        locations[index].imagePath,
                        fit: BoxFit.cover,
                        scale: 1.5,
                      ),
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "${locations[index].address} \n",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            fontSize: 18.0,
                          ),
                        ),
                        TextSpan(
                          text: locations[index].state,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 15.0,
          );
        },
        itemCount: locations.length,
      ),
    );
    
  }
}

class Location {
  final String address;
  final String state;
  final Gradient color;
  final String imagePath;

  Location({
    required this.address,
    required this.color,
    required this.imagePath,
    required this.state,
  });
}
