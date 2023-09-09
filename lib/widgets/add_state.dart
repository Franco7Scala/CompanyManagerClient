import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddState extends ConsumerWidget {
  const AddState({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return AlertDialog(
      title: Text(appLocalization.addState!),
      scrollable: true,
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Column(
          children: <Widget>[

            //const SizedBox(height: 20.0,),
            
            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.enterTheNameOfTheState,
              ),
            ),
      
            
      
          ],
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
          width: 5.0,
          height: MediaQuery.of(context).size.width <= 366.0 ? 10.0 : null, 
        ),

        TextButton(
          onPressed: () {
          }, 
          child: Text(appLocalization.addState!),
        )


      ],
    );
  }
}