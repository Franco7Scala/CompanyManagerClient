import 'package:company_manager_client/model/receipt.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfReceipts= [
  Receipt(DateTime.now(), 1, 'Andrea', 'Carta', 60, 0, 60),

];

class Receipts extends ConsumerWidget {
  const Receipts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return Card(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(label: Text(appLocalization.date!)),
            const DataColumn(label: Text("N")),
            DataColumn(label: Text(appLocalization.user!)),
            DataColumn(label: Text(appLocalization.termsOfPayment!)),
            DataColumn(label: Text(appLocalization.price!)),
            DataColumn(label: Text(appLocalization.discount!)),
            DataColumn(label: Text(appLocalization.amount!)),
            DataColumn(label: Text(appLocalization.print!)),
          ],
          rows: List<DataRow>.generate(
            listOfReceipts.length, 
            (index)  => DataRow(
              cells: <DataCell> [
                DataCell(Text(listOfReceipts[index].date.toString())),
                DataCell(Text(listOfReceipts[index].number.toString())),
                DataCell(Text(listOfReceipts[index].user.toString())),
                DataCell(Text(listOfReceipts[index].termsOfPayment.toString())),
                DataCell(Text(listOfReceipts[index].price.toString())),
                DataCell(Text(listOfReceipts[index].discount.toString())),
                DataCell(Text(listOfReceipts[index].amount.toString())),
                DataCell(
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Iconsax.printer),
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