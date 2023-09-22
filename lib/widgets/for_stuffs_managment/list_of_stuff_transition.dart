import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/stuff.dart';
import 'package:company_manager_client/models/stuff_transition.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/list_of_stuffs.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfStuffTransitionProvider=FutureProvider<List<StuffTransition>>((ref) async {
  const endPoint="/stuffs/getAllStuffTransitions";
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}$endPoint");
  final data=response.data;
  return List<StuffTransition>.from(data.map((stuffTransitionJson) => StuffTransition.fromJson(stuffTransitionJson)));
});

class ListOfStuffTransition extends ConsumerWidget {
  const ListOfStuffTransition({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Stuff? findStuffByStuffTransitionId(List<Stuff> listOfStuffs, int stuffTransitionId) {
      for (final stuff in listOfStuffs) {
        final materialeTransTrovato = stuff.stuffTransitionList!.firstWhere(
          (stuffTransition) => stuffTransition.id == stuffTransitionId,
          orElse: () => StuffTransition(id: -1),
        );
        if (materialeTransTrovato.id != -1) {
          return stuff;
        }
      }
      return null; 
    }

    return ref.watch(getAllStuffsProvider).when(
      data: (listOfStuff) {
        if(listOfStuff.isNotEmpty) {
          return ref.watch(listOfStuffTransitionProvider).when(
            data: (listOfStuffTransition) {
              return Card(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(label: Text(appLocalization.date!)),
                      DataColumn(label: Text(appLocalization.user!)),
                      DataColumn(label: Text(appLocalization.stuff!)),
                      DataColumn(label: Text(appLocalization.quantity!)),
                      DataColumn(label: Center(child: Text(appLocalization.type!))),
                    ],
                    rows: List<DataRow>.generate(
                      listOfStuffTransition.length, 
                      (index) { 
                        Stuff? stuff=findStuffByStuffTransitionId(listOfStuff, listOfStuffTransition[index].id!);
                        return DataRow(
                          cells: <DataCell> [
                            DataCell(Text(listOfStuffTransition[index].transitionDate!.toIso8601String())),
                            DataCell(Text(listOfStuffTransition[index].idUser!.username!)),
                            DataCell(Text(stuff!.name!)),
                            DataCell(Center(child: Text(listOfStuffTransition[index].quantity.toString()))),
                            DataCell(
                              IconButton(
                                onPressed: () => showDialog(
                                  context: context, 
                                  builder: (BuildContext buildContext) => Container(),
                                ),
                                icon: const Icon(Iconsax.arrow_down),
                              )
                            ),
                          ],
                        );
                      }
                    ),
                  ),
                ),
              );
            }, 
            error: (error, stackTrace) => Text(error.toString()), 
            loading: () => const LoadingWidget(),
          );
        }
        else{
          return Text(
            appLocalization.noStuff!,
            style: const TextStyle(
              fontSize: 20.0,
              fontStyle: FontStyle.italic
            ),
          );
        }
      }, 
      error: (error, stackTrace) => Text(error.toString()), 
      loading: () => const LoadingWidget(),
    );
  }
}