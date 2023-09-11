import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/add_movement.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/add_product.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/add_state.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/products.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/movements.dart';
import 'package:company_manager_client/widgets/my_app_bar.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/receipts.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final selectedChipWarehouseProvider=StateProvider<int>((ref) => -1);

class WarehouseManagmentPage extends ConsumerWidget {
  const WarehouseManagmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedChipWarehouse=ref.watch(selectedChipWarehouseProvider);
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
                  label: Text(appLocalization.products!),
                  avatar: selectedChipWarehouse!=0 ? const Icon(Iconsax.milk) : null,
                  selected: selectedChipWarehouse==0,
                  onSelected: (value) {
                    if(selectedChipWarehouse==0){
                      ref.read(selectedChipWarehouseProvider.notifier).state=-1;
                    }
                    else {
                      ref.read(selectedChipWarehouseProvider.notifier).state=0;
                    }
                  }
                ),

                ChoiceChip(
                  label: Text(appLocalization.movements!),
                  avatar: selectedChipWarehouse!=1 ? const Icon(Iconsax.refresh) : null,
                  selected: selectedChipWarehouse==1,
                  onSelected: (value) {
                    if(selectedChipWarehouse==1){
                      ref.read(selectedChipWarehouseProvider.notifier).state=-1;
                    }
                    else {
                      ref.read(selectedChipWarehouseProvider.notifier).state=1;
                    }
                  }
                ),

                ChoiceChip(
                  label: Text(appLocalization.state!),
                  avatar: selectedChipWarehouse!=2 ? const Icon(Iconsax.bill) : null,
                  selected: selectedChipWarehouse==2,
                  onSelected: (value) {
                    if(selectedChipWarehouse==2){
                      ref.read(selectedChipWarehouseProvider.notifier).state=-1;
                    }
                    else {
                      ref.read(selectedChipWarehouseProvider.notifier).state=2;
                    }
                  }
                ),

                ChoiceChip(
                  label: Text(appLocalization.receipts!),
                  avatar: selectedChipWarehouse!=3 ? const Icon(Iconsax.clipboard_text) : null,
                  selected: selectedChipWarehouse==3,
                  onSelected: (value) {
                    if(selectedChipWarehouse==3){
                      ref.read(selectedChipWarehouseProvider.notifier).state=-1;
                    }
                    else {
                      ref.read(selectedChipWarehouseProvider.notifier).state=3;
                    }
                  }
                ),
              ],
            ),
            
            Visibility(
              visible: selectedChipWarehouse!=-1,
              child: const SizedBox(height: 30.0),
            ),

            Visibility(
              visible: selectedChipWarehouse==3,
              child: const Receipts(),
            ),
            
            
            Visibility(
              visible: selectedChipWarehouse==2,
              child: const StateWidget(),
            ),

            
            Visibility(
              visible: selectedChipWarehouse==1,
              child: const Movements(),
            ),

            Visibility(
              visible: selectedChipWarehouse==0,
              child: const Products(),
            ),
            

          ]
        ),
      ),

      floatingActionButton: selectedChipWarehouse!=-1 && selectedChipWarehouse!=3 ? 
        FloatingActionButton.extended(
          onPressed: selectedChipWarehouse==2 ? 
            () => showDialog(
              context: context, 
              builder: (BuildContext context) => const AddState(),
            ) 
            : selectedChipWarehouse==1 ? 
            () => showDialog(
              context: context, 
              builder: (BuildContext context) => const AddMovement(),
            ) 
            : selectedChipWarehouse==0 ? 
            () => showDialog(
              context: context, 
              builder: (BuildContext context) => const AddProduct(),
            ) 
            :
            null,
          icon: const Icon(Iconsax.add),
          label: Text(
            selectedChipWarehouse==2 ? appLocalization.addState! : 
            selectedChipWarehouse==1 ? appLocalization.addMovement! :
            appLocalization.addProduct! 
          ),
        )
        :
        null,

    );
  }
}