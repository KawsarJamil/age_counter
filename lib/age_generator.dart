import 'package:age/age.dart';
import 'package:flutter/material.dart';

class agecalculation {
  AgeDuration calculateage(DateTime today, DateTime birthday) {
    AgeDuration age;
    age = Age.dateDifference(
        fromDate: birthday, toDate: today, includeToDate: false);
    return age;
  }

  AgeDuration nextbirthday(DateTime today, DateTime birthday) {
    DateTime temp = DateTime(today.year, birthday.month, birthday.day);

    DateTime nextbirthdaydate = temp.isBefore(today)
        ? Age.add(date: temp, duration: AgeDuration(years: 1))
        : temp;
    AgeDuration nextBirthdayDuration =
        Age.dateDifference(fromDate: today, toDate: nextbirthdaydate);
    return nextBirthdayDuration;
  }

  int nextbday(DateTime today, DateTime birthday) {
    DateTime temp = DateTime(today.year, birthday.month, birthday.day);
    DateTime nextBirthdayDate = temp.isBefore(today)
        ? Age.add(date: temp, duration: AgeDuration(years: 1))
        : temp;
    return nextBirthdayDate.weekday;
  }
}
