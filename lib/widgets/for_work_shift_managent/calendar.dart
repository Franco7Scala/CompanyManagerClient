import 'package:company_manager_client/model/event.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/change_theme_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends ConsumerState<Calendar> {
  Map<DateTime, List<Event>> selectedEvents = {
    DateTime.now(): [Event(title: "ciao"), Event(title: "hola")],
  };
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();

  List<Event> _getEventsfromDay(DateTime date) {
    return selectedEvents[date] ?? [];
  }
  
  @override
  Widget build(BuildContext context) {
    final isDarkTheme=ref.watch(isDarkThemeProvider);

    return Column(
        children: [
          Card(
            child: TableCalendar(
              focusedDay: selectedDay,
              firstDay: DateTime(1990),
              lastDay: DateTime(2101),
              calendarFormat: format,
              onFormatChanged: (CalendarFormat _format) {
                setState(() {
                  format = _format;
                });
              },
              startingDayOfWeek: StartingDayOfWeek.monday,
              daysOfWeekVisible: true,
          
              //Day Changed
              onDaySelected: (DateTime selectDay, DateTime focusDay) {
                setState(() {
                  selectedDay = selectDay;
                  focusedDay = focusDay;
                });
                print(focusedDay);
              },
              selectedDayPredicate: (DateTime date) {
                return isSameDay(selectedDay, date);
              },
          
              eventLoader: _getEventsfromDay,
          
              //To style the Calendar
              calendarStyle: CalendarStyle(
                tablePadding: const EdgeInsets.only(bottom: 20.0, top: 20.0),
                isTodayHighlighted: true,
                selectedDecoration: BoxDecoration(
                  color: isDarkTheme ? Colors.grey[500] : Colors.grey[700],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                selectedTextStyle: const TextStyle(color: Colors.white),
                todayDecoration: BoxDecoration(
                  color: isDarkTheme ? Colors.grey[800] : Colors.black,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                defaultDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                weekendDecoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
              
              headerStyle: HeaderStyle(
                headerPadding: const EdgeInsets.only(top: 20.0),
                formatButtonVisible: true,
                //titleCentered: true,
                titleTextStyle: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: ResponsiveLayout.isMobile(context) ? 15.0 : 25.0,
                ),
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  //color: Colors.black,
                  border: Border.all(color: isDarkTheme ? Colors.white : Colors.black),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                formatButtonTextStyle: TextStyle(
                  color: isDarkTheme ? Colors.white : Colors.black,
                ),
              ),

            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: _getEventsfromDay(selectedDay).length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(_getEventsfromDay(selectedDay).elementAt(index).toString()),
              );
              
            }
          ),
          
        ],
      );
  }

  
}