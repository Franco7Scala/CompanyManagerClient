import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/user.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/change_theme_button.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:table_calendar/table_calendar.dart';

final getUsersInDayProvider=FutureProvider.autoDispose.family<List<User>, DateTime>((ref, date) async {
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}/workShifts/getUsersInDay/${date.toIso8601String()}");
  final data = response.data;
  return List<User>.from(data.map((userJson) => User.fromJson(userJson)));
});

class Calendar extends ConsumerStatefulWidget {
  const Calendar({super.key});

  @override
  CalendarState createState() => CalendarState();
}

class CalendarState extends ConsumerState<Calendar> {
  
  CalendarFormat format = CalendarFormat.month;
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  
  @override
  Widget build(BuildContext context) {
    //watch providers
    final isDarkTheme=ref.watch(isDarkThemeProvider);
    final appLocalization=ref.watch(AppLocalizations.providers);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          child: TableCalendar(
            focusedDay: selectedDay,
            firstDay: DateTime(1990),
            lastDay: DateTime(2101),
            calendarFormat: format,
            onFormatChanged: (CalendarFormat format) {
              setState(() {
                this.format = format;
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
              //print(focusedDay);
            },
            selectedDayPredicate: (DateTime date) {
              return isSameDay(selectedDay, date);
            },
        
            //style the Calendar
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
        const SizedBox(height: 20.0,),
        //show users in selected day
        ref.watch(getUsersInDayProvider(selectedDay)).when(
          data: (users) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${appLocalization.day!}: ${selectedDay.day} - ${selectedDay.month} - ${selectedDay.year}",
                      style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10.0,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: <DataColumn> [
                          DataColumn(label: Text(appLocalization.firstName!)),
                          DataColumn(label: Text(appLocalization.lastName!)),
                          const DataColumn(label: Text("Username")),
                        ],
                        rows: List.generate(
                          users.length, 
                          (index) => DataRow(
                            cells: <DataCell> [
                              DataCell(Text(users[index].firstName!)),
                              DataCell(Text(users[index].lastName!)),
                              DataCell(Text(users[index].username!)),
                            ]
                          )
                        )
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const LoadingWidget(),
          error: (error, stackTrace) => Text(error.toString()),),
      ],
    );
  }

  
}