import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/list_of_stuffs.dart';
import 'package:company_manager_client/widgets/my_app_bar.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/add_stuff.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/add_stuff_transition.dart';
import 'package:company_manager_client/widgets/for_stuffs_managment/list_of_stuff_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final selectedChipStuffsProvider=StateProvider<int>((ref) => -1);

class StuffsManagmentPage extends ConsumerWidget {
  const StuffsManagmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChipStuffs=ref.watch(selectedChipStuffsProvider);
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return Scaffold(
      appBar: const MyAppBar(),

      body: SingleChildScrollView(
        padding: ResponsiveLayout.isMobile(context) ? const EdgeInsets.all(12.0) : const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: <Widget>[
                
                ChoiceChip(
                  label: Text(appLocalization.stuffs!),
                  avatar: selectedChipStuffs!=0 ? const Icon(Iconsax.box) : null,
                  selected: selectedChipStuffs==0,
                  onSelected: (value) {
                    if(selectedChipStuffs==0){
                      ref.read(selectedChipStuffsProvider.notifier).state=-1;
                    }
                    else {
                      ref.read(selectedChipStuffsProvider.notifier).state=0;
                    }
                  }
                ),

                ChoiceChip(
                  label: Text(appLocalization.movements!),
                  avatar: selectedChipStuffs!=1 ? const Icon(Iconsax.refresh) : null,
                  selected: selectedChipStuffs==1,
                  onSelected: (value) {
                    if(selectedChipStuffs==1){
                      ref.read(selectedChipStuffsProvider.notifier).state=-1;
                    }
                    else {
                      ref.read(selectedChipStuffsProvider.notifier).state=1;
                    }
                  }
                ),

                
              ],
            ),
            
            Visibility(
              visible: selectedChipStuffs!=-1,
              child: const SizedBox(height: 30.0),
            ),

            Visibility(
              visible: selectedChipStuffs==0,
              child: const ListOfStuffs(),
            ),
            
            Visibility(
              visible: selectedChipStuffs==1,
              child: const ListOfStuffTransition(),
            ),
            

          ]
        ),
      ),

      floatingActionButton: selectedChipStuffs==0 || selectedChipStuffs==1 ? 
        FloatingActionButton.extended(
          onPressed: selectedChipStuffs==0 ? 
            () => showDialog(
              context: context, 
              builder: (BuildContext context) => const AddStuff(),
            ) 
            : selectedChipStuffs==1 ? 
            () => showDialog(
              context: context, 
              builder: (BuildContext context) => const AddStuffTransition(),
            ) 
            : null,
          icon: const Icon(Iconsax.add),
          label: Text(
            selectedChipStuffs==0 ? appLocalization.addStuff! : appLocalization.addMovement! 
          ),
        )
        :
        null,
        

    );
  }
}