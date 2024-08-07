import 'package:flutter/material.dart';

import '../../src/constant.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final dynamic onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: clrSecondary,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: clrPrimary,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EditButton extends StatelessWidget {
  final String text;
  final dynamic onTap;
  const EditButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
            color: clrEdit,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            child: Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
