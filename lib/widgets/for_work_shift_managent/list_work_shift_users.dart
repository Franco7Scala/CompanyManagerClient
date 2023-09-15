import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_work_shift_managent/edit_user_work_shift.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listWorkShiftUsers=[
  /* User(firstName: 'Andrea', lastName: 'Panebianco', username: 'anklnknac'),
  User(firstName: 'Claudia', lastName: 'benincasa', username: 'anksdvslnknac'),
  User(firstName: 'Pina', lastName: 'Salvati', username: 'cvwrvv') */
];

class ListWorkShiftUsers extends ConsumerWidget {
  const ListWorkShiftUsers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return ResponsiveLayout.isMobile(context) ? 
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
      : 
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
      );
  }
}
