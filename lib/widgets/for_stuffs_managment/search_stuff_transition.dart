import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/stuff.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

final getStuffsByNameProvider=FutureProvider.family<List<Stuff>, String>((ref, textKey) async {
  final endPoint="/stuffs/getStuffsByName/$textKey";
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}$endPoint");
  final data=response.data;
  return List<Stuff>.from(data.map((stuffJson) => Stuff.fromJson(stuffJson)));
});

final getFullStuffsByNameProvider=FutureProvider.family<List<Stuff>, String>((ref, textKey) async {
  final endPoint="/stuffs/getFullStuffsByName/$textKey";
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}$endPoint");
  final data=response.data;
  return List<Stuff>.from(data.map((stuffJson) => Stuff.fromJson(stuffJson)));
});

class SearchStuffTransition extends ConsumerStatefulWidget {
  const SearchStuffTransition({super.key});

  @override
  SearchStuffTransitionState createState() => SearchStuffTransitionState();
}

class SearchStuffTransitionState extends ConsumerState<SearchStuffTransition> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  final searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Widget showSearchedStuff(String textKey, int value) { 
      final stuffs = value==0 ? ref.watch(getStuffsByNameProvider(textKey)) : ref.watch(getFullStuffsByNameProvider(textKey));

      return AlertDialog(
        title: Row(
          children: <Widget>[
            const Icon(Iconsax.search_normal_1),
            const SizedBox(width: 10.0,),
            Expanded(child: Text(appLocalization.searchResults!))
          ],
        ),
        scrollable: true,
        content: stuffs.when(
          data: (listOfStuffs) {
            return SizedBox(
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
                    listOfStuffs .length, 
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
            );
          }, 
          error: ((error, stackTrace) => Text(error.toString())), 
          loading: () => const LoadingWidget(),
        ),
      );
    }

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Iconsax.box),
          const SizedBox(width: 10.0,),
          Expanded(child: Text(appLocalization.searchStuff!)),
        ],
      ),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 15.0,),

              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.searchStuffByName,
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),

              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),  
                onPressed: () { 
                  if (_formKey.currentState!.validate()){
                    showDialog(
                      context: context, 
                      builder: (BuildContext buildContext) => showSearchedStuff(searchController.text, 0),
                    );
                  }
                },
                child: const Icon(Iconsax.search_normal_1)
              ),
              const SizedBox(height: 7.0,),
              Center(child: Text(appLocalization.or!)),
              const SizedBox(height: 7.0,),
              OutlinedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()){
                    showDialog(
                      context: context, 
                      builder: (BuildContext buildContext) => showSearchedStuff(searchController.text, 1),
                    );
                  }
                },
                child: Text(appLocalization.searchAll!)
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}