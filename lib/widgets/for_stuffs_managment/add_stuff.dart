import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/stuff.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/list_of_stuffs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

final addStuffProvider=FutureProvider.family<void, Stuff>((ref, stuff) async {
  const endPoint="/stuffs/53";
  final dio=ref.watch(dioProvider);
  await dio.post(
    "${Constants.baseUrl}$endPoint",
    data: stuff.toJson(),
  );
  // ignore: unused_result
  ref.refresh(getAllStuffsProvider);
});

class AddStuff extends ConsumerStatefulWidget {
  const AddStuff({super.key});

  @override
  AddStuffState createState() => AddStuffState();
}

class AddStuffState extends ConsumerState<AddStuff> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  //controller for TextFormField
  final nameController=TextEditingController();
  final unitOfMeasureController=TextEditingController();
  final singleBarcodeController=TextEditingController();
  final packageBarcodeController=TextEditingController();
  final descriptionController=TextEditingController();
  final quantityController=TextEditingController();
  final thresholdForWarningController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    //watch providers
    final appLocalization=ref.watch(AppLocalizations.providers);

    Widget infoAddStuffButton() => JustTheTooltip(
      content: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(appLocalization.infoAddStuffButton!, textAlign: TextAlign.justify,)
        ),
      ),
      isModal: true, 
      offset: 5.0,
      child: const Icon(Iconsax.info_circle),
    );

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Iconsax.box_add),
          const SizedBox(width: 10.0,),
          Expanded(child: Text(appLocalization.addStuff!)),
          infoAddStuffButton(),
        ],
      ),
      scrollable: true,
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const SizedBox(height: 15.0,),
        
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
                controller: unitOfMeasureController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.unitOfMeasure,
                ),
                validator: (unit) {
                  if (unit == null || unit.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: singleBarcodeController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.singleBarcode,
                ),
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: packageBarcodeController,
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
        
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.quantity,
                ),
                validator: (quantity) {
                  if (quantity == null || quantity.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: thresholdForWarningController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.thresholdForWarning,
                ),
                validator: (threshold) {
                  if (threshold == null || threshold.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
        
        
            ],
          ),
        ),
      ),
      //alert dialog actions
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

        //yearController.text.isEmpty ? null : int.tryParse(yearController.text), 
        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()){
              Stuff stuff=Stuff(
                quantity: quantityController.text.isEmpty ? null : double.tryParse(quantityController.text),
                threshold: thresholdForWarningController.text.isEmpty ? null : double.tryParse(thresholdForWarningController.text),
                name: nameController.text,
                unitMeasure: unitOfMeasureController.text,
                description: descriptionController.text,
                barCodeSingle: singleBarcodeController.text,
                barCodePackage: packageBarcodeController.text,
              );
              ref.watch(addStuffProvider(stuff));
              Navigator.pop(context);
            }
          }, 
          child: Text(appLocalization.addStuff!),
        )


      ],

    );
  }
}

