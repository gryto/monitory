import 'package:flutter/material.dart';
import 'package:monitoriy/src/constant.dart';
import '../../../widget/icon_style.dart';
import '../../../widget/widget_progress.dart';


class InfoActivityList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const InfoActivityList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(3),
        child: ListView.separated(
          padding:
              const EdgeInsets.only(bottom: 5, top: 5, right: 5.0),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = data[index];

            return GestureDetector(
              onTap: () {
                
              },
              child: 
              WidgetProgress(
                  title: row['ruangan_name'] ?? "",
                  description: row['nama_kegiatan'] ?? "",
                  subtitle: row['status'] == 1 ? "Menunggu" : row['status'].toString() == 2
                      ? "Digunakan" : row['status'] == 3 ? "Selesai"
                      : "Batal",
                  createDate: row['waktu'] ?? "",
                  user: "pemohon",
                  image: const AssetImage("assets/images/meetingroom.jpeg"),
                  // NetworkImage(row['path'] ?? ""),
                  begin: row['tgl_kegiatan'] ?? "",
                  end: "",
                  iconStyle: IconStyle(
                    backgroundColor: clrPrimary,
                    iconsColor: Colors.white,
                    withBackground: true,
                  ),
                  icons: Icons.home_work,
                  onTap: () {
                  },
                ),
            );
          },
          separatorBuilder: (_, index) => const SizedBox(
            height: 5,
          ),
          itemCount: data.isEmpty ? 0 : data.length,
        ),
      );
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.lock_clock,
                  size: 90.0,
                  color: Colors.grey.shade400,
                ),
                Text(
                  "Ooops, Username Yang Kamu Cari Tidak Ada!",
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
