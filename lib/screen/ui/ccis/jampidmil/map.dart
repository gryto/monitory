import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_android/webview_flutter_android.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import '../../../../src/constant.dart';
import '../../../../src/logout.dart';
import '../../../../src/preference.dart';
import '../../../widget/icon_style.dart';
import '../../../widget/setting_item.dart';
import 'detailJampidmil/laporanKoneksitas.dart';
import 'detailJampidmil/laporanKoordinasi.dart';
import 'detailJampidmil/laporanNonteknis.dart';
import 'detailJampidmil/laporanTeknis.dart';

class MapJampidmil extends StatefulWidget {
  final String accessToken, tahun;

  const MapJampidmil({Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<MapJampidmil> createState() => _MapJampidmilState();
}

class _MapJampidmilState extends State<MapJampidmil> {
  late final WebViewController _controller;
  late final PlatformWebViewControllerCreationParams params;
  late Widget body;
  String title = "JAMPIDMIL";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";

  SharedPref sharedPref = SharedPref();
  String message = "";
  bool isProcess = true;
  @override
  dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..addJavaScriptChannel(
        'Toaster',
        onMessageReceived: (JavaScriptMessage message) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(message.message)),
          );
        },
      )
      ..loadRequest(
          Uri.parse('https://casys.kejaksaan.go.id/dashboard-jampidmil/maps'));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    Widget widgets;

    widgets = RichText(
      textAlign: TextAlign.start,
      text: TextSpan(
        text: title,
        style: const TextStyle(
          color: clrBadge,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 30, 46),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Container(
          padding: const EdgeInsets.only(left: 2, right: 2),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(
                    width: 40,
                    height: 40,
                    child: Image(
                      image: AssetImage(
                        "assets/images/kejaksaan-logo.png",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  widgets,
                ],
              ),
              GestureDetector(
                onTap: () {
                  logoutDialog(context);
                },
                child: const Icon(
                  Icons.logout,
                  color: clrSecondary,
                ),
              ),
            ],
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 13, 30, 46),
        shadowColor: const Color.fromARGB(255, 23, 56, 82),
      ),
      body: WebViewWidget(controller: _controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Container(
                  color: const Color.fromRGBO(0, 0, 0, 0.001),
                  child: GestureDetector(
                    onTap: () {},
                    child: DraggableScrollableSheet(
                      initialChildSize: 0.8,
                      minChildSize: 0.2,
                      maxChildSize: 0.95,
                      builder: (_, controller) {
                        return Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 13, 30, 46),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25.0),
                              topRight: Radius.circular(25.0),
                            ),
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.remove,
                                color: Colors.grey[600],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              const Text(
                                "Detail",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white),
                              ),
                              const Divider(
                                thickness: 2,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  controller: controller,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 2,
                                        left: 15,
                                        right: 15,
                                        bottom: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SettingsItem(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LaporanKoneksitas()),
                                            );
                                          },
                                          icons: Icons.cast_connected,
                                          iconStyle: IconStyle(
                                            iconsColor: Colors.white,
                                            withBackground: true,
                                            backgroundColor: clrBadge,
                                          ),
                                          title: 'Laporan Koneksitas',
                                        ),
                                        const Divider(
                                          height: 2,
                                        ),
                                        SettingsItem(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LaporanKoordinasi()),
                                            );
                                          },
                                          icons: Icons.corporate_fare,
                                          iconStyle: IconStyle(
                                            iconsColor: Colors.white,
                                            withBackground: true,
                                            backgroundColor: clrBadge,
                                          ),
                                          title: 'Laporan Koordinasi',
                                        ),
                                        const Divider(
                                          height: 2,
                                        ),
                                        SettingsItem(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LaporanNonteknis()),
                                            );
                                          },
                                          icons: Icons.table_chart_rounded,
                                          iconStyle: IconStyle(
                                            iconsColor: Colors.white,
                                            withBackground: true,
                                            backgroundColor: clrBadge,
                                          ),
                                          title: 'Laporan Nonteknis',
                                        ),
                                        const Divider(
                                          height: 2,
                                        ),
                                        SettingsItem(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const LaporanTeknis()),
                                            );
                                          },
                                          icons: Icons.table_rows,
                                          iconStyle: IconStyle(
                                            iconsColor: Colors.white,
                                            withBackground: true,
                                            backgroundColor: clrBadge,
                                          ),
                                          title: 'Laporan Teknis',
                                        ),
                                        const Divider(
                                          height: 2,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            },
          );
        },
        backgroundColor: clrBadge,
        child: const Text(
          "Menu",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
