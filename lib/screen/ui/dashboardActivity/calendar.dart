import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../src/api.dart';
import '../../../src/constant.dart';
import '../../../src/dialog_info.dart';
import '../../../src/preference.dart';
import 'package:badges/badges.dart' as badges;

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  SharedPref sharedPref = SharedPref();
  bool isProcess = true;
  List listData = [];
  List listDataWaiting = [];
  List listDataFinished = [];
  List listDataCancelled = [];
  List listDataUnapproved = [];
  List arrBidangId = [];
  String dropdownName = "";

  final fieldKeyword = TextEditingController();

  final ScrollController _scrollController = ScrollController();
  var offset = 0;
  var limit = 2;
  var status = "";
  List<Color> _colorCollection = <Color>[];

  @override
  void initState() {
    checkSession();

    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          offset = offset + 10;
        });

        onGoing();
        waiting();
        finished();
        cancelled();
        unapproved();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void checkSession() async {
    onGoing();
    waiting();
    finished();
    cancelled();
    unapproved();
    _initializeEventColor();
  }

  onGoing() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.onGoingActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);
      if (content['status'] == true) {
        setState(() {
          if (listData.isEmpty) {
            listData = (content['data']);
          } else {
            //listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  waiting() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.waitingActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listDataWaiting.isEmpty) {
            listDataWaiting = (content['data']);
          } else {
            //listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  finished() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.finishedActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listDataFinished.isEmpty) {
            listDataFinished = (content['data']);
          } else {
            //listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  cancelled() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.cancelledActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listDataCancelled.isEmpty) {
            listDataCancelled = (content['data']);
          } else {
            //listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  unapproved() async {
    try {
      var accessToken = await sharedPref.getPref("access_token");
      var url = ApiService.unapprovedActivity;
      var uri = url;
      var bearerToken = 'Bearer $accessToken';
      var response = await http.get(Uri.parse(uri),
          headers: {"Authorization": bearerToken.toString()});
      var content = json.decode(response.body);

      if (content['status'] == true) {
        setState(() {
          if (listDataUnapproved.isEmpty) {
            listDataUnapproved = (content['data']);
          } else {
            //listData.addAll(content['data'].toList());
          }
        });
      } else {
        // ignore: use_build_context_synchronously
        onBasicAlertPressed(context, 'Error', content['message']);
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      // onBasicAlertPressed(context, 'Error', e.toString());
    }

    setState(() {
      isProcess = false;
    });
  }

  Future<void> _pullRefresh() async {
    setState(() {
      onGoing();
      waiting();
      finished();
      cancelled();
      unapproved();
    });
  }

  String dropdownValue = '';
  String? _subjectText = '',
      _startTimeText = '',
      _endTimeText = '',
      _dateText = '',
      _timeDetails = '',
      _location = '',
      _description = '';
  Object? _status;

  DateTime _convertDateFromString(String date) {
    return DateTime.parse(date);
  }

  void _initializeEventColor() {
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF36B37B));
    _colorCollection.add(const Color(0xFF01A1EF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color(0xFF0A8043));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: clrPrimary,
        scrolledUnderElevation: 0,
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Kalender Kegiatan",
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: SfCalendar(
        view: CalendarView.month,
        allowedViews: const [
          CalendarView.day,
          CalendarView.schedule,
          CalendarView.week,
          CalendarView.month,
        ],

        scheduleViewMonthHeaderBuilder: scheduleViewHeaderBuilder,

        monthViewSettings: const MonthViewSettings(showAgenda: true),
        dataSource: MeetingDataSource(
            listDataWaiting,
            listData,
            listDataFinished,
            listDataCancelled,
            listDataUnapproved,
            _colorCollection),
        onTap: calendarTapped,
      ),
    );
  }

  void calendarTapped(CalendarTapDetails details) {
    if (details.targetElement == CalendarElement.appointment ||
        details.targetElement == CalendarElement.agenda) {
      final Appointment appointmentDetails = details.appointments![0];
      _subjectText = appointmentDetails.subject;
      _dateText = DateFormat('MMMM dd, yyyy')
          .format(appointmentDetails.startTime)
          .toString();
      _startTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.startTime).toString();
      _endTimeText =
          DateFormat('hh:mm a').format(appointmentDetails.endTime).toString();
      _location = appointmentDetails.location;
      _description = appointmentDetails.notes;
      _status = appointmentDetails.id;

      if (appointmentDetails.isAllDay) {
        _timeDetails = 'All day';
      } else {
        _timeDetails = '$_startTimeText - $_endTimeText';
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              '$_subjectText',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                height: 160,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.date_range,
                          color: clrPrimary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          '$_dateText',
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.location_city,
                          color: clrPrimary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text('$_location'),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.timer,
                          color: clrPrimary,
                        ),
                        Text(_timeDetails!,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 15)),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        const Icon(
                          Icons.note,
                          color: clrPrimary,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Expanded(
                          child: Text(
                            '$_description',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    badges.Badge(
                      badgeStyle: badges.BadgeStyle(
                        shape: badges.BadgeShape.square,
                        borderRadius: BorderRadius.circular(5),
                        badgeColor: _status == 2
                            ? clrWait
                            : _status == 1
                                ? clrEdit
                                : _status == 3
                                    ? clrBadge
                                    : _status == 4
                                        ? clrDelete
                                        : clrTitle,
                      ),
                      // position: badges.BadgePosition.custom(start: 2, top: 2),
                      badgeContent: _status == 2
                          ? const Text(
                              "Sedang berlansung",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            )
                          : _status == 1
                              ? const Text(
                                  "Belum berlansung",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                )
                              : _status == 3
                                  ? const Text(
                                      "Selesai",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    )
                                  : _status == 4
                                      ? const Text(
                                          "Batal",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : const Text(
                                          "Tidak Disetujui",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                    ),
                  ],
                ),
              ),
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Tutup'))
            ],
          );
        },
      );
    }
  }
}

class MeetingDataSource extends CalendarDataSource {
  List<Color> _colorCollection = <Color>[];

  DateTime convertDateFromString(String dateString) {
    // Define the Indonesian locale identifier
    var idLocale = 'id_ID';

    // Define the date format for the provided string
    var dateFormat = DateFormat("EEEE, dd MMMM yyyy", idLocale);

    // Parse the string into a DateTime object
    DateTime dateTime = dateFormat.parse(dateString);

    return dateTime;
  }

  DateTime convertTimeFromString(String timeString) {
    // Define the time format for the provided string
    var timeFormat = DateFormat("HH:mm");

    // Parse the string into a DateTime object
    DateTime dateTime = timeFormat.parse(timeString);

    // Since we're only parsing time, set a default date (e.g., today)
    DateTime today = DateTime.now();
    dateTime = DateTime(
        today.year, today.month, today.day, dateTime.hour, dateTime.minute);

    return dateTime;
  }

  MeetingDataSource(
      List<dynamic> sourceWaiting,
      List<dynamic> sourceOngoing,
      List<dynamic> sourceFinished,
      List<dynamic> sourceCancelled,
      List<dynamic> sourceUnapproved,
      this._colorCollection) {
    final Random random = Random();

    appointments = [
      ...sourceWaiting,
      ...sourceOngoing,
      ...sourceFinished,
      ...sourceCancelled,
      ...sourceUnapproved
    ].map((data) {
      DateTime startDate = convertDateFromString(data['tgl_kegiatan']);
      DateTime startTime = convertTimeFromString(data['waktu']);
      DateTime endTime = startDate
          .add(Duration(hours: startTime.hour, minutes: startTime.minute));

      Color appointmentColor;

      if (sourceWaiting.contains(data)) {
        appointmentColor = clrEdit;
      } else if (sourceOngoing.contains(data)) {
        appointmentColor = clrWait;
      } else if (sourceFinished.contains(data)) {
        appointmentColor = clrBadge;
      } else if (sourceCancelled.contains(data)) {
        appointmentColor = clrDelete;
      } else if (sourceUnapproved.contains(data)) {
        appointmentColor = clrTitle;
      } else {
        // Default color if not in any specific source
        appointmentColor =
            _colorCollection[random.nextInt(_colorCollection.length)];
      }

      return Appointment(
        startTime: startDate,
        endTime: endTime,
        subject: data['nama_kegiatan'] ?? "-",
        color: appointmentColor,
        isAllDay: false,
        location: data['ruangan_name'] ?? "-",
        id: data['status'],
        notes: data['deskripsi'] ?? "-",
      );
    }).toList();
  }
}

Widget scheduleViewHeaderBuilder(
    BuildContext buildContext, ScheduleViewMonthHeaderDetails details) {
  final String monthName = _getMonthName(details.date.month);
  return Stack(
    children: [
      Image(
          image: ExactAssetImage('assets/images/$monthName.png'),
          fit: BoxFit.cover,
          width: details.bounds.width,
          height: details.bounds.height),
      Positioned(
        left: 55,
        right: 0,
        top: 20,
        bottom: 0,
        child: Text(
          '$monthName ${details.date.year}',
          style: const TextStyle(fontSize: 18),
        ),
      )
    ],
  );
}

String _getMonthName(int month) {
  if (month == 01) {
    return 'Januari';
  } else if (month == 02) {
    return 'Februari';
  } else if (month == 03) {
    return 'Maret';
  } else if (month == 04) {
    return 'April';
  } else if (month == 05) {
    return 'Mei';
  } else if (month == 06) {
    return 'Juni';
  } else if (month == 07) {
    return 'Juli';
  } else if (month == 08) {
    return 'Agustus';
  } else if (month == 09) {
    return 'September';
  } else if (month == 10) {
    return 'Oktober';
  } else if (month == 11) {
    return 'November';
  } else {
    return 'Desember';
  }
}
