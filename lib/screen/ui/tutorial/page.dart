// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
// import '../../../src/constant.dart';

// class TutorialPage extends StatefulWidget {
//   const TutorialPage({Key? key}) : super(key: key);

//   @override
//   State<TutorialPage> createState() => _TutorialPageState();
// }

// class _TutorialPageState extends State<TutorialPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: clrPrimary,
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text("Dokumen Panduan", style: TextStyle(color: Colors.white),),
//           ],
//         ),
//         // const Text("Dokumen Panduan"),
//         elevation: 0,
//       ),
//       body: SfPdfViewer.network(
//           "http://casys.kejaksaan.go.id/storage/panduan_aplikasi/MANUAL_BOOK_U4_USER_BIDANG_JAMBIN.pdf"),
//       //  SfPdfViewer.network(
//       //     "http://u4.cloudkejaksaan.my.id/storage/panduan_aplikasi/Panduan_Aplikasi_Monitoring_Ruangan.pdf"),
//     );
//   }
// }



import 'package:flutter/material.dart';
import '../../../src/constant.dart';
import '../../../src/preference.dart';
import 'component/list.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({Key? key}) : super(key: key);

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  SharedPref sharedPref = SharedPref();
  String typeUser = "";

  void checkSession() async {
    var userRole = await sharedPref.getPref("level");

    setState(() {
      typeUser = userRole;
    });
  }

  @override
  void initState() {
    checkSession();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Dokumen Panduan",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
        // const Text("Dokumen Panduan"),
        elevation: 0,
      ),
      body: TutorialList(
        userRole: typeUser,
      ),
    );
  }
}

