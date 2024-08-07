import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../src/constant.dart';

class ActivityDetail extends StatelessWidget {
  final String activityUser,
      activityIp,
      activityBrowser,
      activityPlatform,
      activityCreated,
      activityUpdated,
      activityDescription;

  const ActivityDetail({
    Key? key,
    required this.activityIp,
    required this.activityBrowser,
    required this.activityPlatform,
    required this.activityCreated,
    required this.activityUpdated,
    required this.activityDescription,
    required this.activityUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width - 0;

    String formatDate(String dateTimeString) {
      DateFormat inputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSSSS'Z'");
      DateFormat outputFormat = DateFormat("dd-MM-yyyy");
      DateTime dateTime = inputFormat.parse(dateTimeString);
      String formattedDate = outputFormat.format(dateTime);
      return formattedDate;
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: clrPrimary,
        title: const Text("Log Kunjungan",style: TextStyle(color: Colors.white,)),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Container(
                width: w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2.0),
                  color: Colors.white,
                ),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.account_circle),
                      title: const Text(
                        "Pengguna",
                        style: TextStyle(fontSize: 12, height: 1.8),
                      ),
                      subtitle: Text(
                        activityUser,
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.text_fields),
                      title: const Text(
                        "Keterangan",
                        style: TextStyle(fontSize: 12, height: 1.8),
                      ),
                      subtitle: Text(
                        activityDescription,
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.wifi),
                      title: const Text(
                        "Alamat IP",
                        style: TextStyle(fontSize: 12, height: 1.8),
                      ),
                      subtitle: Text(
                        activityIp,
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.mobile_friendly),
                      title: const Text(
                        "Browser",
                        style: TextStyle(fontSize: 12, height: 1.8),
                      ),
                      subtitle: Text(
                        activityBrowser,
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.laptop),
                      title: const Text(
                        "Sistem Operasi",
                        style: TextStyle(fontSize: 12, height: 1.8),
                      ),
                      subtitle: Text(
                        activityPlatform,
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.create),
                      title: const Text(
                        "Dibuat",
                        style: TextStyle(fontSize: 12, height: 1.8),
                      ),
                      subtitle: Text(
                        formatDate(activityCreated),
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.update),
                      title: const Text(
                        "Diubah",
                        style: TextStyle(fontSize: 12, height: 1.8),
                      ),
                      subtitle: Text(
                        formatDate(activityUpdated),
                        style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const Divider(),
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
