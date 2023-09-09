import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';


final listOfAddStuffMovements=[
];

class AddStuffMovements extends ConsumerWidget {
  const AddStuffMovements({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(appLocalization.addMovement!),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext buildContext) => AlertDialog(
                title: Text(appLocalization.info!),
                content: SizedBox(
                  width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
                  child: Text(appLocalization.infoAddMovementStuffButton!),
                ),
              ),
            ), 
            icon: const Icon(Iconsax.info_circle),
          ),
        ],
      ),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 400.0 : 800.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15.0,),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: <Widget>[
                Text(appLocalization.searchStuff!),
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
                  onPressed: () {}, 
                  icon: const Icon(Iconsax.search_normal_1)
                ), 
                Text(appLocalization.or!),
                TextButton(
                  onPressed: () {}, 
                  child: Text(appLocalization.searchAll!)
                ),
              ],
            ),
      
      
            const SizedBox(height: 30.0,),
      
            SingleChildScrollView(
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
                  listOfAddStuffMovements .length, 
                  (index)  => DataRow(
                    cells: <DataCell> [
                      DataCell(Text(listOfAddStuffMovements[index].toString())),
                      DataCell(Text(listOfAddStuffMovements[index].toString())),
                      DataCell(Text(listOfAddStuffMovements[index].toString())),
                      DataCell(
                        Wrap(
                          spacing: 2.0,
                          runSpacing: 2.0,
                          children: [
                            Text("${appLocalization.quantity!} 0.0"),
                            IconButton(
                              onPressed: () => showDialog(
                                context: context, 
                                builder: (BuildContext buildContext) => Container(),
                              ),
                              icon: const Icon(Iconsax.arrow_down),
                            ),
                          ],
                        )
                      ),
                      DataCell(
                        Wrap(
                          spacing: 2.0,
                          runSpacing: 2.0,
                          children: [
                            Text("${appLocalization.quantity!} 0.0"),
                            IconButton(
                              onPressed: () => showDialog(
                                context: context, 
                                builder: (BuildContext buildContext) => Container(),
                              ),
                              icon: const Icon(Iconsax.arrow_up),
                            ),
                          ],
                        )
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}