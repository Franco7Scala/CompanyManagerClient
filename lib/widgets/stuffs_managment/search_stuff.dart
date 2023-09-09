import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/app_localizations.dart';
import '../../utils/responsive_layout.dart';

final listOfSearchedStuff = [

];

class SearchStuff extends ConsumerWidget {
  const SearchStuff({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Widget searchedStuff() => AlertDialog(
      content: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Iconsax.printer),
            ),
          ),
          const SizedBox(height: 20.0,),
          SingleChildScrollView(
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
                  listOfSearchedStuff .length, 
                  (index)  => DataRow(
                    cells: <DataCell> [
                      DataCell(Text(listOfSearchedStuff[index].name.toString())),
                      DataCell(Text(listOfSearchedStuff[index].quantity.toString())),
                      DataCell(Text(listOfSearchedStuff[index].thresholdForWarning.toString())),
                      DataCell(Text(listOfSearchedStuff[index].description.toString())),
                      DataCell(
                      IconButton(
                        onPressed: () => showDialog(
                          context: context, 
                          builder: (BuildContext buildContext) => Container(),
                        ),
                        icon: const Icon(Iconsax.add),
                      )
                    ),
                    ],
                  ),
                ),
            ),
          ),
        ],
      ),
    );
    
    return AlertDialog(
      title: Text(appLocalization.searchStuff!),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 20.0,),
      
            Wrap(
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
            ),
      
          ],
        ),
      ),
    );
  }
}