import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/product.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/list_of_products.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final addProductProvider=FutureProvider.family<void, Product>((ref, product) async {
  final dio=ref.watch(dioProvider);
  await dio.post(
    "${Constants.baseUrl}/products",
    data: product.toJson(),
  );
  // ignore: unused_result
  ref.refresh(listOfProductsProvider);
});

class AddProduct extends ConsumerStatefulWidget {
  const AddProduct({super.key});

  @override
  AddProductState createState() => AddProductState();
}

class AddProductState extends ConsumerState<AddProduct> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  //controllers for text fields
  final codeController=TextEditingController();
  final nameController=TextEditingController();
  final barCodeSingleController=TextEditingController();
  final barCodePackageController=TextEditingController();
  final descriptionController=TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    //watch providers
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return AlertDialog(
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(appLocalization.addProduct!)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Iconsax.info_circle)
          ),
        ],
      ),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
        
              const SizedBox(height: 15.0,),
        
              TextFormField(
                controller: codeController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.code,
                ),
                validator: (code) {
                  if (code == null || code.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.name,
                ),
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: barCodeSingleController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.singleBarcode,
                ),
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: barCodePackageController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.packageBarcode,
                ),
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.description,
                ),
              ),
              const SizedBox(height: 20.0,),
        
              
        
            ],
          ),
        ),
      ),
      actions: <Widget>[

        OutlinedButton(
          onPressed: () {
            Navigator.of(context).pop();
          }, 
          child: Text(appLocalization.cancel!),
        ),

        SizedBox(
          height: MediaQuery.of(context).size.width <= 382.0 ? 10.0 : null, 
        ),

        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()){
              Product product=Product(
                code: codeController.text.toUpperCase(), 
                name: nameController.text,
                barCodeSingle: barCodeSingleController.text,
                barCodePackage: barCodePackageController.text,
                description: descriptionController.text,
              );
              ref.watch(addProductProvider(product));
              Navigator.pop(context);
            }
          }, 
          child: Text(appLocalization.addProduct!),
        )


      ],
    );
  }

}