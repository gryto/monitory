import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_android/webview_flutter_android.dart';
// ignore: depend_on_referenced_packages
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import '../../../../src/constant.dart';
import '../../../../src/logout.dart';
import '../../../widget/icon_style.dart';
import '../../../widget/setting_item.dart';
import 'detailJamintel/daftarPencarian.dart';
import 'detailJamintel/daftarTangkapan.dart';
import 'detailJamintel/lapinhar.dart';

class JamintelMapPage extends StatefulWidget {
  final String accessToken, tahun;

  const JamintelMapPage(
      {Key? key, required this.accessToken, required this.tahun})
      : super(key: key);

  @override
  State<JamintelMapPage> createState() => _JamintelMapPageState();
}

class _JamintelMapPageState extends State<JamintelMapPage> {
  String title = "JAMINTEL";
  String subtitle = "Sumber : DASKRIMTI ( https://dasti.kejaksaan.go.id/v3/ )";
  late final WebViewController _controller;
  late final PlatformWebViewControllerCreationParams params;

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
      ..loadRequest(Uri.parse(
          'https://casys.kejaksaan.go.id/dashboard-jamintel/dpo/maps'));

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
            fontSize: 16, fontWeight: FontWeight.w500, color: clrBadge),
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 30, 46),
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: Row(
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
                      "assets/icons/jamintel.png",
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
                                    fontSize: 14, fontWeight: FontWeight.w600),
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
                                                    DaftarPencarian(
                                                  accessToken:
                                                      widget.accessToken,
                                                  tahun: widget.tahun,
                                                ),
                                              ),
                                            );
                                          },
                                          icons: Icons.search,
                                          iconStyle: IconStyle(
                                            iconsColor: Colors.white,
                                            withBackground: true,
                                            backgroundColor: clrBadge,
                                          ),
                                          title: 'Daftar Pencarian',
                                        ),
                                        const Divider(
                                          height: 2,
                                        ),
                                        SettingsItem(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => Lapinhar(
                                                  accessToken:
                                                      widget.accessToken,
                                                  tahun: widget.tahun,
                                                ),
                                              ),
                                            );
                                          },
                                          icons: Icons.label,
                                          iconStyle: IconStyle(
                                            iconsColor: Colors.white,
                                            withBackground: true,
                                            backgroundColor: clrBadge,
                                          ),
                                          title: 'LAPINHAR',
                                        ),
                                        const Divider(
                                          height: 2,
                                        ),
                                        SettingsItem(
                                          onTap: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    DaftangTangkapan(
                                                  accessToken:
                                                      widget.accessToken,
                                                  tahun: widget.tahun,
                                                ),
                                              ),
                                            );
                                          },
                                          icons: Icons.catching_pokemon,
                                          iconStyle: IconStyle(
                                            iconsColor: Colors.white,
                                            withBackground: true,
                                            backgroundColor: clrBadge,
                                          ),
                                          title: 'Daftar Tangkapan',
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
        // const Icon(
        //   Icons.menu,
        //   color: Colors.white,
        // ),
      ),
    );
  }
}
