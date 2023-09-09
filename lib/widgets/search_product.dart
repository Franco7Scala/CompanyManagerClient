import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfSearchedProduct = [

];

class SearchProduct extends ConsumerWidget {
  const SearchProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Widget searchedProduct() => AlertDialog(
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
                DataColumn(label: Text(appLocalization.code!)),
                DataColumn(label: Text(appLocalization.name!)),
                DataColumn(label: Text(appLocalization.year!)),
                DataColumn(label: Text(appLocalization.quantity!)),
                DataColumn(label: Text(appLocalization.available!)),
                DataColumn(label: Text(appLocalization.priceForPrivate!)),
                DataColumn(label: Text(appLocalization.pricePerReseller!)),
              ],
              rows: List<DataRow>.generate(
                  listOfSearchedProduct .length, 
                  (index)  => DataRow(
                    cells: <DataCell> [
                      DataCell(Text(listOfSearchedProduct[index].toString())),
                      DataCell(Text(listOfSearchedProduct[index].toString())),
                      DataCell(Text(listOfSearchedProduct[index].toString())),
                      DataCell(Text(listOfSearchedProduct[index].toString())),
                      DataCell(Text(listOfSearchedProduct[index].toString())),
                      DataCell(Text(listOfSearchedProduct[index].toString())),
                      DataCell(Text(listOfSearchedProduct[index].toString())),
                    ],
                  ),
                ),
            ),
          ),
        ],
      ),
    );
    
    return AlertDialog(
      title: Text(appLocalization.searchProduct!),
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
                      labelText: appLocalization.searchByProductName,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () => showDialog(
                    context: context,
                    builder: (BuildContext buildContext) => searchedProduct(),
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
                builder: (BuildContext buildContext) => searchedProduct(),
              ),
              child: Text(appLocalization.searchAll!)
            ),
      
          ],
        ),
      ),
    );
  }
}