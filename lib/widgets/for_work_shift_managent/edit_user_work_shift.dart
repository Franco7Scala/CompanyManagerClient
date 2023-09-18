import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/user.dart';
import 'package:company_manager_client/models/working_day.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_work_shift_managent/list_work_shift_users.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

//request post to add working day
final addWorkingDayProvider=FutureProvider.family<void, WorkingDay>((ref, workingDay) async {
  final dio=ref.watch(dioProvider);
  await dio.post(
    "${Constants.baseUrl}/workShifts",
    data: workingDay.toJson(),
  );
  // ignore: unused_result
  ref.refresh(getWorkingDayForUserProvider(workingDay.idUser));
  // ignore: unused_result
  ref.refresh(getQuantityWorkingDaysThisMonthProvider(workingDay.idUser));
  // ignore: unused_result
  ref.refresh(getQuantityWorkingDaysPreviousMonthProvider(workingDay.idUser));
});

//get request to show working day for user id
final getWorkingDayForUserProvider=FutureProvider.family<List<WorkingDay>, int>((ref, idUser) async {
  final dio=ref.watch(dioProvider);
  final response=await dio.get(
    "${Constants.baseUrl}/workShifts/getWorkingDaysForUser/$idUser"
  );
  final data = response.data;
  return List<WorkingDay>.from(data.map((workingDayJson) => WorkingDay.fromJson(workingDayJson)));
});

//put request to remove working day (set visible = false) for user id
final removeWorkingDayForUserProvider=FutureProvider.family<void, WorkingDay>((ref, workingDay) async {
  final dio=ref.watch(dioProvider);
  await dio.put(
    "${Constants.baseUrl}/workShifts/removeWorkingDay",
    data: workingDay.toJson(),
  );
  // ignore: unused_result
  ref.refresh(getWorkingDayForUserProvider(workingDay.idUser));
});

// ignore: must_be_immutable
class EditUserWorkShift extends ConsumerStatefulWidget {
  User user;

  EditUserWorkShift({
    required this.user,
    super.key
  });

  @override
  EditUserWorkShiftState createState() => EditUserWorkShiftState();
}

class EditUserWorkShiftState extends ConsumerState<EditUserWorkShift> {
  //controller and variable to manage date
  //final dateController=TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    //watch providers
    final appLocalization=ref.watch(AppLocalizations.providers);
    //final getWorkingDayForUser=ref.watch(getWorkingDayForUserProvider(widget.user.id));

    //data picker for chooese working day for user
    Future<void> selectDate() async {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),
        cancelText: appLocalization.cancel,
        confirmText: appLocalization.addDay,
      );
      if (picked != null && picked != _selectedDate) {
        setState(() {
          _selectedDate = picked;
          //dateController.text = "${picked.day}/${picked.month}/${picked.year}";
          //debugPrint(_selectedDate.toIso8601String());
        });
      }
    }

    //widget
    return AlertDialog(
      title: Wrap(
        spacing: 10.0,
        runSpacing: 5.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Icon(Iconsax.user_edit, size: 30,),
          Text(
            "${widget.user.firstName} ${widget.user.lastName}", 
            style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ],
      ),
      scrollable: true,
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 10.0,),
            //summary    
            Text(appLocalization.summary!, style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 10.0,),
            //show summary
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0)
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: <DataColumn> [
                    DataColumn(label: Text(appLocalization.month!)),
                    DataColumn(label: Text(appLocalization.days!)),
                    DataColumn(label: Text(appLocalization.salary!)),
                  ], 
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text(appLocalization.thisMonth!)),
                        DataCell(
                          Center(
                            child: Text(
                              ref.watch(getQuantityWorkingDaysThisMonthProvider(widget.user.id)).when(
                                data: (quantity) {
                                  return quantity.toString();
                                }, 
                                error: ((error, stackTrace) => error.toString()), 
                                loading: () => "Loading...",
                              )
                            ),
                          ),
                        ),
                        const DataCell(Text("-")),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(appLocalization.previousMonth!)),
                        DataCell(
                          Center(
                            child: Text(
                              ref.watch(getQuantityWorkingDaysPreviousMonthProvider(widget.user.id)).when(
                                data: (quantity) {
                                  return quantity.toString();
                                }, 
                                error: ((error, stackTrace) => error.toString()), 
                                loading: () => "Loading...",
                              )
                            ),
                          )
                        ),
                        const DataCell(Text("-")),
                      ],
                    ),
                  ]
                ),
              ),
            ),
            const SizedBox(height: 30.0,),
            //add working day
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalization.days!, style: const TextStyle(fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: () async {
                    //choose work date
                    await selectDate(); 
                    //create workign day
                    WorkingDay workingDay=WorkingDay(
                      visible: true,
                      idUser: widget.user.id, 
                      workDate: _selectedDate,
                      inTime: _selectedDate,
                      outTime: _selectedDate,
                      description: "",
                    );
                    //send request to add working day
                    ref.watch(addWorkingDayProvider(workingDay));
                  },
                  tooltip: appLocalization.addDay,
                  icon: const Icon(Iconsax.add) 
                ),
              ],
            ),
            const SizedBox(height: 5.0,),
            //show working day
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0)
              ),
              child: ref.watch(getWorkingDayForUserProvider(widget.user.id)).when(
                data: (workingDays) => SingleChildScrollView(
                  child: Column(
                    children: workingDays.length!=0 ? List.generate(
                      workingDays.length, 
                      (index) { 
                        if(workingDays[index].visible) {
                          return ListTile(
                            title: Text("${workingDays[index].workDate.day} - ${workingDays[index].workDate.month} - ${workingDays[index].workDate.year}"),
                            trailing: IconButton(
                              onPressed: () {
                                ref.watch(removeWorkingDayForUserProvider(workingDays[index]));
                              },
                              icon: const Icon(Iconsax.trash),
                            )
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      }
                    ) 
                    : 
                    [
                      ListTile(title: Text(appLocalization.noResult!),),
                    ],
                  ),
                ),
                loading: () => const  ListTile(title: LoadingWidget(),),
                error: ((error, stackTrace) => ListTile(title: Text(error.toString()),))
              ),
            ),
          ],
        ),
      ),
      //action button alert dialog
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocalization.back!),
        ),
        /* SizedBox(
          width: 5.0,
          height: MediaQuery.of(context).size.width <= 366.0 ? 10.0 : null, 
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocalization.editUser!),
        ) */
      ],
    );
  }
}

/*

SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: <DataColumn> [
                    DataColumn(label: Text(appLocalization.date!)),
                    const DataColumn(label: Text("")),
                  ], 
                  rows: ref.watch(getWorkingDayForUserProvider(widget.user.id)).when(
                    data: (workingDays) {
                      return List.generate(
                        workingDays.length, 
                        (index) => DataRow(
                          cells: <DataCell> [
                            DataCell(Text("${workingDays[index].workDate.day} - ${workingDays[index].workDate.month} - ${workingDays[index].workDate.year}")),
                            DataCell(
                              IconButton(
                                onPressed: () {

                                },
                                icon: const Icon(Iconsax.trash),
                              )
                            )
                          ]
                        )
                      );
                    }, 
                    loading: () => [const DataRow(cells: [DataCell(Text("Loading...")), DataCell(Text("Loading..."))])],
                    error: ((error, stackTrace) => [DataRow(cells: [DataCell(Text(error.toString())), DataCell(Text(error.toString()))])]), 
                  )
                ),
              ),

*/