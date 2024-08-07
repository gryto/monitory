import 'package:flutter/material.dart';
import '../../src/constant.dart';

class CustomContainer extends StatefulWidget {
  final String title;
  final String description;
  final String createDate;
  const CustomContainer({
    super.key,
    required this.title,
    required this.description,
    required this.createDate,
  });

  @override
  State<CustomContainer> createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        width: 175,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: clrSecondary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.title,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              widget.description,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Container(
                  height: 12,
                  width: 12,
                  decoration: BoxDecoration(
                    color: Colors.green.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  widget.createDate,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
