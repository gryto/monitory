import 'package:flutter/material.dart';

class RoomContainer extends StatefulWidget {
  final String title;
  final String count;
  final Color colorIcon;
  final VoidCallback? onTap;

  const RoomContainer({
    super.key,
    required this.title,
    required this.count,
    required this.colorIcon,
    required this.onTap,
  });

  @override
  State<RoomContainer> createState() => _RoomContainerState();
}

class _RoomContainerState extends State<RoomContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Row(
        children: [
          Container(
            width: 117,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 30, 52, 77),
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(255, 34, 73, 104),
                  blurRadius: 1.0,
                  spreadRadius: 0.5,
                  offset: Offset(1, 1),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, bottom: 15, left: 14, right: 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.title,
                        style: const TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontSize: 10,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.line_axis,
                            color: widget.colorIcon,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            widget.count,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}


