import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/stuff.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/list_of_stuffs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final editStuffProvider=FutureProvider.family<void, Stuff>((ref, stuff) async {
  const endPoint="/stuffs/editStuff";
  final dio=ref.watch(dioProvider);
  await dio.put(
    "${Constants.baseUrl}$endPoint",
    data: stuff.toJson(),
  );
  // ignore: unused_result
  ref.refresh(getAllStuffsProvider);
});

// ignore: must_be_immutable
class EditStuff extends ConsumerStatefulWidget {
  Stuff stuff;

  EditStuff({
    required this.stuff,
    super.key
  });

  @override
  EditStuffState createState() => EditStuffState();
}

class EditStuffState extends ConsumerState<EditStuff> {
  //key for validate form
  final _formKey = GlobalKey<FormState>();

  //controller for TextFormField
  late TextEditingController nameController;
  late TextEditingController unitOfMeasureController;
  late TextEditingController singleBarcodeController;
  late TextEditingController packageBarcodeController;
  late TextEditingController descriptionController;
  late TextEditingController quantityController;
  late TextEditingController thresholdForWarningController;

  @override
  void initState() {
    super.initState();
    nameController=TextEditingController(text: widget.stuff.name);
    unitOfMeasureController=TextEditingController(text: widget.stuff.unitMeasure);
    singleBarcodeController=TextEditingController(text: widget.stuff.barCodeSingle);
    packageBarcodeController=TextEditingController(text: widget.stuff.barCodePackage);
    descriptionController=TextEditingController(text: widget.stuff.description);
    quantityController=TextEditingController(text: widget.stuff.quantity.toString());
    thresholdForWarningController=TextEditingController(text: widget.stuff.threshold.toString());
  }
  
  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Iconsax.edit_2),
          const SizedBox(width: 10.0,),
          Expanded(child: Text(appLocalization.editStuff!)),
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

        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()){
              widget.stuff.quantity=quantityController.text.isEmpty ? null : double.tryParse(quantityController.text);
              widget.stuff.threshold=thresholdForWarningController.text.isEmpty ? null : double.tryParse(thresholdForWarningController.text);
              widget.stuff.name=nameController.text;
              widget.stuff.unitMeasure=unitOfMeasureController.text;
              widget.stuff.description=descriptionController.text;
              widget.stuff.barCodeSingle=singleBarcodeController.text;
              widget.stuff.barCodePackage=packageBarcodeController.text;

              ref.watch(editStuffProvider(widget.stuff));
              Navigator.pop(context);
            }
          }, 
          child: Text(appLocalization.editStuff!),
        )


      ],

    );
    
  }






}


