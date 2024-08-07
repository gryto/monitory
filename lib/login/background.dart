import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import '../src/constant.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: size.height,
      child: Stack(
        children: <Widget>[
          Container(
            height: 250,
            decoration: const BoxDecoration(
              color: clrPrimary,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0)),
            ),
          ),
            Positioned(
              top: 4.h,
              left: 8.w,
              right: 25,
              child: Image.asset("assets/images/amico.png", width: size.width),
            ),
          child
        ],
      ),
    );
  }
}
