import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import '../../../../../../src/dialog_info.dart';
import 'detailEpiutang2.dart';
import 'detailEpiutang3.dart';
import 'detailEpiutang4.dart';
import 'detailEpiutang5.dart';
import 'detailEpiutang6.dart';

class DetailEpiutangPage extends StatelessWidget {
  const DetailEpiutangPage({super.key});

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
                    "E-PIUTANG",
                    style: TextStyle(color: Colors.white),
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
      body: biroKeuangan()
    );
  }

  Widget biroKeuangan() {
    List<Piutang> locations = [
      Piutang(
        address: "Pidana Khusus",
        color: clrPink,
        state: "Piutang yang berasal dari Uang Pengganti Perkara Tindak Pidana Korupsi yang diputus berdasarkan UU No. 31/1999",
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18,),
      ),
      Piutang(
        address: "Perdata dan TUN",
        color: clrEdit,
        state: "Piutang yang berasal dari Uang Pengganti Perkara Tindak Pidana Korupsi yang diputus berdasarkan UU No. 3/1971",
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18, ),
      ),
      Piutang(
        address: "Denda Tilang",
        color: clrPink,
        state: "Piutang yang berasal dari Denda dan Biaya Perkara Tilang. Terintegrasi dengan aplikasi E-tilang Kejaksaan",
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18, ),
      ),
      Piutang(
        address: "TP-TGR",
        color: clrPrimary,
        state: "Piutang yang berasal dari Tuntutan Perbendaharaan dan Tuntutan Ganti Rugi",
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18, ),
      ),
      Piutang(
        address: "Sewa BMN",
        color: clrBadge,
        state: "Piutang yang berasal dari sewa Barang Milik Negara",
        icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 18, ),
      ),
    ];

    return SizedBox(
      child: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(10),
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailEpiutang2Page(
                    ),
                  ),
                );
              } else if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailEpiutang3Page(
                    ),
                  ),
                );
              } else if (index == 2) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailEpiutang4Page(
                    ),
                  ),
                );
              } else if (index == 3) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailEpiutang5Page(
                    ),
                  ),
                );
              } else if (index == 4) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const DetailEpiutang6Page(
                    ),
                  ),
                );
              } else {
                onBasicAlertPressed(context, "500", "Menu belum dibuat");
              }
            },
            child: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Container(
                width: 250.0,
                decoration: BoxDecoration(
                  color: locations[index].color,
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromRGBO(46, 52, 61, 0.42),
                      spreadRadius: 0.5,
                      blurRadius: 8.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(15),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      right: -7.0,
                      top: 20.0,
                      child: Opacity(
                        opacity: 0.7,
                        child: locations[index].icon,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5),
                      child: RichText(
                        maxLines: 4,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "${locations[index].address} \n",
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                height: 1.5,
                                fontSize: 18.0,
                              ),
                            ),
                            TextSpan(
                              text: locations[index].state,
                              style: const TextStyle(
                                fontSize: 16.0,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

class Piutang {
  final String address;
  final String state;
  final Color color;
  final Icon icon;

  Piutang({
    required this.address,
    required this.color,
    required this.icon,
    required this.state,
  });
}
