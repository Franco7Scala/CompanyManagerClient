import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/list_of_stuffs.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/search_stuff_transition.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

class AddStuffTransition extends ConsumerStatefulWidget {
  const AddStuffTransition({super.key});

  @override
  AddStuffTransitionState createState() => AddStuffTransitionState();
}

class AddStuffTransitionState extends ConsumerState<AddStuffTransition> {

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Widget infoAddMovementStuffButton() => JustTheTooltip(
      content: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(appLocalization.infoAddMovementStuffButton!, textAlign: TextAlign.justify,)
        ),
      ),
      isModal: true, 
      offset: 5.0,
      child: const Icon(Iconsax.info_circle),
    );

    return ref.watch(getAllStuffsProvider).when(
      data: (listOfStuffs) {
        return AlertDialog(
          scrollable: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Iconsax.refresh),
              const SizedBox(width: 10.0,),
              Expanded(child: Text(appLocalization.addMovement!)),
              const SizedBox(width: 50.0,),
              IconButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (context) => const SearchStuffTransition(),
                ), 
                icon: const Icon(Iconsax.search_normal_1)
              ),
              infoAddMovementStuffButton(),
            ],
          ),
          content: SizedBox(
            //width: 800.0,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                columns: <DataColumn>[
                  DataColumn(label: Text(appLocalization.name!)),
                  DataColumn(label: Text(appLocalization.quantity!)),
                  DataColumn(label: Text(appLocalization.description!)),
                  DataColumn(label: Text(appLocalization.unload!)),
                  DataColumn(label: Text(appLocalization.load!)),
                ],
                rows: List<DataRow>.generate(
                  listOfStuffs.length, 
                  (index)  => DataRow(
                    cells: <DataCell> [
                      DataCell(Text(listOfStuffs[index].name!)),
                      DataCell(Text(listOfStuffs[index].quantity.toString())),
                      DataCell(Text(listOfStuffs[index].description!)),
                      DataCell(
                        Row(
                          children: [
                            Text("${appLocalization.quantity!}:"),
                            const SizedBox(width: 5.0,),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(), 
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("0.0"),
                              ),
                            ),
                            const SizedBox(width: 5.0,),
                            IconButton(
                              onPressed: () => showDialog(
                                context: context, 
                                builder: (BuildContext buildContext) => Container(),
                              ),
                              icon: const Icon(Iconsax.arrow_down_2),
                              color: Colors.red[600],
                            ),
                          ],
                        )
                      ),
                      DataCell(
                        Row(
                          children: [
                            Text("${appLocalization.quantity!}:"),
                            const SizedBox(width: 5.0,),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(), 
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              child: const Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text("0.0"),
                              ),
                            ),
                            const SizedBox(width: 5.0,),
                            IconButton(
                              onPressed: () => showDialog(
                                context: context, 
                                builder: (BuildContext buildContext) => Container(),
                              ),
                              icon: const Icon(Iconsax.arrow_up_1),
                              color: Colors.green[600],
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }, 
      error: ((error, stackTrace) => Text(error.toString())), 
      loading: () => const LoadingWidget(),
    );
  }
}

