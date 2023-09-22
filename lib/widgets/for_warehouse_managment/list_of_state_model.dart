import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/state_model.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

final listOfStateModelProvider=FutureProvider<List<StateModel>>((ref) async {
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}/states/getAllVisibleState");
  final data=response.data;
  return List<StateModel>.from(data.map((stateModelJson) => StateModel.fromJson(stateModelJson)));
});

final deleteStateModelProvider=FutureProvider.family<void, StateModel>((ref, stateModel) async {
  final dio=ref.watch(dioProvider);
  await dio.put(
    "${Constants.baseUrl}/states/deleteState",
    data: stateModel.toJson(),
  );
  // ignore: unused_result
  ref.refresh(listOfStateModelProvider);
});

final setFavouriteStateProvider=FutureProvider.family<void, StateModel>((ref, stateModel) async {
  final dio=ref.watch(dioProvider);
  await dio.put(
    "${Constants.baseUrl}/states/setPreferredState",
    data: stateModel.toJson(),
  );
  // ignore: unused_result
  ref.refresh(listOfStateModelProvider);
});

final setDownloadalbeStateProvider=FutureProvider.family<void, StateModel>((ref, stateModel) async {
  final dio=ref.watch(dioProvider);
  await dio.put(
    "${Constants.baseUrl}/states/setDownloadableState",
    data: stateModel.toJson(),
  );
  // ignore: unused_result
  ref.refresh(listOfStateModelProvider);
});

class ListOfStateModel extends ConsumerWidget {
  const ListOfStateModel({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Widget infoStateButton() => JustTheTooltip(
      content: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(appLocalization.infoStateButton!, textAlign: TextAlign.justify,)
        ),
      ),
      isModal: true, 
      offset: 5.0,
      child: const Icon(Iconsax.info_circle),
    );
    
    return ref.watch(listOfStateModelProvider).when(
      data: (listOfState){
        if(listOfState.isNotEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: infoStateButton(),
              ),
              const SizedBox(height: 15.0,),
              Card(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columnSpacing: ResponsiveLayout.isDesktop(context) ? 70.0 : null,
                    columns: [
                      DataColumn(label: Text(appLocalization.name!)),
                      DataColumn(label: Text(appLocalization.favourite!)),
                      DataColumn(label: Center(child: Text(appLocalization.edit!))),
                    ],
                    rows: List<DataRow>.generate(
                      listOfState.length, 
                      (index)  => DataRow(
                        cells: <DataCell> [
                          DataCell(Text(listOfState[index].name.toString())),
                          DataCell(Text(
                            listOfState[index].favourite! ? appLocalization.favourite! : ""
                          )),
                          DataCell(
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      ref.watch(deleteStateModelProvider(listOfState[index]));
                                    },
                                    icon: const Icon(Iconsax.trash),
                                  ),
                                  const SizedBox(width: 15.0,),
                                  IconButton(
                                    onPressed: () {
                                      ref.watch(setFavouriteStateProvider(listOfState[index]));
                                    },
                                    icon: const Icon(Iconsax.star),
                                    color: listOfState[index].favourite! ? Colors.yellow[700] : null,
                                  ),
                                  const SizedBox(width: 15.0,),
                                  IconButton(
                                    onPressed: () {
                                      ref.watch(setDownloadalbeStateProvider(listOfState[index]));
                                    },
                                    icon: const Icon(Iconsax.arrow_down),
                                    color: listOfState[index].downloadable! ? Colors.green[700] : null,
                                  ),
                                ],
                              ),
                            ), 
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
        else{
          return Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              children: [
                Text(
                  appLocalization.noState!,
                  style: const TextStyle(
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic
                  ),
                ),
                const SizedBox(width: 25.0,),
                const Text("-"),
                const SizedBox(width: 20.0,),
                infoStateButton(),
              ],
            ),
          );
        }
      },
      loading: () => const LoadingWidget(),
      error: ((error, stackTrace) => Text(error.toString())) 
    );
  }
}

/*
final snackBar = SnackBar(
                  content: Text(appLocalization.infoStateButton!),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
*/