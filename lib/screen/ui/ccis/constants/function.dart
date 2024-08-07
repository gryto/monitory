import 'package:intl/intl.dart';
import 'package:html/parser.dart';

String formatDmyHis(val) {
  final DateFormat dateFormate = DateFormat("dd-MM-yyyy hh:mm:ss");
  String formatted = dateFormate.format(DateTime.parse(val.toString()));

  return formatted;
}

String formatDmy(val) {
  final DateFormat dateFormate = DateFormat("dd-MM-yyyy");
  String formatted = dateFormate.format(DateTime.parse(val.toString()));

  return formatted;
}

String formatHis(val) {
  final DateFormat dateFormate = DateFormat("hh:mm:ss");
  String formatted = dateFormate.format(DateTime.parse(val.toString()));

  return formatted;
}

extension DateTimeExtension on DateTime {
  String nowDate(val) {
    return DateFormat('d MMMM y').format(this);
  }

  String dueDate() {
    DateTime due = this;
    Duration diff = due.difference(DateTime.now());

    if (diff.inDays > 1) {
      return "${diff.inDays} Days";
    } else if (diff.inHours > 1) {
      return "${diff.inHours} Hours";
    } else if (diff.inMinutes > 1) {
      return "${diff.inMinutes} Minutes";
    } else if (diff.inSeconds > 1) {
      return "${diff.inSeconds} Seconds";
    } else {
      return "Is Overdue";
    }
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }

  String getInitialName([int max = 2]) {
    String val = this;

    List<String> explode = val.split(" ");
    explode.removeWhere((element) => element.trim().isEmpty);

    String result = "";

    for (int i = 0; i < max; i++) {
      if (i < explode.length) {
        result += explode[i].split("").first;
      } else {
        break;
      }
    }

    return result;
  }
}

formatDouble(str) {
  String newStr = str.replaceAll(',', '');
  return newStr;
}

monthName(i) {
  String txt;
  switch (i) {
    case 0:
      txt = 'Januari';
      break;
    case 1:
      txt = 'Februari';
      break;
    case 2:
      txt = 'Maret';
      break;
    case 3:
      txt = 'April';
      break;
    case 4:
      txt = 'Mei';
      break;
    case 5:
      txt = 'Juni';
      break;
    case 6:
      txt = 'Juli';
      break;
    case 7:
      txt = 'Agustus';
      break;
    case 8:
      txt = 'September';
      break;
    case 9:
      txt = 'Oktober';
      break;
    case 10:
      txt = 'November';
      break;
    case 11:
      txt = 'Desember';
      break;

    default:
      txt = '';
      break;
  }

  return txt;
}

removeHtmlString(String htmlString) {
  final document = parse(htmlString);
  final String parsedString = parse(document.body!.text).documentElement!.text;

  return parsedString;
}
