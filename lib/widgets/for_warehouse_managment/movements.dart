import 'package:company_manager_client/model/movement.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listOfMovements = [
  Movement(DateTime.now(), "user", "product", "quantity", "from", "to", "description"),
];

class Movements extends ConsumerWidget {
  const Movements ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text(appLocalization.date!)),
            DataColumn(label: Text(appLocalization.user!)),
            DataColumn(label: Text(appLocalization.product!)),
            DataColumn(label: Text(appLocalization.quantity!)),
            DataColumn(label: Text(appLocalization.from!)),
            DataColumn(label: Text(appLocalization.to!)),
            DataColumn(label: Text(appLocalization.description!)),
          ],
          rows: List<DataRow>.generate(
            listOfMovements .length, 
            (index)  => DataRow(
              cells: <DataCell> [
                DataCell(Text(listOfMovements[index].date.toString())),
                DataCell(Text(listOfMovements[index].user.toString())),
                DataCell(Text(listOfMovements[index].product.toString())),
                DataCell(Text(listOfMovements[index].quantity.toString())),
                DataCell(Text(listOfMovements[index].from.toString())),
                DataCell(Text(listOfMovements[index].to.toString())),
                DataCell(Text(listOfMovements[index].description.toString())),
              ],
            ),
          ),
        ),
      ),
    );
  }
}