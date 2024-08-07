import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../launcher/launcher.dart';
import 'constant.dart';
import 'preference.dart';

logoutDialog(BuildContext context) {
  SharedPref sharedPref = SharedPref();

  Widget cancelButton = DialogButton(
    color: clrDelete,
    child: const Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Text(
        "Tidak",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
    onPressed: () {
      Navigator.of(context, rootNavigator: true).pop(false);
    },
  );

  Widget continueButton = DialogButton(
    padding: const EdgeInsets.only(right: 10, left: 10),
    color: clrEdit,
    child: const Padding(
      padding: EdgeInsets.all(10),
      child: Text(
        "Ya",
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    ),
    onPressed: () {
      sharedPref.dropPref("id");
      sharedPref.dropPref("access_token");

      sharedPref.dropPref("user_bidang");
      sharedPref.dropPref("level");

      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const LauncherPage(),
          ),
          (Route<dynamic> route) => false);
    },
  );

  AlertDialog alert = AlertDialog(
    surfaceTintColor: Colors.white,
    backgroundColor: Colors.white,
    title: const Text(
      "Konfirmasi",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: clrPrimary,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    content: const Text("Apakah anda yakin akan keluar ?"),
    actions: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          cancelButton,
          continueButton,
        ],
      ),
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
