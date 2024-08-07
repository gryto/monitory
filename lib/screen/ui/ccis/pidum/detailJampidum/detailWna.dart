import 'package:flutter/material.dart';
import '../../../../../src/constant.dart';
import '../../../../widget/room_widget.dart';
import '../../../chart/wna.dart';

class DetailWnaPage extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final totalWnaP;
  // ignore: prefer_typing_uninitialized_variables
  final totalWnaW;
  const DetailWnaPage({
    super.key,
    this.totalWnaP,
    this.totalWnaW,
  });

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
                    "assets/icons/LOGO_JAMPIDUM.png",
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
                    "WNA",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "JAMPIDUM",
                    style: TextStyle(color: clrDelete, fontSize: 12),
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
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Column(
                    children: [
                      SizedBox(
                        height: 80,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            RoomContainer(
                                onTap: () {},
                                title: "Tersangka Pria",
                                colorIcon: clrWait,
                                count: totalWnaP.toString()),
                            RoomContainer(
                                onTap: () {},
                                title: "Tersangka Wanita",
                                colorIcon: clrBadge,
                                count: totalWnaW.toString()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 10, right: 10),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(13),
                ),
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 20, left: 5, right: 5),
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
                    height: 250,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      'WNA',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      ' ( Periode - 2023 )',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.only(left: 8, top: 8),
                                  width: 350,
                                  height: 150,
                                  child: WnaChart(
                                    totalWnaP: totalWnaP,
                                    totalWnaW: totalWnaW,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                SizedBox(
                                  height: 20,
                                  width: 350,
                                  // width:  MediaQuery.of(context).size.width * 0.82,
                                  // height: MediaQuery.of(context).size.height * 0.02,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                color: clrWait),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Tersangka Pria",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                        ],
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 8,
                                            width: 8,
                                            decoration: const BoxDecoration(
                                                color: clrPrimary),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Text("Tersangka Wanita",
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
