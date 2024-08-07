class ApiService {
  static String baseUrl  = "http://202.157.188.69";
  // static String uri      = "u4.cloudkejaksaan.my.id";
  static String uri      = "casys.kejaksaan.go.id";
  static String uri2      = "casyslumen.kejaksaan.info";
  static String server   = "http://$uri";
  static String server2   = "http://$uri2";
  static String endPoint = "$server:4002";
  static String url      = "http://202.157.188.112";



  static String authport    = "3000";
  static String appPort     = "3004";
  static String setLogin    = "$baseUrl:$authport/v1/login";
  static String setLogout   = "$baseUrl:$authport/v1/logout";
  static String detailUser  = "$baseUrl:3001/v1/get";
  static String logActivity = "$baseUrl:3001/v1/log/datatables";


  static String countLapdumas = "$baseUrl:$appPort/v1/lapdumas/count";
  static String chartLapdumas = "$baseUrl:$appPort/v1/lapdumas/chart/bar";

  //JAMBIN(Biro Kepegawaian - SIMKARI)
  static String countPegawai  = "$baseUrl:$appPort/v1/pegawai/chart";
  static String chartPegawai  = "$baseUrl:$appPort/v1/pegawai/chart/bar";
  static String chartLelang   = "$baseUrl:$appPort/v1/lelang/count";
  static String topLelang     = "$baseUrl:$appPort/v1/lelang/top";
  static String countLelang   = "$baseUrl:$appPort/v1/lelang/count";
  static String listingLelang = "$baseUrl:$appPort/v1/lelang/datatables";


  ///JAMPIDUM
  static String countPidum         = "$baseUrl:$appPort/v1/pidum/count";
  static String countAllPidum      = "$baseUrl:$appPort/v1/pidum/count/all";
  static String countPidumParent   = "$baseUrl:$appPort/v1/pidum/count/parent";
  static String countPidumKategori = "$baseUrl:$appPort/v1/pidum/count/kategori";
      
  ///JAMPIDSUS
  static String countPidsus         = "$baseUrl:$appPort/v1/pidsus/count";
  static String countAllPidsus      = "$baseUrl:$appPort/v1/pidsus/count/all";
  static String countPidsusParent   = "$baseUrl:$appPort/v1/pidsus/count/parent";
  static String countPidsusKategori = "$baseUrl:$appPort/v1/pidsus/count/kategori";//

  ///JAMBIN(Biro Umun - PTSP)
  static String countBukutamu     = "$baseUrl:$appPort/v1/tamu/count";
  static String chartBukutamu     = "$baseUrl:$appPort/v1/tamu/chart/bar";
  static String surveyBukutamu    = "$baseUrl:$appPort/v1/tamu/chart/survei";
  static String lineBukutamu      = "$baseUrl:$appPort/v1/tamu/chart/line";
  static String countBukutamuDate = "$baseUrl:$appPort/v1/tamu/count/date";

  ///JAMBIN(Biro Keuangan - SAKTI)
  static String countKeuangan    = "$baseUrl:$appPort/v1/keuangan/count";
  static String countAllKeuangan = "$baseUrl:$appPort/v1/keuangan/count/all";
  static String topKeuangan      = "$baseUrl:$appPort/v1/keuangan/top";
  static String chartKeuangan    = "$baseUrl:$appPort/v1/keuangan/chart/bar";


  ///JAMBIN(SETBIN - SIPEDE)
  static String countPersuratan    = "$baseUrl:$appPort/v1/persuratan/count";
  static String chartPersuratan    = "$baseUrl:$appPort/v1/persuratan/chart/bar";
  static String countDiklat        = "$baseUrl:$appPort/v1/diklat/count";
  static String countAllDiklat     = "$baseUrl:$appPort/v1/diklat/count/all";
  static String listPesertaDiklat  = "$baseUrl:$appPort/v1/diklat/datatables/master";
  static String listAlumniDiklat   = "$baseUrl:$appPort/v1/diklat/datatables";
  static String listDiklatBerita   = "$baseUrl:$appPort/v1/diklat/datatables/berita";
  static String detailDiklatBerita = "$baseUrl:$appPort/v1/diklat/berita";


  ///JAMINTEL(ISINYA)
  //dpo
  static String countDpo     = "$baseUrl:$appPort/v1/dpo/count";
  static String chartDpo     = "$baseUrl:$appPort/v1/dpo/chart/bar";
  static String topDpo       = "$baseUrl:$appPort/v1/dpo/top";
  static String listingDpo   = "$baseUrl:$appPort/v1/dpo/datatables/new";
  static String detailingDpo = "$baseUrl:$appPort/v1/dpo/new";
  //lapinhar
  static String listingLapinhar    = "$baseUrl:$appPort/v1/dpo/lapinhar/datatables";
  //daftar tangkapan
  static String listingTangkapan   = "$baseUrl:$appPort/v1/dpo/datatables";
  static String detailingTangkapan = "$baseUrl:$appPort/v1/dpo/get";
  //aset
  static String countAllAsset = "$baseUrl:$appPort/v1/asset/count/all";
  static String listAsset     = "$baseUrl:$appPort/v1/asset/count";
  static String chartAsset    = "$baseUrl:$appPort/v1/asset/chart/bar";
  static String countAbsensi  = "$baseUrl:$appPort/v1/absensi/count";

  ///JAMDATUN
  static String countJamdatun = "$baseUrl:$appPort/v1/jamdatun/chart/jumlah";
  static String chartJamdatun = "$baseUrl:$appPort/v1/jamdatun/chart/kategori";
  static String countLapor    = "$baseUrl:$appPort/v1/lapdumas/lapor/count/total";
  static String listLapor     = "$baseUrl:$appPort/v1/lapdumas/lapor/datatables";
  static String countJamwas   = "$baseUrl:$appPort/v1/jamwas/count";

  //LIST SATKER
  static String getSatker      = "$baseUrl:$appPort/v1/persuratan/satker";
  static String getSatuanKerja = "$baseUrl:$appPort/v1/satker";

  ///JAMPIDMIL
  static String koneksitas = "$server2/api/jampidmil/koneksitas";
  static String koordinasi = "$server2/api/jampidmil/koordinasi";
  static String nonteknis  = "$server2/api/jampidmil/nonteknis";
  static String teknis     = "$server2/api/jampidmil/teknis";

  ///JAMINTEL
  static String dpo             = "$baseUrl:$appPort/v1/dpo/datatables/new";
  static String lapinhar        = "$baseUrl:$appPort/v1/dpo/lapinhar/datatables";
  static String daftarTangkapan = "$baseUrl:$appPort/v1/dpo/datatables";

  ////JAMBIN
  static String biroKepegawaian  = "$baseUrl:$appPort/v1/lelang/count";
  static String biroKepegawaian2 = "$baseUrl:$appPort/v1/lelang/top";
  static String biroKepegawaian3 = "$baseUrl:$appPort/v1/lelang/datatables";



////////////////////////////////////CASYS//////////////////////////////////////////

  //LIST SATKER
  static String getSatkerCasys      = "$url:$appPort/v1/persuratan/satker";
  static String getSatuanKerjaCasys = "$url:$appPort/v1/satker";

  ///JAMBIN(SETBIN - SIPEDE) - CASYS
  static String countPersuratanCasys = "$url:$appPort/v1/persuratan/count";

   ///JAMBIN(BIRO UMUM - PTSP) - CASYS
  static String countTamuCasys          = "$url:$appPort/v1/tamu/count/date";
  static String countTamuSatkerCasys    = "$url:$appPort/v1/tamu/count/satker";
  static String countTamuKunjunganCasys = "$url:$appPort/v1/tamu";
  static String listTamuSatkerCasys     = "$url:$appPort/v1/tamu/satker/get";

  ///JAMBIN(BIRO UMUM - ABSENSI) - CASYS
  static String countAbsensiCasys     = "$url:$appPort/v1/absensi/count";
  static String countAbsensiListCasys = "$url:$appPort/v1/absensi/list";

  ///JAMBIN(BIRO UMUM - ANGKUTAN - CASYS
  static String countAngkutanCasys = "$url:$appPort/v1/asset/datatables";

  ///JAMBIN(Biro Keuangan - SAKTI) CASYS
  static String countKeuanganDatatablesCasys = "$url:$appPort/v1/keuangan/datatables";
  static String countKeuanganLayer1Casys     = "$url:$appPort/v1/keuangan/layer1";
  static String countKeuanganLayer2Casys     = "$url:$appPort/v1/keuangan/layer2";
  static String countKeuanganCasys           = "$url:$appPort/v1/keuangan/count";
  static String countAllKeuanganCasys        = "$url:$appPort/v1/keuangan/count/all";
  static String topKeuanganCasys             = "$url:$appPort/v1/keuangan/top";
  static String chartKeuanganCasys           = "$url:$appPort/v1/keuangan/chart/bar";

  //JAMBIN(Biro Kepegawaian - SIMKARI)
  static String countPegawaiCasys = "$url:$appPort/v1/pegawai/chart";

  //JAMBIN(Biro Kepegawaian - SIMPEL)
  static String topLelangCasys     = "$url:$appPort/v1/lelang/top";
  static String countLelangCasys   = "$url:$appPort/v1/lelang/count";
  static String listingLelangCasys = "$url:$appPort/v1/lelang/datatables";

  //JAMWAS(SADAP)
  static String totalSadapCasys = "$url:$appPort/v1/jamwas/sadap/count";

  //JAMWAS(SIIGAP)
  static String totalSiigapCasys = "$url:$appPort/v1/jamwas/siigap/count";

  //JAMWAS(EPROWAS)
  static String totalEprowasCasys = "$url:$appPort/v1/jamwas/eprowas/count";

  //JAMBIN(SIMAK)
  static String countSimakCasys      = "$url:$appPort/v1/asset/count/1";
  static String count2SimakCasys     = "$url:$appPort/v1/asset/count/2";
  static String datatablesSimakCasys = "$url:$appPort/v1/asset/datatables";

  ///JAMPIDUM

  static String countPidum2         = "$url:$appPort/v1/pidum/pra_penuntutan/layer1";
  static String countPidumDetail2   = "$url:$appPort/v1/pidum/pra_penuntutan/layer2";
  static String countPidumDetail3   = "$url:$appPort/v1/pidum/pra_penuntutan/layer3";
  static String countAllPidum2      = "$url:$appPort/v1/pidum/penuntutan/layer1";
  static String countAllPidumDetail2      = "$url:$appPort/v1/pidum/penuntutan/layer2";
  static String countAllPidumDetail3      = "$url:$appPort/v1/pidum/penuntutan/layer3";
  static String countPidumParent2         = "$url:$appPort/v1/pidum/upaya_hukum/layer1";
  static String countPidumParentDetail2   = "$url:$appPort/v1/pidum/upaya_hukum/layer2";
  static String countPidumParentDetail3   = "$url:$appPort/v1/pidum/upaya_hukum/layer3";
  static String countPidumKategori2 = "$url:$appPort/v1/pidum/eksekusi/layer1";
  static String countPidumKategoriDetail2 = "$url:$appPort/v1/pidum/eksekusi/layer2";
  static String pidumSatker = "$url:$appPort/v1/pidum/satker";

  ///JAMPIDSUS
  static String countPidsus1           = "$baseUrl:$appPort/v1/pidsus/penyelidikan/layer1";
  static String countPidsus2           = "$baseUrl:$appPort/v1/pidsus/penyelidikan/layer2";
  static String countPidsus3           = "$baseUrl:$appPort/v1/pidsus/penyelidikan/layer3";

  static String countPidsusPenyidikan1 = "$baseUrl:$appPort/v1/pidsus/penyidikan/layer1";
  static String countPidsusPenyidikan2 = "$baseUrl:$appPort/v1/pidsus/penyidikan/layer2";
  static String countPidsusPenyidikan3 = "$baseUrl:$appPort/v1/pidsus/penyidikan/layer3";

  static String countPidsusPratut1 = "$baseUrl:$appPort/v1/pidsus/pra_penuntutan/layer1";
  static String countPidsusPratu2 = "$baseUrl:$appPort/v1/pidsus/pra_penuntutan/layer2";
  static String countPidsusPratu3 = "$baseUrl:$appPort/v1/pidsus/pra_penuntutan/layer3";

  static String countPidsusPetut1 = "$baseUrl:$appPort/v1/pidsus/penuntutan/layer1";
  static String countPidsusPetut2 = "$baseUrl:$appPort/v1/pidsus/penuntutan/layer2";
  static String countPidsusPetut3 = "$baseUrl:$appPort/v1/pidsus/penuntutan/layer3";

  static String countPidsusEksekusi1 = "$baseUrl:$appPort/v1/pidsus/eksekusi/layer1";
  static String countPidsusEksekusi2 = "$baseUrl:$appPort/v1/pidsus/eksekusi/layer2";
  static String countPidsusEksekusi3 = "$baseUrl:$appPort/v1/pidsus/eksekusi/layer3";

  static String countPidsusUHukum1 = "$baseUrl:$appPort/v1/pidsus/upaya_hukum/layer1";
  static String countPidsusUHukum2 = "$baseUrl:$appPort/v1/pidsus/upaya_hukum/layer2";
  static String countPidsusUHukum3 = "$baseUrl:$appPort/v1/pidsus/upaya_hukum/layer3";

  static String countPidsusHam1 = "$baseUrl:$appPort/v1/pidsus/HAM/layer1";
  static String countPidsusHam2 = "$baseUrl:$appPort/v1/pidsus/HAM/layer2";
  static String countPidsusHam3 = "$baseUrl:$appPort/v1/pidsus/HAM/layer3";


  static String countDatun  = "$baseUrl:$appPort/v1/jamdatun/perdata/layer1/permohonan";
  static String countDatun2 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer1/sp1";
  static String countDatun3 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer1/skk";
  static String countDatun4 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer1/skks";
  static String countDatun5 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer1/putusan";
  static String countDatun6 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer1/eksekusi";

  static String countDatunPerdata  = "$baseUrl:$appPort/v1/jamdatun/perdata/layer2/pemulihan";
  static String countDatunPerdata2 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer2/penyelamatan";
  static String countDatunPerdata3 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer2/penegakan_hukum";
  static String countDatunPerdata4 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer2/arbitrase/bani_pemohon";
  static String countDatunPerdata5 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer2/arbitrase/bani_termohon";
  static String countDatunPerdata6 = "$baseUrl:$appPort/v1/jamdatun/perdata/layer2/arbitrase/icc_respondent";

  static String countDatunTun  = "$baseUrl:$appPort/v1/jamdatun/tun/layer1/permohonan";
  static String countDatunTun2 = "$baseUrl:$appPort/v1/jamdatun/tun/layer1/sp1";
  static String countDatunTun3 = "$baseUrl:$appPort/v1/jamdatun/tun/layer1/sp2";
  static String countDatunTun4 = "$baseUrl:$appPort/v1/jamdatun/tun/layer1/skk";
  static String countDatunTun5 = "$baseUrl:$appPort/v1/jamdatun/tun/layer1/skks";
  static String countDatunTun6 = "$baseUrl:$appPort/v1/jamdatun/tun/layer1/putusan";
  static String countDatunTun7 = "$baseUrl:$appPort/v1/jamdatun/tun/layer1/penyelesaian";
  static String countDatunTun8 = "$baseUrl:$appPort/v1/jamdatun/tun/layer1/eksekusi";


  static String countDatunTunDetail  = "$baseUrl:$appPort/v1/jamdatun/tun/layer2/bantuan_hukum";
  static String countDatunTunDetail2 = "$baseUrl:$appPort/v1/jamdatun/tun/layer2/pelayanan_hukum";
  static String countDatunTunDetail3 = "$baseUrl:$appPort/v1/jamdatun/tun/layer2/penyelenggara_pemerintah";
  static String countDatunTunDetail4 = "$baseUrl:$appPort/v1/jamdatun/tun/layer2/uji_materiil/ma";
  static String countDatunTunDetail5 = "$baseUrl:$appPort/v1/jamdatun/tun/layer2/uji_materiil/mk";


  static String countDatunHukum  = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer1/permohonan";
  static String countDatunHukum2 = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer1/sp1";
  static String countDatunHukum3 = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer1/sp2";
  static String countDatunHukum4 = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer1/penyelesaian";

  static String countDatunHukumDetail  = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer2/pendapat_hukum";
  static String countDatunHukumDetail2 = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer2/pendampingan_hukum";
  static String countDatunHukumDetail3 = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer2/audit_hukum";
  static String countDatunHukumDetail4 = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer2/pelayanan_hukum";
  static String countDatunHukumDetail5 = "$baseUrl:$appPort/v1/jamdatun/pertimbangan_hukum/layer2/tindakan_hukum_lain";







  





}
