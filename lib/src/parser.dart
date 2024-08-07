import 'package:html/parser.dart';

removeHtml(html) {
  var doc = parse(html);
  if (doc.documentElement != null) {
    String parsedstring = doc.documentElement!.text;
    return stripHtmlIfNeeded(parsedstring);
  }
}

String stripHtmlIfNeeded(String text) {
  return text.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
}
