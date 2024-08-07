import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../../../../../../src/constant.dart';
import 'package:badges/badges.dart' as badges;

class DetailEpnbpPage extends StatelessWidget {
  const DetailEpnbpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> financialData = [
      {
        'title': 'KEJAKSAAN AGUNG',
        'saldoAwal': 'Saldo Awal: 0',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 0',
      },
      {
        'title': 'KEJAKSAAN AGUNG',
        'saldoAwal': 'Saldo Awal: 2.184.700',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 2.184.700',
      },
      {
        'title': 'KEJAKSAAN AGUNG',
        'saldoAwal': 'Saldo Awal: 5.334.670.442.252,25',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 5.334.670.442.252,25',
      },
      {
        'title': 'KEJAKSAAN AGUNG',
        'saldoAwal': 'Saldo Awal: 0',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 0',
      },
      {
        'title': 'KT. ACEH',
        'saldoAwal': 'Saldo Awal: 16.711.431.537,779999',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 16.711.431.537,779999',
      },
      {
        'title': 'KT. SUMATERA UTARA',
        'saldoAwal': 'Saldo Awal: 8.153.862.073,030001',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 1'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 8.153.862.073,030001',
      },
      {
        'title': 'KT. SUMATERA BARAT',
        'saldoAwal': 'Saldo Awal: 8.153.862.073,030001',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 1'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 8.153.862.073,030001',
      },
      {
        'title': 'KT. RIAU',
        'saldoAwal': 'Saldo Awal: 41.069.981.458,02',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 41.069.981.458,02',
      },
      {
        'title': 'KT. JAMBI',
        'saldoAwal': 'Saldo Awal: 25.946.722.345,019997',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 25.946.722.345,019997',
      },
      {
        'title': 'KT. SUMATERA SELATAN',
        'saldoAwal': 'Saldo Awal: 11.472.382.167,7',
        'mataUang': 'IDR',
        'debet': [
          'Setor Kas Negara: 153.000.000',
          'Dikembalikan kepada yg berhak: 0'
        ],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 11.319.382.167,7',
      },
      // Add more items as needed
    ];

    final List<Map<String, dynamic>> financialData2 = [
      {
        'title': 'KT. BENGKULU',
        'saldoAwal': 'Saldo Awal: 1.262.440.773,5699997',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 1.262.440.773,5699997',
      },
      {
        'title': 'KT. LAMPUNG',
        'saldoAwal': 'Saldo Awal: 57.848.311.698,45',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 57.848.311.698,45',
      },
      {
        'title': 'KT. DKI JAKARTA (SGD)',
        'saldoAwal': 'Saldo Awal: 45.722,05',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 45.722,05',
      },
      {
        'title': 'KT. DKI JAKARTA (USD)',
        'saldoAwal': 'Saldo Awal: 13.174.705',
        'mataUang': 'USD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 13.174.705',
      },
      {
        'title': 'KT. DKI JAKARTA (EUR)',
        'saldoAwal': 'Saldo Awal: 0',
        'mataUang': 'EUR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 0',
      },
      {
        'title': 'KT. DKI JAKARTA (IDR)',
        'saldoAwal': 'Saldo Awal: 1.098.400.553.890,4902',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 1.098.400.553.890,4902',
      },
      {
        'title': 'KT. JAWA BARAT (IDR)',
        'saldoAwal': 'Saldo Awal: 231.143.518.482,77',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 231.143.518.482,77',
      },
      {
        'title': 'KT. JAWA BARAT (USD)',
        'saldoAwal': 'Saldo Awal: 545.972,42',
        'mataUang': 'USD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 545.972,42',
      },
      {
        'title': 'KT. JAWA TENGAH',
        'saldoAwal': 'Saldo Awal: 20.023.439.329,96',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 20.023.439.329,96',
      },
      {
        'title': 'KT. D.I YOGYAKARTA',
        'saldoAwal': 'Saldo Awal: 181.000',
        'mataUang': 'JPY',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 181.000',
      },
      // Add more items as needed
    ];

    final List<Map<String, dynamic>> financialData3 = [
      {
        'title': 'KT. D.I YOGYAKARTA SGD',
        'saldoAwal': 'Saldo Awal: 0',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 0',
      },
      {
        'title': 'KT. D.I YOGYAKARTA IDR',
        'saldoAwal': 'Saldo Awal: 19.187.418.367,14',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 19.187.418.367,14',
      },
      {
        'title': 'KT. D.I YOGYAKARTA USD',
        'saldoAwal': 'Saldo Awal: 1.520',
        'mataUang': 'USD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 1.520',
      },
      {
        'title': 'KT. D.I YOGYAKARTA CNY',
        'saldoAwal': 'Saldo Awal: 600',
        'mataUang': 'CNY',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 600',
      },
      {
        'title': 'KT. D.I YOGYAKARTA EUR',
        'saldoAwal': 'Saldo Awal: 4.645',
        'mataUang': 'EUR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 4.645',
      },
      {
        'title': 'KT. D.I YOGYAKARTA HKD',
        'saldoAwal': 'Saldo Awal: 7.320',
        'mataUang': 'HKD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 7.320',
      },
      {
        'title': 'KT. JAWA TIMUR SGD',
        'saldoAwal': 'Saldo Awal: 22.000',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 22.000',
      },
      {
        'title': 'KT. JAWA TIMUR USD',
        'saldoAwal': 'Saldo Awal: 10.993',
        'mataUang': 'USD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 10.993',
      },
      {
        'title': 'KT. JAWA TIMUR IDR',
        'saldoAwal': 'Saldo Awal: 60.009.076.087,22',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 60.009.076.087,22',
      },
      {
        'title': 'KT. KALIMANTAN BARAT',
        'saldoAwal': 'Saldo Awal: 9.650.227.372,99',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 9.650.227.372,99',
      },
      // Add more items as needed
    ];

    final List<Map<String, dynamic>> financialData4 = [
      {
        'title': 'KT. KALIMANTAN TENGAH',
        'saldoAwal': 'Saldo Awal: 23.452.037.282',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 23.452.037.282',
      },
      {
        'title': 'KT. KALIMANTAN SELATAN',
        'saldoAwal': 'Saldo Awal: 12.063.600.872,57',
        'mataUang': 'IDR',
        'debet': [
          'Setor Kas Negara: 0',
          'Dikembalikan kepada yg berhak: 73.000.000'
        ],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 12.063.600.872,57',
      },
      {
        'title': 'KT. KALIMANTAN TIMUR',
        'saldoAwal': 'Saldo Awal: 22.243.221.077,1',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 22.243.221.077,1',
      },
      {
        'title': 'KT. SULAWESI UTARA',
        'saldoAwal': 'Saldo Awal: 1.517.997.752,1899996',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 1.517.997.752,1899996',
      },
      {
        'title': 'KT. SULAWESI TENGAH',
        'saldoAwal': 'Saldo Awal: 7.510.332.673,809999',
        'mataUang': 'IDR',
        'debet': [
          'Setor Kas Negara: 5.875.000',
          'Dikembalikan kepada yg berhak: 300.000.000'
        ],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 7.510.332.673,809999',
      },
      {
        'title': 'KT. SULAWESI TENGGARA SGD',
        'saldoAwal': 'Saldo Awal: 1.363.000',
        'mataUang': 'SGD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 1.363.000',
      },
      {
        'title': 'KT. SULAWESI TENGGARA USD',
        'saldoAwal': 'Saldo Awal: 283.700',
        'mataUang': 'USD',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 283.700',
      },
      {
        'title': 'KT. SULAWESI SELATAN',
        'saldoAwal': 'Saldo Awal: 24.565.893.599,260002',
        'mataUang': 'IDR',
        'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 24.565.893.599,260002',
      },
      {
        'title': 'KT. BALI',
        'saldoAwal': 'Saldo Awal: 12.154.370.789,46',
        'mataUang': 'IDR',
        'debet': [
          'Setor Kas Negara: 0',
          'Dikembalikan kepada yg berhak: 22.292.000'
        ],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 12.154.370.789,46',
      },
      {
        'title': 'KT. BALI',
        'saldoAwal': 'Saldo Awal: 12.154.370.789,46',
        'mataUang': 'IDR',
        'debet': [
          'Setor Kas Negara: 0',
          'Dikembalikan kepada yg berhak: 22.292.000'
        ],
        'kredit': ['Mutasi Tambah: 0'],
        'saldoAkhir': 'Saldo Akhir: 12.154.370.789,46',
      },
      // Add more items as needed
    ];

    List<Map<String, dynamic>> financialData5 = [
  {
    'title': 'KT. NUSA TENGGARA BARAT',
    'saldoAwal': 'Saldo Awal: 2.015.461.446',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 2.015.461.446',
  },
  {
    'title': 'KT. NUSA TENGGARA TIMUR',
    'saldoAwal': 'Saldo Awal: 3.672107.807',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 3.672107.807',
  },
  {
    'title': 'KT. MALUKU',
    'saldoAwal': 'Saldo Awal: 2.417.942.443,0200005',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 2.417.942.443,0200005',
  },
  {
    'title': 'KT. PAPUA',
    'saldoAwal': 'Saldo Awal: 46.974.388.908,88',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 46.974.388.908,88',
  },
  {
    'title': 'KT. MALUKU UTARA',
    'saldoAwal': 'Saldo Awal: 863.707.898,1599998',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 863.707.898,1599998',
  },
  {
    'title': 'KT. BANTEN',
    'saldoAwal': 'Saldo Awal: 78.508.562.493,96',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 78.508.562.493,96',
  },
  {
    'title': 'KT. BANTEN',
    'saldoAwal': 'Saldo Awal: 0,29',
    'mataUang': 'CNY',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 0,29',
  },
  {
    'title': 'KT. BANTEN',
    'saldoAwal': 'Saldo Awal: 0',
    'mataUang': 'AUD',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 0',
  },
  {
    'title': 'KT. BANTEN',
    'saldoAwal': 'Saldo Awal: 0',
    'mataUang': 'HKD',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 0',
  },
  {
    'title': 'KT. BANTEN',
    'saldoAwal': 'Saldo Awal: 0',
    'mataUang': 'JPY',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 0',
  },
  {
    'title': 'KT. BANTEN',
    'saldoAwal': 'Saldo Awal: 5.023,8',
    'mataUang': 'SGD',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 5.023,8',
  },
  {
    'title': 'KT. BANTEN',
    'saldoAwal': 'Saldo Awal: 59.390,42',
    'mataUang': 'USD',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 59.390,42',
  },
  {
    'title': 'KT. BANGKA BELITUNG',
    'saldoAwal': 'Saldo Awal: 5.015.891.217,96',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 5.015.891.217,96',
  },
  {
    'title': 'KT. GORONTALO',
    'saldoAwal': 'Saldo Awal: 3.698.076.226,3500004',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 3.698.076.226,3500004',
  },
  {
    'title': 'KT. KEPULAUAN RIAU',
    'saldoAwal': 'Saldo Awal: 5.652.350.569,23',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 5.652.350.569,23',
  },
  {
    'title': 'KT. SULAWESI BARAT',
    'saldoAwal': 'Saldo Awal: 8.945.859.356,33',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 8.945.859.356,33',
  },
  {
    'title': 'KT. PAPUA BARAT',
    'saldoAwal': 'Saldo Awal: 3.039.546.581',
    'mataUang': 'IDR',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 3.039.546.581',
  },
  {
    'title': 'KT. PAPUA BARAT',
    'saldoAwal': 'Saldo Awal: 0',
    'mataUang': 'USD',
    'debet': ['Setor Kas Negara: 0', 'Dikembalikan kepada yg berhak: 0'],
    'kredit': ['Mutasi Tambah: 0'],
    'saldoAkhir': 'Saldo Akhir: 0',
  },
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
                    "e-RPL",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                padding: const EdgeInsets.only(
                    top: 20, bottom: 20, left: 0, right: 5),
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
                height: MediaQuery.of(context).size.width * 0.68,
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
                            const SizedBox(
                              height: 34,
                              width: 350,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Periode Tahun 2024',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              padding: const EdgeInsets.only(top: 0, left: 0),
                              width: MediaQuery.of(context).size.width * 0.90,
                              height: MediaQuery.of(context).size.height * 0.2,
                              child: BarChart(
                                BarChartData(
                                  barTouchData: barTouchData,
                                  titlesData: titlesData,
                                  borderData: borderData,
                                  barGroups: barGroups,
                                  gridData: FlGridData(show: true),
                                  alignment: BarChartAlignment.spaceAround,
                                  maxY: 300000000,
                                ),
                              ),
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
                                        decoration:
                                            const BoxDecoration(color: clrWait),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Saldo Awal",
                                          style:
                                              TextStyle(color: Colors.white)),
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
                                        decoration:
                                            const BoxDecoration(color: clrPink),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("Saldo Akhir",
                                          style:
                                              TextStyle(color: Colors.white)),
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
                          "Saldo Awal",
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
                              "IDR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "7.282.134.416.918",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "USD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "16.260.981",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SGD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "1.435.746",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "JPY",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "181.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "HKD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "7.320",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Debet",
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
                              "IDR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "458.875.001",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "USD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SGD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "JPY",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "HKD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Kredit",
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
                              "IDR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "95.292.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "USD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SGD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "JPY",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "HKD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "0",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Saldo Akhir",
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
                              "IDR",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "7.281.770.833.917",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "USD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "16.260.981",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "SGD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "1.435.746",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "JPY",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "181.000",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "HKD",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                            Text(
                              "7.320",
                              style:
                                  TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: financialData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = financialData[index];

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
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
                        // height: 300,
                        // width: 255,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      data['title'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(data['saldoAwal'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Mata Uang :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        badges.Badge(
                                                          badgeStyle: badges
                                                              .BadgeStyle(
                                                            shape: badges
                                                                .BadgeShape
                                                                .square,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            badgeColor:
                                                                clrWait,
                                                          ),
                                                          position: badges
                                                                  .BadgePosition
                                                              .custom(
                                                                  start: 10,
                                                                  top: 10),
                                                          badgeContent: Text(
                                                            data['mataUang'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Debet",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['debet'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Kredit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['kredit'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    Text(data['saldoAkhir'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: financialData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = financialData2[index];

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
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
                        // height: 300,
                        // width: 255,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      data['title'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(data['saldoAwal'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Mata Uang :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        badges.Badge(
                                                          badgeStyle: badges
                                                              .BadgeStyle(
                                                            shape: badges
                                                                .BadgeShape
                                                                .square,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            badgeColor:
                                                                clrWait,
                                                          ),
                                                          position: badges
                                                                  .BadgePosition
                                                              .custom(
                                                                  start: 10,
                                                                  top: 10),
                                                          badgeContent: Text(
                                                            data['mataUang'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Debet",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['debet'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Kredit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['kredit'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    Text(data['saldoAkhir'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: financialData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = financialData3[index];

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
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
                        // height: 300,
                        // width: 255,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      data['title'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(data['saldoAwal'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Mata Uang :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        badges.Badge(
                                                          badgeStyle: badges
                                                              .BadgeStyle(
                                                            shape: badges
                                                                .BadgeShape
                                                                .square,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            badgeColor:
                                                                clrWait,
                                                          ),
                                                          position: badges
                                                                  .BadgePosition
                                                              .custom(
                                                                  start: 10,
                                                                  top: 10),
                                                          badgeContent: Text(
                                                            data['mataUang'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Debet",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['debet'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Kredit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['kredit'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    Text(data['saldoAkhir'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: financialData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = financialData4[index];

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
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
                        // height: 300,
                        // width: 255,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      data['title'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(data['saldoAwal'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Mata Uang :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        badges.Badge(
                                                          badgeStyle: badges
                                                              .BadgeStyle(
                                                            shape: badges
                                                                .BadgeShape
                                                                .square,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            badgeColor:
                                                                clrWait,
                                                          ),
                                                          position: badges
                                                                  .BadgePosition
                                                              .custom(
                                                                  start: 10,
                                                                  top: 10),
                                                          badgeContent: Text(
                                                            data['mataUang'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Debet",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['debet'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Kredit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['kredit'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    Text(data['saldoAkhir'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
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
            Padding(
              padding: const EdgeInsets.all(10),
              child: SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: financialData.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data = financialData5[index];

                    return Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                        padding: const EdgeInsets.only(
                            top: 15, bottom: 15, left: 15, right: 15),
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
                        // height: 300,
                        // width: 255,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      data['title'],
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                  children: [
                                                    Text(data['saldoAwal'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      children: [
                                                        const Text(
                                                            "Mata Uang :",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        const SizedBox(
                                                          width: 5,
                                                        ),
                                                        badges.Badge(
                                                          badgeStyle: badges
                                                              .BadgeStyle(
                                                            shape: badges
                                                                .BadgeShape
                                                                .square,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            badgeColor:
                                                                clrWait,
                                                          ),
                                                          position: badges
                                                                  .BadgePosition
                                                              .custom(
                                                                  start: 10,
                                                                  top: 10),
                                                          badgeContent: Text(
                                                            data['mataUang'],
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Debet",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['debet'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    const SizedBox(
                                                      height: 15,
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    const Text("Kredit",
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w800)),
                                                    for (String item
                                                        in data['kredit'])
                                                      Text(
                                                        item,
                                                        style:
                                                            const TextStyle(
                                                          color: Colors.white,
                                                        ),
                                                      ),
                                                    Text(data['saldoAkhir'],
                                                        style:
                                                            const TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                  ],
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
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
          ],
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
        touchTooltipData: BarTouchTooltipData(
          tooltipBgColor: Colors.transparent,
          tooltipPadding: EdgeInsets.zero,
          tooltipMargin: 1,
          getTooltipItem: (
            BarChartGroupData group,
            int groupIndex,
            BarChartRodData rod,
            int rodIndex,
          ) {
            return BarTooltipItem(
              rod.toY.round().toString(),
              const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            );
          },
        ),
      );

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 20,
            getTitlesWidget: bottomTitles,
            // getTitlesWidget: bottomtitles,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              interval: 100000000,
              getTitlesWidget: leftTitleWidgets),
        ),
        topTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  Widget bottomTitles(double value, TitleMeta meta) {
    final titles = <String>[
      'KT.ACEH',
      'KT.SUMATERA UTARA',
      'KT.SUMATERA BARAT',
      'KT. RIAU',
      'KT. JAMBI',
      'KT. SUMATERA SELATAN',
      'KT. BENGKULU',
      'KT. LAMPUNG',
      'KT. DKI JAKARTA',
      'KT. JAWA BARAT',
      'KT. JAWA TENGAH',
      'KT. D.I YOGYAKARTA',
      'KT.ACEH',
      'KT.SUMATERA UTARA',
      'KT.SUMATERA BARAT',
      'KT. RIAU',
      'KT. JAMBI',
      'KT. SUMATERA SELATAN',
      'KT. BENGKULU',
      'KT. LAMPUNG',
      'KT. DKI JAKARTA',
      'KT. JAWA BARAT',
      'KT. JAWA TENGAH',
      'KT. D.I YOGYAKARTA'
    ];

    final Widget text = SizedBox(
      height: 20,
      width: 20,
      child: Text(
        titles[value.toInt()],
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 4,
        ),
      ),
    );

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 5,
      child: text,
    );
  }

  Widget bottomtitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.black,
      fontWeight: FontWeight.bold,
      fontSize: 5,
    );

    String label = "";
    int index = value.toInt();
    switch (index) {
      case 0:
        label = "KT.ACEH";
        break;
      case 1:
        label = "KT.SUMATERA UTARA";
        break;
      case 2:
        label = "KT.SUMATERA BARAT";
        break;
      case 3:
        label = "KT. RIAU";
        break;
      case 4:
        label = "KT. JAMBI";
        break;
      case 5:
        label = "KT. SUMATERA SELATAN";
        break;
      case 6:
        label = "KT. BENGKULU";
        break;
      case 7:
        label = "KT. LAMPUNG";
        break;
      case 8:
        label = "KT. DKI JAKARTA";
        break;
      case 9:
        label = "KT. JAWA BARAT";
        break;
      case 10:
        label = "KT. JAWA TENGAH";
        break;
      case 11:
        label = "KT. D.I YOGYAKARTA";
        break;
    }

    Widget text;
    text = Text(label, style: style);

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 8,
      child: text,
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 6,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(meta.formattedValue, style: style),
    );
  }

  List<BarChartGroupData> get barGroups => [
        BarChartGroupData(
          barsSpace: 1,
          x: 0,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 3000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 3000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 1,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 45000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 45000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 2,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 10000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 10000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 3,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 60000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 60000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 4,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 230000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 230000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 5,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 38000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 38000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 6,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 70000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 70000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 7,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 38000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 38000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 8,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 18000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 18000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 9,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 49000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 49000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 10,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 85000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 85000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 11,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 17000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 17000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 12,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 22000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 22000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 13,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 87000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 87000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 14,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 153000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 153000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 15,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 175000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 175000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 16,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 120000000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 120000000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 17,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 145000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 145000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 18,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 4062920,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 4062920,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 19,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 2600000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 2600000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 20,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 1070000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 1070000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 21,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 683000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 683000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 22,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 275000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 275000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
        BarChartGroupData(
          x: 23,
          barRods: [
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 145000,
              color: clrWait,
            ),
            BarChartRodData(
              borderRadius: BorderRadius.circular(1),
              width: 2,
              toY: 145000,
              color: clrBadge,
            ),
          ],
          showingTooltipIndicators: [0],
        ),
      ];
}
