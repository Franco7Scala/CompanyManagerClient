import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/product.dart';
import 'package:company_manager_client/models/product_detail.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/list_of_products.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final getProductsDetailByProductNameProvider=FutureProvider.family<List<ProductDetail>, String>((ref, textKey) async {
  String endPoint="/products/getProductsDetailByProductName/$textKey";
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}$endPoint");
  final data=response.data;
  return List<ProductDetail>.from(data.map((productDetailJson) => ProductDetail.fromJson(productDetailJson)));
});

final getFullProductsDetailByProductNameProvider=FutureProvider.family<List<ProductDetail>, String>((ref, textKey) async {
  String endPoint="/products/getFullProductsDetailByProductName/$textKey";
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}$endPoint");
  final data=response.data;
  return List<ProductDetail>.from(data.map((productDetailJson) => ProductDetail.fromJson(productDetailJson)));
});

class SearchProduct extends ConsumerStatefulWidget {
  const SearchProduct({super.key});

  @override
  SearchProductState createState() => SearchProductState();
}

class SearchProductState extends ConsumerState<SearchProduct> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  final searchController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Product? findProductById(List<Product> listOfProducts, int productId) {
      for (final product in listOfProducts) {
        if(product.id==productId){
          return product;
        }
      }
      return null; 
    }

    Widget showSearchedProduct(String texKey, int value) { 
      final productDetailsList= value==0 ? ref.watch(getProductsDetailByProductNameProvider(texKey)) : ref.watch(getFullProductsDetailByProductNameProvider(texKey));
      
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Icon(Iconsax.search_normal_1),
            const SizedBox(width: 10.0,),
            Expanded(child: Text(appLocalization.searchResults!)),
            IconButton(
                onPressed: () {},
                icon: const Icon(Iconsax.printer),
              ),
          ],
        ),
        scrollable: true,
        content: productDetailsList.when(
          data: (productDetails) {
            return SizedBox(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: <DataColumn>[
                    DataColumn(label: Text(appLocalization.code!)),
                    DataColumn(label: Text(appLocalization.name!)),
                    DataColumn(label: Text(appLocalization.year!)),
                    DataColumn(label: Text(appLocalization.quantity!)),
                    //DataColumn(label: Text(appLocalization.available!)),
                    DataColumn(label: Text(appLocalization.priceForPrivate!)),
                    DataColumn(label: Text(appLocalization.pricePerReseller!)),
                  ],
                  rows: List<DataRow>.generate(
                      productDetails .length, 
                      (index) { 
                        return ref.watch(listOfProductsProvider).when(
                          data: (listOfProducts) {
                            Product? product=findProductById(listOfProducts, productDetails[index].idProduct!);
                            return DataRow(
                              cells: <DataCell> [
                                DataCell(Text(product!.code!)),
                                DataCell(Text(product.name!)),
                                DataCell(Text(productDetails[index].year.toString())),
                                DataCell(Text(productDetails[index].quantity.toString())),
                                //DataCell(Text(listOfProducts[index].available!.toString())),
                                DataCell(Text(productDetails[index].pricePrivate.toString())),
                                DataCell(Text(productDetails[index].priceReseller.toString())),
                              ],
                            );
                          },
                          loading: () => const DataRow(cells: []),
                          error: (error, stackTrace) => const DataRow(cells: []),
                        );
                        
                      }
                    ),
                ),
              ),
            );
          }, 
          error: (error, stackTrace) => Text(error.toString()), 
          loading: () => const LoadingWidget(),
        )
      );
    }
    
    return AlertDialog(
      title: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Icon(Iconsax.milk),
          Text(appLocalization.searchProduct!),
        ],
      ),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20.0,),

              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.searchByProductName,
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),

              TextButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),  
                onPressed: () { 
                  if (_formKey.currentState!.validate()){
                    showDialog(
                      context: context,
                      builder: (BuildContext buildContext) => showSearchedProduct(searchController.text, 0),
                    );
                  }
                },
                child: const Icon(Iconsax.search_normal_1)
              ),
              const SizedBox(height: 7.0,),
              Center(child: Text(appLocalization.or!)),
              const SizedBox(height: 7.0,),
              OutlinedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()){
                    showDialog(
                      context: context,
                      builder: (BuildContext buildContext) => showSearchedProduct(searchController.text, 1),
                    );
                  }
                },
                child: Text(appLocalization.searchAll!)
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}