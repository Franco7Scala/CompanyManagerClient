import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/widgets/for_users_managment/list_of_users.dart';
import 'package:company_manager_client/widgets/for_work_shift_managent/edit_user_work_shift.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

//get request for server
final getQuantityWorkingDaysThisMonthProvider=FutureProvider.family<int, int>((ref, id) async {
  final dio=ref.watch(dioProvider);
  final response=await dio.get(
    "${Constants.baseUrl}/workShifts/getQuantityWorkingDaysThisMonth/$id",
  );
  //debugPrint(response.toString());
  return response.data as int;
});

//get request for server
final getQuantityWorkingDaysPreviousMonthProvider=FutureProvider.family<int, int>((ref, id) async {
  final dio=ref.watch(dioProvider);
  final response=await dio.get(
    "${Constants.baseUrl}/workShifts/getQuantityWorkingDaysPreviousMonth/$id",
  );
  return response.data as int;
});

class ListWorkShiftUsers extends ConsumerWidget {
  const ListWorkShiftUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //watch providers
    final appLocalization=ref.watch(AppLocalizations.providers);
    final listOfUsers=ref.watch(listOfUsersProvider);
    
    //return list of user
    return listOfUsers.when(
      data: (users) {
        return Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: <DataColumn>[
                const  DataColumn(label: Text("N.")),
                DataColumn(label: Text(appLocalization.firstName!)),
                DataColumn(label: Text(appLocalization.lastName!)),
                const DataColumn(label: Text("Username")),
                DataColumn(label: Text(appLocalization.daysThisMonth!)),
                DataColumn(label: Text(appLocalization.daysPreviousMonth!)),
                DataColumn(label: Text(appLocalization.edit!)),
              ],
              rows: List<DataRow>.generate(
                users.length, 
                (index)  => DataRow(
                  cells: <DataCell> [
                    DataCell(Text((index+1).toString())),
                    DataCell(Text(users[index].firstName.toString())),
                    DataCell(Text(users[index].lastName.toString())),
                    DataCell(Text(users[index].username.toString())),
                    DataCell(
                      Center(
                        child: Text(
                          ref.watch(getQuantityWorkingDaysThisMonthProvider(users[index].id)).when(
                            data: (quantity) {
                              return quantity.toString();
                            }, 
                            error: ((error, stackTrace) => error.toString()), 
                            loading: () => "Loading...",
                          )
                        ),
                      ),
                    ),
                    DataCell(
                      Center(
                        child: Text(
                          ref.watch(getQuantityWorkingDaysPreviousMonthProvider(users[index].id)).when(
                            data: (quantity) {
                              return quantity.toString();
                            }, 
                            error: ((error, stackTrace) => error.toString()), 
                            loading: () => "Loading...",
                          )
                        ),
                      )
                    ),
                    DataCell(
                      Center(
                        child: IconButton(
                          onPressed: users[index].id != 1 ? () => showDialog(
                            context: context, 
                            builder: (BuildContext buildContext) => EditUserWorkShift(user: users[index],),
                          )
                          :
                          null,
                          icon: const Icon(Iconsax.edit_2),
                        ),
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }, 
      loading: () => const LoadingWidget(),
      error: ((error, stackTrace) => Text(error.toString())),
    );
      
  }
}


/*
ResponsiveLayout.isMobile(context) ? 
      ListView.builder(
        shrinkWrap: true,
        itemCount: listWorkShiftUsers.length,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: Text((index+1).toString(), style: const TextStyle(fontSize: 15.0),),
              title: Text("${listWorkShiftUsers[index].firstName} ${listWorkShiftUsers[index].lastName}"),
              subtitle: Text(listWorkShiftUsers[index].username),
              trailing: Wrap(
                alignment: WrapAlignment.end,
                spacing: 10.0,
                children: <Widget>[
                  IconButton(
                    onPressed: () => showDialog(
                      context: context, 
                      builder: (BuildContext context) => const EditUserWorkShift(),
                    ), 
                    tooltip: appLocalization.editUser,
                    icon: const Icon(Iconsax.edit,)
                  ),
                  
                ],
              ),
            ),
          );
        },
      )
*/


/* Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Row(
              children: <Widget>[
                const Text("N.", style: TextStyle(fontWeight: FontWeight.bold),),
                const SizedBox(width: 40.0,),
                Expanded(
                  child: Text(appLocalization.firstName!, style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: Text(appLocalization.lastName!, style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
                const Expanded(
                  child: Text("Username", style: TextStyle(fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: Text(appLocalization.daysThisMonth!, style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
                Expanded(
                  child: Text(appLocalization.daysPreviousMonth!, style: const TextStyle(fontWeight: FontWeight.bold),),
                ),
                const IconButton(
                  onPressed: null, 
                  icon: Icon(Iconsax.edit, color: Colors.transparent,)
                ),
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: listWorkShiftUsers.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Text((index+1).toString()),
                      const SizedBox(width: 40.0,),
                      Expanded(
                        child: Text(listWorkShiftUsers[index].firstName),
                      ),
                      Expanded(
                        child: Text(listWorkShiftUsers[index].lastName),
                      ),
                      Expanded(
                        child: Text(listWorkShiftUsers[index].username),
                      ),
                      const Expanded(
                        child: Text("0"),
                      ),
                      const Expanded(
                        child: Text("0"),
                      ),
                      IconButton(
                        onPressed: () => showDialog(
                          context: context, 
                          builder: (BuildContext context) => const EditUserWorkShift(),
                        ),
                        tooltip: appLocalization.editUser,
                        icon: const Icon(Iconsax.edit)
                      ),
                    ],
                  ),
                )
              );
            },
          ),
        ],
      ); */