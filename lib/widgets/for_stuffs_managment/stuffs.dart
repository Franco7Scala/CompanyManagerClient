import 'package:company_manager_client/models/stuff.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/search_stuff.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfStuffs=[
  Stuff("name", "quantity", "thresholdForWarning", "description"),
];

class Stuffs extends ConsumerWidget {
  const Stuffs({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5.0, top: 20.0),
          child: InkWell(
            onTap: () => showDialog(
              context: context, 
              builder: (BuildContext buildContext) => const SearchStuff(),
            ),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 5.0,
              children: <Widget>[
                const Icon(Iconsax.search_normal_1),
                Text(appLocalization.search!),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20.0,),
        Card(
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
                    DataCell(Text(listOfStuffs[index].name.toString())),
                    DataCell(Text(listOfStuffs[index].quantity.toString())),
                    DataCell(Text(listOfStuffs[index].thresholdForWarning.toString())),
                    DataCell(Text(listOfStuffs[index].description.toString())),
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
        ),
      ],
    );
  }
}