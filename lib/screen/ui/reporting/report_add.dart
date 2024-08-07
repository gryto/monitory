import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../src/constant.dart';
import '../../widget/custom_button_primary.dart';
import 'report_list.dart';
import 'report_page.dart';

class ReportAddpage extends StatefulWidget {
  const ReportAddpage({super.key});

  @override
  State<ReportAddpage> createState() => _ReportAddpageState();
}

class _ReportAddpageState extends State<ReportAddpage> {
  final ctrlTanggal = TextEditingController();
  final List<FocusNode> _focusNodes = [
    FocusNode(),
  ];

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final txtTanggal = Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          children: [
            TextFormField(
              focusNode: _focusNodes[0],
              controller: ctrlTanggal,
              // key: _formKey,
              decoration: InputDecoration(
                hoverColor: clrPrimary,
                hintText: 'Masukkan Tanggal Reservasi',
                label: Row(
                  children: [
                    Text(
                      "Tanggal Reservasi",
                      style: TextStyle(
                          color: _focusNodes[0].hasFocus
                              ? clrPrimary
                              : Colors.grey),
                    ),
                    const Text(
                      " *",
                      style: TextStyle(color: Colors.red),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                  ],
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  borderSide: BorderSide(color: Colors.grey),
                ),
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
                prefixIcon: Icon(
                  Icons.date_range,
                  color: _focusNodes[0].hasFocus ? clrPrimary : Colors.grey,
                ),
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Pilih Tanggal Terlebih Dahulu!';
                }
                return null;
              },
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2022),
                  lastDate: DateTime(2024),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: const ColorScheme.light(
                          primary: clrPrimary,
                          onPrimary: Colors.white,
                          onSurface: Colors.black,
                        ),
                        textButtonTheme: TextButtonThemeData(
                          style: TextButton.styleFrom(
                            foregroundColor: clrBadge,
                          ),
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (pickedDate != null) {
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  setState(
                    () {
                      ctrlTanggal.text = formattedDate;
                      print(ctrlTanggal.text.toString());
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: clrPrimary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          tooltip: 'Back',
          onPressed: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (context) => const ReportPage(),
                ),
                (Route<dynamic> route) => false);
          },
        ),
        title: const Text(
          "Buat MoM Kegiatan",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      color: clrShadow,
                      blurRadius: 1.0,
                      spreadRadius: 0.5,
                      offset: Offset(1, 1),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 15,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          "Pilih Tanggal Kegiatan",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      txtTanggal,
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.only(top: 20),
                        child: CustomButtonPrimary(
                          text: "Cari",
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ReportList(
                                    tanggal: ctrlTanggal.text.toString(),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
