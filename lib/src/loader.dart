import 'package:flutter/material.dart';
import 'constant.dart';

loaderDialog(BuildContext context) {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.grey,
      valueColor: AlwaysStoppedAnimation<Color>(clrPrimary),
    ),
  );
}

loaderDialogLead(BuildContext context) {
  return const Padding(
    padding: EdgeInsets.only(bottom: 20),
    child: Center(
      child: CircularProgressIndicator(
        backgroundColor: Colors.grey,
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xff3cd2a5)),
      ),
    ),
  );
}
