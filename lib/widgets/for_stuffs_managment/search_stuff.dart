import 'package:company_manager_client/widgets/for_stuffs_managment/search_stuff_transition.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_layout.dart';

class SearchStuff extends ConsumerStatefulWidget {
  const SearchStuff({super.key});

  @override
  SearchStuffState createState() => SearchStuffState();
}

class SearchStuffState extends ConsumerState<SearchStuff> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  final searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Widget showSearchedStuff(String textKey, int value) {
      final stuffs= value==0 ? ref.watch(getStuffsByNameProvider(textKey)) : ref.watch(getFullStuffsByNameProvider(textKey));

      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Icon(Iconsax.search_normal_1),
            const SizedBox(width: 10.0,),
            Expanded(child: Text(appLocalization.searchResults!)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.printer),
              ),
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
                    DataColumn(label: Text(appLocalization.thresholdForWarning!)),
                    DataColumn(label: Text(appLocalization.description!)),
                    DataColumn(label: Text(appLocalization.edit!)),
                  ],
                  rows: List<DataRow>.generate(
                      listOfStuffs .length, 
                      (index)  => DataRow(
                        cells: <DataCell> [
                          DataCell(Text(listOfStuffs[index].name!)),
                          DataCell(Center(child: Text(listOfStuffs[index].quantity.toString()))),
                          DataCell(Center(child: Text(listOfStuffs[index].threshold.toString()))),
                          DataCell(Text(listOfStuffs[index].description!)),
                          DataCell(
                          IconButton(
                            onPressed: () => showDialog(
                              context: context, 
                              builder: (BuildContext buildContext) => Container(),
                            ),
                            icon: const Icon(Iconsax.edit_2),
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
          loading: () => const LoadingWidget()
        ),
      );
    }
    
    return AlertDialog(
       title: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Icon(Iconsax.box),
          Text(appLocalization.searchStuff!),
        ],
      ),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20.0,),

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
                      builder: (context) => showSearchedStuff(searchController.text, 0),
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
                      builder: (context) => showSearchedStuff(searchController.text, 1),
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



 /* Wrap(
                spacing: 10.0,
                runSpacing: 10.0,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  SizedBox(
                    width: 350.0,
                    child: TextField(
                      //controller: controller,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: appLocalization.searchStuffByName,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (BuildContext buildContext) => searchedStuff(),
                    ),
                    icon: const Icon(Iconsax.search_normal_1)
                  ),
                ],
              ),
              const SizedBox(height: 20.0,),
              Center(child: Text(appLocalization.or!)),
              const SizedBox(height: 20.0,),
              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext buildContext) => searchedStuff(),
                ),
                child: Text(appLocalization.searchAll!)
              ), */