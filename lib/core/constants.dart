import 'package:flutter/material.dart';

const Divider divider = Divider(height: 1, indent: 15, endIndent: 15);
const SizedBox spacer = SizedBox(height: 10);
const pagePadding = EdgeInsets.all(10.0);
final listTileShape =
    RoundedRectangleBorder(borderRadius: BorderRadius.circular(5));

class Constants {
  static const double buttonSheetHeight = 50.0;
  static const String apiUrl = "";
  static const String apiKey = '';
  static const String unicodeChar = '\u202E';
  static const String selectedLang = 'English';
  static const String scaffoldTitle = "دانشگاه علوم پزشکی اصفهان";
  static const String appTitle = "دارویاب";
  static const String appDescription = "اپلیکیشن تخصصی دارویاب";
}
