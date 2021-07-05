import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_samples/apps_clone/hotel_booking/custom_calendar.dart';
import 'package:flutter_samples/apps_clone/hotel_booking/theme.dart';
import 'package:intl/intl.dart';

class CalendarPopupView extends StatefulWidget {
  const CalendarPopupView({
    Key? key,
    required this.initialStartDate,
    required this.initialEndDate,
    required this.onApplyClick,
    required this.onCancelClick,
    this.barrierDismissible = true,
    required this.minimumDate,
    required this.maximumDate,
  }) : super(key: key);

  final DateTime minimumDate;
  final DateTime maximumDate;
  final bool barrierDismissible;
  final DateTime initialStartDate;
  final DateTime initialEndDate;
  final Function(DateTime, DateTime) onApplyClick;

  final Function onCancelClick;
  @override
  _CalendarPopupViewState createState() => _CalendarPopupViewState();
}

class _CalendarPopupViewState extends State<CalendarPopupView>
    with TickerProviderStateMixin {
  late final AnimationController _animationController;
  late DateTime _startDate;
  late DateTime _endDate;

  @override
  void initState() {
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _startDate = widget.initialStartDate;
    _endDate = widget.initialEndDate;
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) {
            return AnimatedOpacity(
              duration: const Duration(milliseconds: 100),
              opacity: _animationController.value,
              child: InkWell(
                splashColor: Colors.transparent,
                focusColor: Colors.transparent,
                highlightColor: Colors.transparent,
                hoverColor: Colors.transparent,
                onTap: () {
                  if (widget.barrierDismissible) Navigator.pop(context);
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: HotelAppTheme.buildLightTheme().backgroundColor,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            offset: const Offset(4, 4),
                            blurRadius: 8.0,
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(24.0)),
                        onTap: () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'From',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        DateFormat('EEE, dd MMM')
                                            .format(_startDate),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  height: 74.0,
                                  width: 1.0,
                                  color: HotelAppTheme.buildLightTheme()
                                      .dividerColor,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'To',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w100,
                                          fontSize: 16,
                                          color: Colors.grey.withOpacity(0.8),
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        DateFormat('EEE, dd MMM')
                                            .format(_endDate),
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const Divider(height: 1),
                            CustomCalendarView(
                              minimumDate: widget.minimumDate,
                              maximumDate: widget.maximumDate,
                              initialEndDate: widget.initialEndDate,
                              initialStartDate: widget.initialStartDate,
                              startEndDateChange: (startDateData, endDateData) {
                                setState(() {
                                  _startDate = startDateData;
                                  _endDate = endDateData;
                                });
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 16.0,
                                right: 16.0,
                                bottom: 16.0,
                                top: 8.0,
                              ),
                              child: Container(
                                height: 48.0,
                                decoration: BoxDecoration(
                                  color: HotelAppTheme.buildLightTheme()
                                      .primaryColor,
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(24.0)),
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.6),
                                      blurRadius: 8.0,
                                      offset: const Offset(4, 4),
                                    ),
                                  ],
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(24.0)),
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      try {
                                        // animationController.reverse().then((f) {});
                                        widget.onApplyClick(
                                            _startDate, _endDate);
                                        Navigator.pop(context);
                                      } catch (_) {}
                                    },
                                    child: Center(
                                      child: Text(
                                        'Apply',
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
