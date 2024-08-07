import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';

class DetailLpsePage extends StatelessWidget {
  const DetailLpsePage({super.key});

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
                    "LPSE",
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    "BIRO PERLENGKAPAN - JAMBIN",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: clrPink),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Tender",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pengadaan Barang",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Badan Usaha Non Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pekerjaan Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Lainnya",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Perorangan Non Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Badan Usaha Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Perorangan Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pekerjaan Konstruksi Terintegrasi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(5.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  border: Border.all(color: clrPink),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.only(left: 5.0, right: 5.0),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Non Tender",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Pengadaan Barang",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(height: 2),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "1. Nama Paket",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Pengadaan Pengoptimalan Perangkat Intelijen Pemantauan Serangan Siber dan Pusat Data Security Operation Center (SOC) TA. 2024",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HPS",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Rp. 64.994.450.000,00",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Akhir Pendaftaran",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "22 Januari 2024 23:59",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "2. Nama Paket",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Pengadaan Surveillance Car With Tactical Passive Monitoring",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HPS",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Rp. 299.995.560.000,00",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Akhir Pendaftaran",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "18 Januari 2024 23:59",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3. Nama Paket",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Pengadaan Penguatan Sistem Profiler Kejaksaan Republik Indonesia Tahun Anggaran 2024",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HPS",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Rp. 499.998.890.000,00",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Akhir Pendaftaran",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "15 Januari 2024 23:59",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "3. Nama Paket",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Pengadaan Sistem Survailans untuk Identifikasi dan Tangkap Buron",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HPS",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Rp. 149.998.951.606,00",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Akhir Pendaftaran",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "22 Januari 2024 23:59",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "5. Nama Paket",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Pengadaan Tahap II Peralatan Investigasi Analisis Strategis dan Identifikasi Target, Pengadaan Tahap II Peralatan Intelijen Identifikasi dan Penelusuran Data Target",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "HPS",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "Rp. 199.975.636.000,76",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Akhir Pendaftaran",
                                style: TextStyle(
                                    fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.w700),
                              ),
                              Text(
                                "12 Januari 2024 23:59",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Badan Usaha Non Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pekerjaan Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Lainnya",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Perorangan Non Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Badan Usaha Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Perorangan Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Jasa Konsultansi Perorangan Konstruksi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Pekerjaan Konstruksi Terintegrasi",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                              Text(
                                "0",
                                style: TextStyle(
                                    fontSize: 12, color: Colors.white),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
