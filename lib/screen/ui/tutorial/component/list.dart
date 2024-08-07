import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../../../../src/constant.dart';

// ignore: must_be_immutable
class TutorialList extends StatefulWidget {
  String userRole;
  TutorialList({
    Key? key,
    required this.userRole,
  }) : super(key: key);

  @override
  State<TutorialList> createState() => _TutorialListState();
}

class _TutorialListState extends State<TutorialList>
    with SingleTickerProviderStateMixin {
  late TabController controller;
  int selectedIndex = 0;

  @override
  void initState() {
    controller = TabController(vsync: this, length: 2);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.userRole == "1") {
      return bidangTabBar();
    } else {
      return user();
    }
  }

  Widget bidangTabBar() {
    return Column(
      children: [
        TabBar(
          labelColor: clrBadge,
          indicatorColor: clrBadge,
          unselectedLabelColor: const Color.fromARGB(255, 186, 227, 217),
          tabs: const <Tab>[
            Tab(text: 'Administrator'),
            Tab(text: 'User'),
          ],
          controller: controller,
          onTap: (int index) {
            setState(() {
              selectedIndex = index;
              controller.animateTo(index);
            });
          },
        ),
        Expanded(
          child: TabBarView(
            controller: controller,
            children: [
              administrator(),
              user(),
            ],
          ),
        ),
      ],
    );
  }

  Widget administrator() {
    return SfPdfViewer.network(
          "http://casys.kejaksaan.go.id/storage/panduan_aplikasi/MANUAL_BOOK_U4_ADMINISTRATOR.pdf");
  }

  Widget user() {
    return SfPdfViewer.network(
        "http://casys.kejaksaan.go.id/storage/panduan_aplikasi/MANUAL_BOOK_U4_USER_BIDANG_JAMBIN.pdf");
  }
}
