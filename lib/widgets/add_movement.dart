import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listReadyForUnloading=[

];

class AddMovement extends ConsumerWidget {
  const AddMovement({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return AlertDialog(
      title: Text(appLocalization.addMovement!),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 15.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.enterReasonForUnloading,
              ),
            ),
            const SizedBox(height: 20.0,),

            Wrap(
              spacing: 10.0,
              crossAxisAlignment: WrapCrossAlignment.center,
              verticalDirection: VerticalDirection.down,
              runSpacing: 10.0,
              children: [
                SizedBox(
                  width: 300.0,
                  child: TextField(
                    //controller: controller,
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: appLocalization.searchByProductName,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {}, 
                  icon: const Icon(Iconsax.search_normal_1)
                ),
                IconButton(
                  onPressed: () => showDialog(
                    context: context, 
                    builder: (BuildContext buildContext) => AlertDialog(
                      title: Text(
                        appLocalization.info!, 
                        style: const TextStyle(
                          fontSize: 15.0, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      content: SizedBox(
                        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
                        child: Text(appLocalization.infoMovementButton!),
                      ),
                    ),
                  ),
                  icon: const Icon(Iconsax.info_circle),
                ),
              ],
            ),
            const SizedBox(height: 20.0,),

            TextButton(
              onPressed: (){},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
              ),
              child: Text(appLocalization.confirm!),
            ),
            const SizedBox(height: 25.0,),

            Center(
              child: InkWell(
                onTap: () => showDialog(
                  context: context, 
                  builder: (BuildContext buildContext) => AlertDialog(
                    title: Text(appLocalization.readyForUnloading!, style: const TextStyle(fontSize: 15.0),),
                    content: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          DataTable(
                            columns: [
                              DataColumn(label: Text(appLocalization.name!)),
                              DataColumn(label: Text(appLocalization.year!)),
                              DataColumn(label: Text(appLocalization.boxes!)),
                              DataColumn(label: Text(appLocalization.bottles!)),
                              DataColumn(label: Text(appLocalization.from!)),
                              DataColumn(label: Text(appLocalization.to!)),
                            ],
                            rows: List<DataRow>.generate(
                              listReadyForUnloading.length, 
                              (index)  => DataRow(
                                cells: <DataCell> [
                                  DataCell(Text(listReadyForUnloading[index].toString())),
                                  DataCell(Text(listReadyForUnloading[index].toString())),
                                  DataCell(Text(listReadyForUnloading[index].toString())),
                                  DataCell(Text(listReadyForUnloading[index].toString())),
                                  DataCell(Text(listReadyForUnloading[index].toString())),
                                  DataCell(Text(listReadyForUnloading[index].toString())),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 20.0,),
                          Text(appLocalization.priceForPrivate!),
                          const SizedBox(height: 5.0,),
                          Text(appLocalization.pricePerReseller!)
                        ],
                      ),
                    ),
                  )
                ),
                child: Text(appLocalization.readyForUnloading!),
              ),
            )




          ],
        ),
      ),
    );
  }
}