import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/product.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/add_product_detail.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/search_product.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfProductsProvider=FutureProvider<List<Product>>((ref) async {
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}/products");
  final data = response.data;
  return List<Product>.from(data.map((productJson) => Product.fromJson(productJson)));
});

class ListOfProducts extends ConsumerWidget {
  const ListOfProducts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return ref.watch(listOfProductsProvider).when(
      data: (products) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
              visible: products.isNotEmpty,
              child: Padding(
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
            ),
            const SizedBox(height: 20.0,),
            Visibility(
              visible: products.isNotEmpty,
              child: Card(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(label: Text(appLocalization.code!)),
                      DataColumn(label: Text(appLocalization.name!)),
                      DataColumn(label: Text(appLocalization.addYear!)),
                    ],
                    rows: List<DataRow>.generate(
                      products .length, 
                      (index)  => DataRow(
                        cells: <DataCell> [
                          DataCell(Text(products[index].code!)),
                          DataCell(Text(products[index].name!)),
                          DataCell(
                            Center(
                              child: IconButton(
                                onPressed: () => showDialog(
                                  context: context, 
                                  builder: (BuildContext buildContext) => AddProductDetail(product: products[index],),
                                ),
                                icon: const Icon(Iconsax.add),
                              ),
                            )
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Visibility(
              visible: products.isEmpty,
              child: Text(
                appLocalization.noProduct!,
                style: const TextStyle(
                  fontSize: 20.0,
                  fontStyle: FontStyle.italic
                ),
              )
            ),
          ],
        );
      },
      loading: () => const LoadingWidget(),
      error: ((error, stackTrace) => Text(error.toString())),
    );
  }
}