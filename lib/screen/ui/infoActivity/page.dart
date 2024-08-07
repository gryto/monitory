import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/preference.dart';
import '../../widget/icon_style.dart';
import '../../widget/widget_progress_home.dart';
import 'package:badges/badges.dart' as badges;

class ActivityInfoPage extends StatefulWidget {
  const ActivityInfoPage({Key? key}) : super(key: key);

  @override
  State<ActivityInfoPage> createState() => _ActivityInfoPageState();
}

class _ActivityInfoPageState extends State<ActivityInfoPage> {
  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  List listData = [];
  List listDataParticipant = [];
  String idKategori = "";

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
    });

    

    getData(username, limit, offset);
  }

  getData(username, limit, offset) async {
    var accessToken = await sharedPref.getPref("access_token");

    try {
      var url = ApiService.infoActivity;
      var uri = url;
      print(url);
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      print(content.toString());

      if (content['status'] == true) {
        
        setState(() {
          if (listData.isEmpty) {
            listData = content['data'];
          } else {
            // listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        // onBasicAlertPressed(context, 'Error', content['message']);
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
    var kategoriId = await sharedPref.getPref("kategori_id");

    setState(() {
      idKategori = kategoriId;
    });
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
    return cardInfoActivity();
  }

  Widget cardInfoActivity() {
    if (listData.isNotEmpty) {
      return ListView.separated(
        primary: false,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          var row = listData[index];

          return WidgetProgressHome(
            category: row['kategori_kegiatan'] ?? "",
            title: row['nama_kegiatan'] ?? "",
            room: row['ruangan_name'] ?? "",
            subtitle: row['status'] == 1
                ? "Menunggu"
                : row['status'] == 2
                    ? "Berlangsung"
                    : row['status'] == 3
                        ? "Selesai"
                        : row['status'] == 4
                            ? "Batal"
                            : "Belum Disetujui",
            createDate: row['waktu'] ?? "",
            user: "pemohon",
            image:
                // const AssetImage("assets/images/meetingroom.jpeg"),
                NetworkImage(row['path'] ?? ""),
            begin: row['tgl_kegiatan'] ?? "",
            end: "",
            participant: row['jml_peserta'].toString(),
            iconStyle: IconStyle(
              backgroundColor: clrPrimary,
              iconsColor: Colors.white,
              withBackground: true,
            ),
            icons: Icons.home_work,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) {
                  return GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      color: const Color.fromRGBO(0, 0, 0, 0.001),
                      child: GestureDetector(
                        onTap: () {},
                        child: DraggableScrollableSheet(
                          initialChildSize: 0.8,
                          minChildSize: 0.2,
                          maxChildSize: 0.95,
                          builder: (_, controller) {
                            return Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(25.0),
                                  topRight: Radius.circular(25.0),
                                ),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.remove,
                                    color: Colors.grey[600],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "Detail",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  const Divider(
                                    thickness: 2,
                                  ),
                                  Expanded(
                                    child: SingleChildScrollView(
                                      controller: controller,
                                      child: Padding(
                                        padding:
                                            const EdgeInsetsDirectional.all(15),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: CachedNetworkImage(
                                                imageUrl: row['path'] ?? "",
                                                placeholder: (context, url) =>
                                                    const CircularProgressIndicator(),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                Text(
                                                  row['nama_kegiatan'] ?? "",
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.w800,
                                                      color: clrPrimary),
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        badges.Badge(
                                                          badgeStyle:
                                                              badges.BadgeStyle(
                                                            shape: badges
                                                                .BadgeShape
                                                                .square,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                            badgeColor: row[
                                                                        'status'] ==
                                                                    1
                                                                ? clrEdit
                                                                : row['status'] ==
                                                                        2
                                                                    ? clrWait
                                                                    : row['status'] ==
                                                                            3
                                                                        ? clrBadge
                                                                        : row['status'] ==
                                                                                4
                                                                            ? clrDelete
                                                                            : clrTitle,
                                                          ),
                                                          position: badges
                                                                  .BadgePosition
                                                              .custom(
                                                                  start: 10,
                                                                  top: 10),
                                                          badgeContent: Text(
                                                            row['status'] == 1
                                                                ? "Menunggu"
                                                                : row['status'] ==
                                                                        2
                                                                    ? "Berlangsung"
                                                                    : row['status'] ==
                                                                            3
                                                                        ? "Selesai"
                                                                        : row['status'] ==
                                                                                4
                                                                            ? "Batal"
                                                                            : "Belum Disetujui",
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
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                ListTile(
                                                  leading:
                                                      const Icon(Icons.radar),
                                                  title: const Text(
                                                    "Kategori Kegiatan",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1.8),
                                                  ),
                                                  subtitle: Text(
                                                    row['kategori_kegiatan'] ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 1.5,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons
                                                      .room),
                                                  title: const Text(
                                                    "Ruangan",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1.8),
                                                  ),
                                                  subtitle: Text(
                                                    row['ruangan_name'] ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 1.5,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons
                                                      .date_range),
                                                  title: const Text(
                                                    "Tanggal Kegiatan",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1.8),
                                                  ),
                                                  subtitle: Text(
                                                    row['tgl_kegiatan'] ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 1.5,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons
                                                      .date_range),
                                                  title: const Text(
                                                    "Waktu",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1.8),
                                                  ),
                                                  subtitle: Text(
                                                    row['waktu']+" WIB",
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 1.5,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                                ListTile(
                                                  leading: const Icon(Icons
                                                      .text_fields),
                                                  title: const Text(
                                                    "Deskripsi",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        height: 1.8),
                                                  ),
                                                  subtitle: Text(
                                                    row['deskripsi'] ??
                                                        "",
                                                        maxLines: 15,
                                                    style: const TextStyle(
                                                        fontSize: 16,
                                                        height: 1.5,
                                                        color: Colors.black,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            }, 
          );
        },
        separatorBuilder: (_, index) => const SizedBox(
          height: 5,
        ),
        itemCount: listData.isEmpty ? 0 : listData.length,
      );
      // );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_clock,
                  size: 90.0,
                  color: Colors.grey.shade400,
                ),
                Text(
                  "Ooops, Belum Ada Kegiatan Kali Ini!",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.grey.shade400,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ),
        ],
      );
    }
  }
}
