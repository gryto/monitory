import 'package:flutter/material.dart';
import '../../src/constant.dart';
import 'activity/page.dart';
import 'dashboardActivity/loacalization.dart';
import 'home/page.dart';
import 'tutorial/page.dart';
import 'package:sizer/sizer.dart';

class MainHome extends StatefulWidget {
  final String id;
  const MainHome({Key? key, required this.id}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  int currentPage = 0;
  final List _pages = [
    const HomePage(),
    const LocalizationSupport(),
    const TutorialPage(),
    const ActivityPage()
  ];

  void tappedPage(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPage],
      backgroundColor: Colors.white,
      // backgroundColor: Colors.transparent,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          left: 2.w,
          right: 2.w,
          bottom: 2.w,
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: clrShadow,
                blurRadius: 1.0,
                spreadRadius: 0.5,
                offset: Offset(1, 1),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 15.w,
              child: BottomNavigationBar(
                showSelectedLabels: true,
                selectedItemColor: clrPrimary,
                showUnselectedLabels: false,
                selectedLabelStyle:
                    const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                backgroundColor: Colors.white,
                currentIndex: currentPage,
                type: BottomNavigationBarType.fixed,
                onTap: tappedPage,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home_outlined),
                    activeIcon: Icon(
                      Icons.home,
                      color: clrPrimary,
                    ),
                    label: 'Beranda',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.calendar_today_outlined),
                    activeIcon: Icon(
                      Icons.calendar_today,
                      color: clrPrimary,
                    ),
                    label: 'Kalender',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.book_outlined,
                    ),
                    activeIcon: Icon(
                      Icons.book,
                      color: clrPrimary,
                    ),
                    label: 'Panduan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.lock_clock_outlined),
                    activeIcon: Icon(
                      Icons.lock_clock,
                      color: clrPrimary,
                    ),
                    label: 'Riwayat',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
