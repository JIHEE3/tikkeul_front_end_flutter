import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:tikkeul/templates/main_layout.dart';

class AccountBook extends StatefulWidget {
  const AccountBook({Key? key}) : super(key: key);

  @override
  State<AccountBook> createState() => _AccountBookState();
}

class _AccountBookState extends State<AccountBook> {
  DateTime? _selectedDay;
  DateTime _focusedDay = DateTime.now();

  final Map<DateTime, List> _events = {
    DateTime(2022, 5, 1): ['Event 1'],
    DateTime(2022, 5, 3): ['Event 1'],
    DateTime(2022, 5, 17): ['Event 1'],
    DateTime(2022, 5, 21): ['Event 1'],
    DateTime(2022, 5, 28): ['Event 1'],
    DateTime(2022, 5, 31): ['Event 1'],
  };

  Widget _dayBuilder(context, DateTime day, focusedDay) {
    final text = day.day.toString();
    var result = _events[DateTime(
          day.year,
          day.month,
          day.day,
        )] ??
        [];

    final now = DateTime.now();
    var isToday = false;
    var isSelectedDay = false;
    Color? dayTextColor = Colors.blueGrey[800];
    Color? inputTextColor = Colors.teal[900];
    Color? outputTextColor = Colors.deepOrange[800];

    if ((now.year == day.year &&
        now.month == day.month &&
        now.day == day.day)) {
      isToday = true;
    }
    if ((_selectedDay != null &&
        _selectedDay?.year == day.year &&
        _selectedDay?.month == day.month &&
        _selectedDay?.day == day.day)) {
      isSelectedDay = true;
    }
    if (isToday || isSelectedDay) {
      dayTextColor = Colors.white;
      inputTextColor = Colors.white;
      outputTextColor = Colors.white;
    }

    final dayWidget = Column(
      children: [
        Text(
          text,
          style: TextStyle(
            color: dayTextColor,
          ),
        ),
        Text(
          '+10000',
          style: TextStyle(
            fontSize: 9,
            color: inputTextColor,
          ),
        ),
        Text(
          '-10',
          style: TextStyle(
            fontSize: 9,
            color: outputTextColor,
          ),
        ),
      ],
    );

    return Container(
      padding: EdgeInsets.all(5),
      margin: EdgeInsets.all(1),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: isSelectedDay
            ? Theme.of(context).colorScheme.secondary
            : isToday
                ? Theme.of(context).colorScheme.primary.withOpacity(0.7)
                : null,
      ),
      child: dayWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainLayout(
      childrenWidget: Container(
        child: TableCalendar(
          locale: 'ko-KR',
          firstDay: DateTime.utc(2010, 01, 01),
          lastDay: DateTime.utc(2030, 12, 23),
          focusedDay: _focusedDay,
          // focusedDay: DateTime.now(),
          headerStyle: HeaderStyle(
            // headerMargin:
            // EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 10),
            titleCentered: true,
            formatButtonVisible: false,
          ),
          calendarStyle: CalendarStyle(
            weekendTextStyle: TextStyle().copyWith(color: Colors.pink),
            holidayTextStyle: TextStyle().copyWith(color: Colors.pink),
          ),
          daysOfWeekHeight: 40,
          selectedDayPredicate: (day) {
            return (isSameDay(_selectedDay, day));
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay) &&
                // 이전달, 다음달 날짜 선택되지 않도록
                (selectedDay.month == focusedDay.month)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          calendarBuilders: CalendarBuilders(
            defaultBuilder: _dayBuilder,
            todayBuilder: _dayBuilder,
            selectedBuilder: _dayBuilder,
          ),
        ),
      ),
    );
  }
}
