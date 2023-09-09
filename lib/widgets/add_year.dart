import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class AddYear extends ConsumerWidget {
  const AddYear({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Text(appLocalization.addYear!)),
          const Icon(Iconsax.info_circle)
        ],
      ),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            
            const SizedBox(height: 15.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.year,
              ),
            ),
            const SizedBox(height: 20.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.quantity,
              ),
            ),
            const SizedBox(height: 20.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.priceForPrivate,
              ),
            ),
            const SizedBox(height: 20.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.pricePerReseller,
              ),
            ),
            const SizedBox(height: 20.0,),

            TextField(
              //controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: appLocalization.state,
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
          child: Text(appLocalization.addYear!),
        )


      ],
    );
  }
}