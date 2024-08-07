import 'package:flutter/material.dart';
import 'package:monitoriy/src/constant.dart';

class NotifikasiList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  // ignore: prefer_typing_uninitialized_variables
  final dataadmin;
  // ignore: prefer_typing_uninitialized_variables
  final dataadmin5;
  // ignore: prefer_typing_uninitialized_variables
  final userLevel;
  // ignore: prefer_typing_uninitialized_variables
  final datauser1;
  // ignore: prefer_typing_uninitialized_variables
  final datauser2;
  const NotifikasiList({
    Key? key,
    required this.data,
    required this.dataadmin,
    required this.dataadmin5,
    required this.datauser1,
    required this.datauser2,
    required this.userLevel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Merge data, dataadmin, and dataadmin5
    List<Map<String, dynamic>> mergedList = [];
    List<Map<String, dynamic>> mergedListUser = [];
    // String? userRole ;

    int maxLength = data.length;
    if (dataadmin.length > maxLength) maxLength = dataadmin.length;
    if (dataadmin5.length > maxLength) maxLength = dataadmin5.length;

    for (int i = 0; i < maxLength; i++) {
      if (i < data.length) mergedList.add(data[i]);
      if (i < dataadmin.length) mergedList.add(dataadmin[i]);
      if (i < dataadmin5.length) mergedList.add(dataadmin5[i]);
    }

    int maxLengthUser = datauser1.length;
    if (datauser2.length > maxLengthUser) maxLengthUser = datauser2.length;

    for (int i = 0; i < maxLengthUser; i++) {
      if (i < datauser2.length) mergedListUser.add(datauser2[i]);
    }

    if (userLevel == "1") {
      if (mergedList.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            padding:
                const EdgeInsets.only(bottom: 5, top: 5, left: 5.0, right: 5.0),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var item = mergedList[index];
              return Column(
                children: [
                  ListTile(
                    onTap: () {},
                    selectedColor: Colors.amber,
                    leading: CircleAvatar(
                      backgroundColor: getColorBasedOnSource(item['status']),
                      child: Icon(
                        Icons.notifications,
                        color: getColorBasedOnStatus(item['status']),
                      ),
                    ),
                    title: Text(
                      item['nama_kegiatan'] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['status_kegiatan'] ?? "",
                          style: TextStyle(
                            color: getColorBasedOnStatus(item['status']),
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_alarm,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${item['tgl_kegiatan']} (${item['waktu']}) ",
                              style: const TextStyle(fontSize: 12, height: 1.5),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
            separatorBuilder: (_, index) => const SizedBox(
              height: 5,
            ),
            itemCount: mergedList.length,
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
                    Icons.notifications,
                    size: 90.0,
                    color: Colors.grey.shade400,
                  ),
                  Text(
                    "Ooops, Sepertinya Belum Ada Pemberitahuan!",
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
    } else {
      if (mergedListUser.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: ListView.separated(
            padding:
                const EdgeInsets.only(bottom: 5, top: 5, left: 5.0, right: 5.0),
            primary: false,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (_, index) {
              var row = mergedListUser[index];

              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: getColorBasedOnSource(row['status']),
                      child: Icon(
                        Icons.notifications,
                        color: getColorBasedOnStatus(row['status']),
                      ),
                    ),
                    title: Text(
                      row['nama_kegiatan'] ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.8,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          row['status_kegiatan'] ?? "",
                          style: TextStyle(
                            color: getColorBasedOnStatus(row['status']),
                            fontSize: 14,
                            height: 1.5,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_alarm,
                              size: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "${row['tgl_kegiatan']} (${row['waktu']}) ",
                              style: const TextStyle(fontSize: 12, height: 1.5),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                ],
              );
            },
            separatorBuilder: (_, index) => const SizedBox(
              height: 5,
            ),
            itemCount: datauser1.length,
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
                    Icons.notifications,
                    size: 90.0,
                    color: Colors.grey.shade400,
                  ),
                  Text(
                    "Ooops, Sepertinya Belum Ada Pemberitahuan!",
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

  Color getColorBasedOnSource(int status) {
    switch (status) {
      case 1:
        return const Color.fromARGB(255, 216, 231, 241);
      case 2:
        return const Color.fromARGB(255, 216, 241, 231);
      default:
        return const Color.fromARGB(255, 255, 247, 208);
    }
  }

  Color getColorBasedOnStatus(int status) {
    switch (status) {
      case 1:
        return clrWait;
      case 2:
        return clrBadge;
      default:
        return clrEdit;
    }
  }
}
