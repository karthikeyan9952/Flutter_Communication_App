import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension ContextExtension on BuildContext {
  double widthFull() => MediaQuery.of(this).size.width;
  double heightFull() => MediaQuery.of(this).size.height;
  double widthHalf() => MediaQuery.of(this).size.width / 2;
  double heightHalf() => MediaQuery.of(this).size.height / 2;
  double widthQuarter() => MediaQuery.of(this).size.width / 3;
  double heightQuarter() => MediaQuery.of(this).size.height / 3;
}

String getFormatedDate(String date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'").parse(date);
  DateTime inputDate = DateTime.parse(parseDate.toString());
  String outputDate = DateFormat('dd MMM yyyy').format(inputDate);
  return outputDate;
}

String getFormatedDateNew(String date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
  DateTime inputDate = DateTime.parse(parseDate.toString());
  String outputDate = DateFormat('dd MMM yy').format(inputDate);
  return outputDate;
}

String getFormatedMonthYear(String date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd HH:mm:ss").parse(date);
  DateTime inputDate = DateTime.parse(parseDate.toString());
  String outputDate = DateFormat('MMM yyyy').format(inputDate);
  return outputDate;
}

String getFormatedDateTime(String date) {
  DateTime parseDate = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
      .parse(date)
      .add(const Duration(hours: 5, minutes: 30));
  DateTime inputDate = DateTime.parse(parseDate.toString());
  String outputDate = DateFormat('dd-MM-yyyy - hh:mm a').format(inputDate);
  return outputDate;
}
