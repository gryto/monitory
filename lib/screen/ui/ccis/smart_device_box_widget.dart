import 'package:flutter/material.dart';

class SmartDeviceBoxWidget extends StatelessWidget {
  final String smartDeviceName;
  final Gradient smartDeviceColor;
  final ImageProvider imageProvider;
  final double? width;
  final double? heightImage;

  const SmartDeviceBoxWidget({
    Key? key,
    required this.smartDeviceName,
    required this.smartDeviceColor,
    required this.imageProvider,
    required this.width,
    this.heightImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          gradient: smartDeviceColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(255, 23, 56, 82),
              blurRadius: 1.0,
              spreadRadius: 0.5,
              offset: Offset(1, 1),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Container(
          padding: const EdgeInsets.all(2),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Image(
                image: imageProvider,
                width: width,
                height: heightImage,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 15,
              ),
              Text(smartDeviceName,
                  style: const TextStyle(fontSize: 28, color: Colors.white),
                  textAlign: TextAlign.center)
            ],
          ),
        ),
      ),
    );
  }
}
