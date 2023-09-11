import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class AddProduct extends ConsumerWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            const SizedBox(height: 15.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.code,
              ),
            ),
            const SizedBox(height: 20.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.name,
              ),
            ),
            const SizedBox(height: 20.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.singleBarcode,
              ),
            ),
            const SizedBox(height: 20.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.packageBarcode,
              ),
            ),
            const SizedBox(height: 20.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.description,
              ),
            ),
            const SizedBox(height: 20.0,),

            

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
          height: MediaQuery.of(context).size.width <= 382.0 ? 10.0 : null, 
        ),

        TextButton(
          onPressed: () {
          }, 
          child: Text(appLocalization.addProduct!),
        )


      ],
    );
  }
}