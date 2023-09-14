import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/user.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_users_managment/delete_user.dart';
import 'package:company_manager_client/widgets/for_users_managment/edit_user.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfUsersProvider=FutureProvider<List<User>>((ref) async {
  await Future.delayed(const Duration(seconds: 1));
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}/users");
  final data = response.data;
  return List<User>.from(data.map((userJson) => User.fromJson(userJson)));
}); 

class ListOfUsers extends ConsumerWidget {
  const ListOfUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    final listOfUsers=ref.watch(listOfUsersProvider);

    return listOfUsers.when(
      data: (users) { 
        return Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              dividerThickness: 1.0,
              columnSpacing: ResponsiveLayout.isDesktop(context) ? 100.0 : null,
              columns: <DataColumn>[
                const DataColumn(label: Text("N.")),
                DataColumn(label: Text(appLocalization.firstName!)),
                DataColumn(label: Text(appLocalization.lastName!)),
                const DataColumn(label: Text("Username")),
                DataColumn(label: Center(child: Text(appLocalization.edit!))),
                DataColumn(label: Center(child: Text(appLocalization.delete!))),
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
                        child: IconButton(
                          onPressed: users[index].id != 1 ? () => showDialog(
                            context: context, 
                            builder: (BuildContext buildContext) => EditUser(user: users[index],),
                          )
                          :
                          null,
                          //tooltip: appLocalization.editUser,
                          icon: const Icon(Iconsax.edit_2),
                        ),
                      )
                    ),
                    DataCell(
                      Center(
                        child: IconButton(
                          onPressed: users[index].id != 1 ? () => showDialog(
                            context: context, 
                            builder: (BuildContext buildContext) => DeleteUser(user: users[index],),
                          )
                          :
                          null,
                          //tooltip: appLocalization.deleteUser,
                          icon: const Icon(Iconsax.trash),
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

//layout for mobile
      Card(
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: listOfUsers.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: Text((index+1).toString(), style: const TextStyle(fontSize: 15.0),),
              title: Text("${listOfUsers[index].firstName} ${listOfUsers[index].lastName}"),
              subtitle: Text(listOfUsers[index].username),
              trailing: Wrap(
                alignment: WrapAlignment.end,
                spacing: 10.0,
                children: <Widget>[
                  IconButton(
                    onPressed: () => showDialog(
                      context: context, 
                      builder: (BuildContext context) => const EditUser(),
                    ), 
                    tooltip: appLocalization.editUser,
                    icon: const Icon(Iconsax.user_edit4)
                  ),
                  IconButton(
                    onPressed: () {}, 
                    tooltip: appLocalization.deleteUser,
                    icon: const Icon(Iconsax.trash)
                  )
                ],
              ),
            );
          },
        ),
      )

*/


/*

Column(
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
                const IconButton(
                  onPressed: null, 
                  icon: Icon(Iconsax.edit, color: Colors.transparent,)
                ),
                const SizedBox(width: 10.0,),
                const IconButton(
                  onPressed: null, 
                  icon: Icon(Iconsax.trash, color: Colors.transparent,)
                )
              ],
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: listOfUsers.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: <Widget>[
                      Text((index+1).toString()),
                      const SizedBox(width: 40.0,),
                      Expanded(
                        child: Text(listOfUsers[index].firstName),
                      ),
                      Expanded(
                        child: Text(listOfUsers[index].lastName),
                      ),
                      Expanded(
                        child: Text(listOfUsers[index].username),
                      ),
                      IconButton(
                        onPressed: () => showDialog(
                          context: context, 
                          builder: (BuildContext context) => const EditUser(),
                        ),
                        tooltip: appLocalization.editUser,
                        icon: const Icon(Iconsax.edit)
                      ),
                      const SizedBox(width: 10.0,),
                      IconButton(
                        onPressed: () {}, 
                        tooltip: appLocalization.deleteUser,
                        icon: const Icon(Iconsax.trash, color: Colors.red,)
                      )
                    ],
                  ),
                )
              );
            },
          ),
        ],
      );

*/