import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/product.dart';
import 'package:company_manager_client/models/product_transition.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/list_of_products.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final listOfProductTransiotionsProvider=FutureProvider<List<ProductTransition>>((ref) async {
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}/products/getProductTransitions");
  final data=response.data;
  return List<ProductTransition>.from(data.map((productTransitionJson) => ProductTransition.fromJson(productTransitionJson)));
});

class ListOfProductTransions extends ConsumerWidget {
  const ListOfProductTransions ({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Product? findProductById(List<Product> listOfProducts, int productId) {
      for (final product in listOfProducts) {
        if(product.id==productId){
          return product;
        }
      }
      return null; 
    }
    
    return ref.watch(listOfProductsProvider).when(
      data: (listOfProducts) {
        return ref.watch(listOfProductTransiotionsProvider).when(
          data: (listOfProductTransitions) {
            return  Column(
              children: [
                Visibility(
                  visible: listOfProductTransitions.isNotEmpty,
                  child: Card(
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
                          listOfProductTransitions.length, 
                          (index)  { 
                            Product? product=findProductById(listOfProducts, listOfProductTransitions[index].productDetail!.idProduct!);
                            return DataRow(
                              cells: <DataCell> [
                                DataCell(Text(listOfProductTransitions[index].transitionDate!.toIso8601String())),
                                DataCell(Text(listOfProductTransitions[index].idUser!.username!)),
                                DataCell(Text(product!.name!)),
                                DataCell(Text(listOfProductTransitions[index].quantity.toString())),
                                DataCell(Text(listOfProductTransitions[index].fromState!.name!)),
                                DataCell(Text(listOfProductTransitions[index].toState!.name!)),
                                DataCell(Text(listOfProductTransitions[index].description!)),
                              ],
                            );
                          }
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: listOfProductTransitions.isEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      appLocalization.noTransition!,
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontStyle: FontStyle.italic
                      ),
                    ),
                  )
                ),
              ],
            );
          },
          loading: () => const LoadingWidget(),
          error: (error, stackTrace) => Text(error.toString()),
        );
      }, 
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => const LoadingWidget(),
    );

  }
}