import 'package:flutter/material.dart';
import '../../../../../../../src/constant.dart';
import '../../../../../../widget/room_widget.dart';

class PraPenuntutanPidsusList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const PraPenuntutanPidsusList({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      List<String> titleList = [
        "Total P8",
        "Total Penyidik TPK",
        "Total Penyidik TPPU",
        "Lanjut Total",
        "Lanjut Tut TPK",
        "Lanjut Tut TPPU",
        "Total Henti",
        "Total Henti TPK",
        "Total Henti TPPU"
      ]; // Replace with your actual string list

      List<String> mainTitleList = [
        "Total P8",
        "Total Penyidik TPK",
        "Total Penyidik TPPU",
        "Lanjut Total",
        "Lanjut Tut TPK",
        "Lanjut Tut TPPU",
        "Total Henti",
        "Total Henti TPK",
        "Total Henti TPPU"
      ]; // Replace with your actual string list

      List colorList = [
        clrBadge,
        clrEdit,
        clrPink,
        clrPrimary,
        clrSecondary,
        clrDelete,
        clrWait,
      ];

      return Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      mainTitleList as String, // Use the title from RoomCategoryData
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      "Total ", // Use the title from RoomCategoryData
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 80,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemBuilder: (_, index) {
                      var row = data[index];
                      String title = titleList[index];

                      return RoomContainer(
                          onTap: () {},
                          title: title,
                          colorIcon: clrWait,
                          count: row);
                    },
                    separatorBuilder: (_, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: data.isEmpty ? 0 : data.length,
                  ),
                ),
              ],
            ),
          ],
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
                  "Ooops, Data Yang Kamu Cari Tidak Ada!",
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

class RoomCategoryData {
  final String title;
  final String count;
  final List<RoomContainer> roomContainers;

  RoomCategoryData({
    required this.title,
    required this.count,
    required this.roomContainers,
  });
}
