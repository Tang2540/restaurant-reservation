import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarComponent extends StatefulWidget {
  final Set<DateTime> reservedDates;
  final DateTime? selectedDate;
  final Function(DateTime) onDaySelected;

  const CalendarComponent({
    Key? key,
    required this.reservedDates,
    required this.selectedDate,
    required this.onDaySelected,
  }) : super(key: key);

  @override
  State<CalendarComponent> createState() => _CalendarComponentState();
}

class _CalendarComponentState extends State<CalendarComponent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime _focusedDay;

  @override
  void initState() {
    super.initState();
    _focusedDay = DateTime.now();
  }

  bool _isSameDay(DateTime? a, DateTime? b) {
    if (a == null || b == null) return false;
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.now(),
      lastDay: DateTime.now().add(Duration(days: 365)),
      focusedDay: _focusedDay,
      calendarFormat: _calendarFormat,
      selectedDayPredicate: (day) => _isSameDay(widget.selectedDate, day),
      onDaySelected: (selectedDay, focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
        widget.onDaySelected(selectedDay);
      },
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      onPageChanged: (focusedDay) {
        setState(() {
          _focusedDay = focusedDay;
        });
      },
      calendarStyle: CalendarStyle(
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(color: Colors.white),
        disabledTextStyle: TextStyle(color: Colors.red),
        disabledDecoration: BoxDecoration(
          color: Colors.red[100],
          shape: BoxShape.circle,
        ),
      ),
      enabledDayPredicate: (day) {
        return !widget.reservedDates.any((reservedDate) =>
            reservedDate.year == day.year &&
            reservedDate.month == day.month &&
            reservedDate.day == day.day);
      },
    );
  }
}
