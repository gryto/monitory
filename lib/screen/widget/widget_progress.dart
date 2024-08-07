import 'package:flutter/material.dart';
import '../../src/constant.dart';
import 'icon_style.dart';
import 'package:badges/badges.dart' as badges;

class WidgetProgress extends StatefulWidget {
  final String title;
  final String description;
  final TextStyle? descriptionStyle;
  final String createDate;
  final IconStyle? iconStyle;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final IconData icons;
  final TextStyle? titleStyle;
  final String subtitle;
  final TextStyle? subtitleStyle;
  final String begin;
  final String end;
  final String user;
  final Widget? trailing;
  final ImageProvider image;

  const WidgetProgress({
    super.key,
    required this.title,
    required this.description,
    required this.createDate,
    required this.iconStyle,
    required this.begin,
    required this.end,
    required this.user,
    required this.icons,
    required this.image,
    required this.subtitle,
    this.backgroundColor,
    this.onTap,
    this.titleStyle,
    this.subtitleStyle,
    this.trailing,
    this.descriptionStyle,
  });

  @override
  State<WidgetProgress> createState() => _WidgetProgressState();
}

class _WidgetProgressState extends State<WidgetProgress> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: badges.Badge(
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.square,
          borderRadius: BorderRadius.circular(5),
          badgeColor: widget.subtitle == "Menunggu" ? clrEdit : widget.subtitle == "Digunakan" ? clrWait : widget.subtitle == "Selesai" ? clrBadge : clrDelete,
        ),
        position: badges.BadgePosition.custom(start: 10, top: 10),
        badgeContent: Text(
          widget.subtitle,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        child: Row(
          children: [
            Container(
              height: 140,
              decoration: BoxDecoration(
                color: Colors.white,
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
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Image(
                      image: widget.image,
                      width: 120,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 5,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.title,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              widget.description,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(
                              height: 28,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.date_range,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.createDate,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 2,
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.timer,
                                  size: 15,
                                  color: Colors.grey,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  widget.begin,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  widget.end,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }
}
