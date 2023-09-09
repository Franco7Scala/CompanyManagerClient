import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfStuffMovements=[
  
];

class StuffMovements extends ConsumerWidget {
  const StuffMovements({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: <DataColumn>[
            DataColumn(label: Text(appLocalization.name!)),
            DataColumn(label: Text(appLocalization.user!)),
            DataColumn(label: Text(appLocalization.stuff!)),
            DataColumn(label: Text(appLocalization.quantity!)),
            DataColumn(label: Text(appLocalization.type!)),
          ],
          rows: List<DataRow>.generate(
            listOfStuffMovements .length, 
            (index)  => DataRow(
              cells: <DataCell> [
                DataCell(Text(listOfStuffMovements[index].toString())),
                DataCell(Text(listOfStuffMovements[index].toString())),
                DataCell(Text(listOfStuffMovements[index].toString())),
                DataCell(Text(listOfStuffMovements[index].toString())),
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
            ),
          ),
        ),
      ),
    );
  }
}