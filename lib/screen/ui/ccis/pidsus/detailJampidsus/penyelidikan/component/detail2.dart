import 'package:flutter/material.dart';

class PenyelidikanPidsusDetail2 extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data, dataListLayer2;
  const PenyelidikanPidsusDetail2({
    Key? key,
    required this.data,
    required this.dataListLayer2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(2),
        child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var row = data[index];

              if (dataListLayer2 == "Dapat Ditingkatkan") {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff3cd2a5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      dense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 5.0, right: 5.0),
                      title: Text(
                        "No. P2 : ${row['no_p2']}",
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Tanggal P2 : ${row['tgl_p2']}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Laporan Pidana : ${row['laporan_pidana'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Sektor: ${row['sektor'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Status Lidik : ${row['status_lidik'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Tanggal Status Lidik : ${row['tgl_status'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Satuan Kerja : ${row['satuan_kerja'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Nama Jaksa : ${row['nama_jaksa'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  ),
                );
              } else if (dataListLayer2 == "Tidak Dapat Ditingkatkan") {
                return GestureDetector(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(5.0),
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xff3cd2a5)),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      dense: true,
                      contentPadding:
                          const EdgeInsets.only(left: 5.0, right: 5.0),
                      title: Text(
                        "No. P2 : ${row['no_p2']}",
                        maxLines: 2,
                        style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 3,
                          ),
                          Text(
                            "Tanggal P2 : ${row['tgl_p2']}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Laporan Pidana : ${row['laporan_pidana'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Sektor: ${row['sektor'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Status Lidik : ${row['status_lidik'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Tanggal Status Lidik : ${row['tgl_status'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Satuan Kerja : ${row['satuan_kerja'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 2),
                          Text(
                            "Nama Jaksa : ${row['nama_jaksa'] ?? "-"}",
                            style: const TextStyle(
                                fontSize: 12, color: Colors.white),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.more_vert),
                    ),
                  ),
                );
              }
              return null;
            },
            separatorBuilder: (_, index) => const SizedBox(
                  height: 1,
                ),
            itemCount: data.isEmpty ? 0 : data.length),
      );
    } else {
      return Center(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
              child: const Text(
                "Data tidak ditemukan",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      );
    }
  }
}
