import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import 'package:badges/badges.dart' as badges;

class DetailEpiutang4Page extends StatelessWidget {
  const DetailEpiutang4Page({super.key});

  @override
  Widget build(BuildContext context) {
   

  final List<Map<String, dynamic>> financialData = [
    {
      'title': 'KT. ACEH',
      'saldoAwal': 'Saldo Awal: Rp. 1.811.042',
      'mataUang' : 'IDR',
      'mutasiTambah': ['Perkara Baru: 0', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 60.000.000',
        'Koreksi(+): 0',
        'Menjalani Subsider: 461.705.299'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 87.764.558.305',
    },
    {
      'title': 'KT. SUMATERA UTARA',
      'saldoAwal': 'Rp. 2.938.556',
      'mataUang' : 'USD',
      'mutasiTambah': ['Perkara Baru: 0', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 0',
        'Koreksi(+): 0',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 2.938.556',
    },
    {
      'title': 'KT. SUMATERA UTARA',
      'saldoAwal': 'Saldo Awal: Rp. 681.988.695.617',
      'mataUang' : 'SDG',
      'mutasiTambah': ['Perkara Baru: 691.627.885', 'Koreksi(+): 27.590.000'],
      'mutasiKurang': [
        'Setor ke kas negara: 260.132.626',
        'Koreksi(+): 0',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 682.447.780.876',
    },
    {
      'title': 'KT. SUMATERA BARAT',
      'saldoAwal': 'Saldo Awal: Rp. 108.153.678.143',
      'mataUang' : 'IDR',
      'mutasiTambah': ['Perkara Baru: 0', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 0',
        'Koreksi(+): 0',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 108.153.678.143',
    },
    {
      'title': 'KT. RIAU',
      'saldoAwal': 'Saldo Awal: Rp. 432.111.950.148',
      'mataUang' : 'USD',
      'mutasiTambah': ['Perkara Baru: 0', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 0',
        'Koreksi(+): 0',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 432.111.950.148',
    },
    {
      'title': 'KT. JAMBI',
      'saldoAwal': 'Saldo Awal: Rp. 113.552.062.801',
      'mataUang' : 'SDG',
      'mutasiTambah': ['Perkara Baru: 0', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 0',
        'Koreksi(+): 0',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 113.552.062.801',
    },
    {
      'title': 'KT. SUMATERA SELATAN',
      'saldoAwal': 'Saldo Awal: Rp. 225.478.836.247,12',
      'mataUang' : 'IDR',
      'mutasiTambah': ['Perkara Baru: 375.052.000', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 153.000.000',
        'Koreksi(+): 0',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 225.478.836.247,12',
    },
    {
      'title': 'KT. BENGKULU',
      'saldoAwal': 'Saldo Awal: 59.698.159.165',
      'mataUang' : 'USD',
      'mutasiTambah': ['Perkara Baru: 0', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 105.500.000',
        'Koreksi(+): 0',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 59.698.159.165',
    },
    {
      'title': 'KT. LAMPUNG',
      'saldoAwal': 'Saldo Awal: 159.538.272.535',
      'mataUang' : 'SDG',
      'mutasiTambah': ['Perkara Baru: 2.455.345.433', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 229.515.232',
        'Koreksi(+): 42.500.000',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 161.721.602.736',
    },
    {
      'title': 'KT. DKI JAKARTA',
      'saldoAwal': 'Saldo Awal: 20.000',
      'mataUang' : 'IDR',
      'mutasiTambah': ['Perkara Baru: 0', 'Koreksi(+): 0'],
      'mutasiKurang': [
        'Setor ke kas negara: 0',
        'Koreksi(+): 0',
        'Menjalani Subsider: 0'
      ],
      'lainLain': 'Lain - lain: 0',
      'saldoAkhir': 'Saldo Akhir: 20.000',
    },
    // Add more items as needed
  ];

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
                  Text(
                    "Dashboard Piutang Perkara Pelanggaran Lalu Lintas",
                    style: TextStyle(color: clrEdit, fontSize: 10),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Rekap Piutang Tilang Periode Tahun 2024",
                    style: TextStyle(color: clrEdit, fontSize: 18),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 360,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: financialData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = financialData[index];

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 0),
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
                        height: 300,
                        width: 255,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          data['title'],
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),
                                    SizedBox(
                                      height: 280,
                                      width: 240,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            data['saldoAwal'],
                                            style: const TextStyle(
                                                color: Colors.white),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Row(
                                            children: [
                                              const Text("Mata Uang :",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              badges.Badge(
                                                badgeStyle: badges.BadgeStyle(
                                                  shape:
                                                      badges.BadgeShape.square,
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  badgeColor: clrWait,
                                                ),
                                                position:
                                                    badges.BadgePosition.custom(
                                                  start: 10,
                                                  top: 10,
                                                ),
                                                badgeContent: Text(
                                                  data['mataUang'],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text("Mutasi Tambah",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800)),
                                          for (String item
                                              in data['mutasiTambah'])
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          const Text("Mutasi Kurang",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w800)),
                                          for (String item
                                              in data['mutasiKurang'])
                                            Text(
                                              item,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          const SizedBox(
                                            height: 15,
                                          ),
                                          Text(data['lainLain'],
                                              style: const TextStyle(
                                                  color: Colors.white)),
                                          Text(
                                            data['saldoAkhir'],
                                            style: const TextStyle(
                                                color: Colors.white),
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
                    );
                  },
                ),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
          ],
        ),
      ),
    );
  }
}
