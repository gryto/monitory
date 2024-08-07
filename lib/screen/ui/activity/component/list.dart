import 'package:flutter/material.dart';
import 'package:monitoriy/src/constant.dart';
import '../../../widget/custom_list_item.dart';
import '../component/detail.dart';

class ActivityList extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final data;
  const ActivityList({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (data.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.separated(
          padding:
              const EdgeInsets.only(bottom: 5, top: 5, left: 5.0, right: 5.0),
          primary: false,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (_, index) {
            var row = data[index];

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => ActivityDetail(
                      activityUser: row['username'] ?? "",
                      activityIp: row['ip_address'] ?? "",
                      activityBrowser: row['browser'] ?? "",
                      activityPlatform: row['platform'] ?? "",
                      activityDescription: row['activity'] ?? "",
                      activityCreated: row['created_at'] ?? "",
                      activityUpdated: row['updated_at'] ?? "",
                    ),
                  ),
                );
              },
              child: Card(
                color: Colors.white,
                surfaceTintColor: Colors.white,
                child: CustomListItemTwo(
                  thumbnail: const Icon(
                    Icons.lock_clock_outlined,
                    color: clrPrimary,
                  ),
                  title: row['username'] ?? "",
                  subtitle: row['activity'] ?? "",
                  ipAddress: row['ip_address'] ?? "",
                  icon: const Icon(
                    Icons.arrow_forward_ios_sharp,
                    color: Colors.grey,
                    size: 15,
                  ),
                ),
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
