import 'package:age/age.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:age_counter/age_generator.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  DateTime todaydate = DateTime.now();

  DateTime dob = DateTime(2000, 1, 1);

  late AgeDuration _ageDuration;
  late AgeDuration _nextbirthdate;
  late int _nextbdayweekday;

  List<String> _weeks = [
    "WEEKS",
    'MONDAY',
    'TUESDAY',
    'WEDNESDAY',
    'THURSDAY',
    'FRIDAY',
    'SATURDAY',
    'SUNDAY',
  ];

  List<String> _months = [
    "months",
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];

  Future<Null> _selecttodaydate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: todaydate,
      firstDate: dob,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != todaydate) {
      setState(() {
        todaydate = picked;
        _ageDuration = agecalculation().calculateage(todaydate, dob);
        _nextbirthdate = agecalculation().nextbirthday(todaydate, dob);
        _nextbdayweekday = agecalculation().nextbday(todaydate, dob);
      });
    }
  }

  Future<Null> _selectdobdate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dob,
      firstDate: DateTime(1900),
      lastDate: todaydate,
    );
    if (picked != null && picked != todaydate) {
      setState(() {
        dob = picked;
        _ageDuration = agecalculation().calculateage(todaydate, dob);
        _nextbirthdate = agecalculation().nextbirthday(todaydate, dob);
        _nextbdayweekday = agecalculation().nextbday(todaydate, dob);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _ageDuration = agecalculation().calculateage(todaydate, dob);
    _nextbirthdate = agecalculation().nextbirthday(todaydate, dob);
    _nextbdayweekday = agecalculation().nextbday(todaydate, dob);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(
                "AGE CALCULATOR",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
            ),
            //2row
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Today",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${todaydate.day} ${_months[todaydate.month]} ${todaydate.year}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: () {
                          _selecttodaydate(context);
                        },
                        icon: Icon(Icons.calendar_today_outlined),
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date Of Birth",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "${dob.day} ${_months[dob.month]} ${dob.year}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow.withOpacity(0.8),
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        icon: Icon(Icons.calendar_today_outlined),
                        onPressed: () {
                          setState(() {
                            _selectdobdate(context);
                          });
                        },
                        color: Colors.white,
                      ),
                    ],
                  )
                ],
              ),
            ),
            //detailsbox
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                //height: 450,
                decoration: BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "AGE",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${_ageDuration.years}",
                                    style: TextStyle(
                                        color: Colors.yellow, fontSize: 60),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 18.0),
                                    child: Text(
                                      "YEARS",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "${_ageDuration.months} months | ${_ageDuration.days} days",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                          Container(
                            width: 2,
                            color: Colors.grey,
                            height: 150,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "NEXT BIRTHDAY",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Icon(
                                Icons.cake,
                                color: Colors.yellow,
                                size: 45,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${_weeks[_nextbdayweekday]}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "${_nextbirthdate.months} months | ${_nextbirthdate.days} days",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Divider(
                        color: Colors.grey,
                        // height: 20,
                        thickness: 2,
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "SUMMARY",
                        style: TextStyle(
                          color: Colors.yellow,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "YEARS",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${_ageDuration.years}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "DAYS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${todaydate.difference(dob).inDays}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "MONTHS",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${((_ageDuration.years) * 12) + (_ageDuration.months)}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "HOURS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${todaydate.difference(dob).inHours}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "WEEKS",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${(todaydate.difference(dob).inDays / 7).floor()}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                "MINUTES",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                "${todaydate.difference(dob).inMinutes}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
