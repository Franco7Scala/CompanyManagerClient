import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/state_model.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/list_of_state_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final addStateModelProvider=FutureProvider.family<void, StateModel>((ref, stateModel) async {
  final dio=ref.watch(dioProvider);
  await dio.post(
    "${Constants.baseUrl}/states",
    data: stateModel.toJson(),
  );
  // ignore: unused_result
  ref.refresh(listOfStateModelProvider);
});

class CreateStateModel extends ConsumerStatefulWidget {
  const CreateStateModel({super.key});

  @override
  CreateStateModelState createState() => CreateStateModelState();
}

class CreateStateModelState extends ConsumerState<CreateStateModel> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  final nameStateModelController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return AlertDialog(
      title: Wrap(
        spacing: 10.0,
        runSpacing: 10.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          const Icon(Iconsax.bill),
          Text(appLocalization.createState!),
        ],
      ),
      scrollable: true,
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
        
              const SizedBox(height: 10.0,),
              
              TextFormField(
                controller: nameStateModelController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.enterTheNameOfTheState,
                ),
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              
              
              
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
          height: MediaQuery.of(context).size.width <= 366.0 ? 10.0 : null, 
        ),

        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              StateModel stateModel=StateModel(
                name: nameStateModelController.text.toLowerCase(),
              );
              ref.watch(addStateModelProvider(stateModel));
              Navigator.pop(context);
            }
          }, 
          child: Text("   ${appLocalization.create!}   "),
        )


      ],
    );
  }
}