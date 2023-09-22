import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/stuff.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/edit_stuff.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/search_stuff.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

//get list of stuffs from server
final getAllStuffsProvider=FutureProvider<List<Stuff>>((ref) async {
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}/stuffs");
  final data = response.data;
  return List<Stuff>.from(data.map((stuffJson) => Stuff.fromJson(stuffJson)));
});

class ListOfStuffs extends ConsumerWidget {
  const ListOfStuffs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return ref.watch(getAllStuffsProvider).when(
      data: (stuffs) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: stuffs.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 20.0),
                child: InkWell(
                  onTap: () => showDialog(
                    context: context, 
                    builder: (BuildContext buildContext) => const SearchStuff(),
                  ),
                  child: Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 5.0,
                    children: <Widget>[
                      const Icon(Iconsax.search_normal_1),
                      Text(appLocalization.search!),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0,),
            Visibility(
              visible: stuffs.isNotEmpty,
              child: Card(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(label: Text(appLocalization.name!)),
                      DataColumn(label: Text(appLocalization.quantity!)),
                      DataColumn(label: Text(appLocalization.thresholdForWarning!)),
                      DataColumn(label: Text(appLocalization.description!)),
                      DataColumn(label: Center(child: Text(appLocalization.edit!))),
                    ],
                    rows: List<DataRow>.generate(
                      stuffs.length, 
                      (index)  => DataRow(
                        cells: <DataCell> [
                          DataCell(Text(stuffs[index].name!)),
                          DataCell(Center(child: Text(stuffs[index].quantity.toString()))),
                          DataCell(Center(child: Text(stuffs[index].threshold.toString()))),
                          DataCell(Text(stuffs[index].description!)),
                          DataCell(
                            Center(
                              child: IconButton(
                                onPressed: () => showDialog(
                                  context: context, 
                                  builder: (BuildContext buildContext) => EditStuff(stuff: stuffs[index]),
                                ),
                                icon: const Icon(Iconsax.edit_2),
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: stuffs.isEmpty,
              child: Text(
                appLocalization.noStuff!,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic
                ),
              ),
            )
          ],
        );
      }, 
      loading: () => const LoadingWidget(),
      error: ((error, stackTrace) => Text(error.toString())),
    );
  }
}