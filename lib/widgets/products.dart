import 'package:company_manager_client/model/product.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/widgets/add_year.dart';
import 'package:company_manager_client/widgets/search_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfProducts=[
  Product("cklanlc", "ncasncka"),
];

class Products extends ConsumerWidget {
  const Products({super.key});

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
              builder: (BuildContext buildContext) => const SearchProduct(),
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
                DataColumn(label: Text(appLocalization.code!)),
                DataColumn(label: Text(appLocalization.name!)),
                DataColumn(label: Text(appLocalization.addYear!)),
              ],
              rows: List<DataRow>.generate(
                listOfProducts .length, 
                (index)  => DataRow(
                  cells: <DataCell> [
                    DataCell(Text(listOfProducts[index].code.toString())),
                    DataCell(Text(listOfProducts[index].name.toString())),
                    DataCell(
                      IconButton(
                        onPressed: () => showDialog(
                          context: context, 
                          builder: (BuildContext buildContext) => const AddYear(),
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