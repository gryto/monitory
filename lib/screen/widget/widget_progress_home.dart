import 'package:flutter/material.dart';
import '../../src/constant.dart';
import 'icon_style.dart';
import 'package:badges/badges.dart' as badges;

class WidgetProgressHome extends StatefulWidget {
  final String title;
  final String category;
  final String room;
  final String participant;
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

  const WidgetProgressHome({
    super.key,
    required this.title,
    required this.category,
    required this.room,
    required this.participant,
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
  State<WidgetProgressHome> createState() => _WidgetProgressHomeState();
}

class _WidgetProgressHomeState extends State<WidgetProgressHome> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: badges.Badge(
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.square,
          borderRadius: BorderRadius.circular(5),
          badgeColor: widget.subtitle == "Menunggu"
              ? clrEdit
              : widget.subtitle == "Berlangsung"
                  ? clrWait
                  : widget.subtitle == "Selesai"
                      ? clrBadge
                      :  widget.subtitle == "Batal" ? clrDelete : clrTitle ,
        ),
        position: badges.BadgePosition.custom(start: 10, top: 10),
        badgeContent: Text(
          widget.subtitle,
          style: const TextStyle(
              color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(15)),
              child: Image(
                image: widget.image,
                width: 400,
                height: 160,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      maxLines: 1,
                      style: const TextStyle(
                        fontSize: 16,
                        color: clrWait,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      widget.category,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      widget.room,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      "${widget.participant} Peserta",
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        color: clrWait,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.date_range,
                              size: 15,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "${widget.createDate} WIB",
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                                fontWeight: FontWeight.w400,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.timer,
                              size: 15,
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              width: 2,
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
