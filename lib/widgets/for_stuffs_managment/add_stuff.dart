import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

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

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: Text(appLocalization.addStuff!)),
          IconButton(
            onPressed: () => showDialog(
              context: context,
              builder: (BuildContext buildContext) => AlertDialog(
                title: Text(appLocalization.info!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15.0),),
                content: SizedBox(
                  width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
                  child: Text(appLocalization.infoAddStuffButton!),
                ),
              ),
            ), 
            icon: const Icon(Iconsax.info_circle),
          ),
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
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: thresholdForWarningController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.thresholdForWarning,
                ),
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

        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()){
              
            }
          }, 
          child: Text(appLocalization.addStuff!),
        )


      ],

    );
  }
}

