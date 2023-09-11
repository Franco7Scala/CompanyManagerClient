import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_users_managment/add_user.dart';
import 'package:company_manager_client/widgets/for_users_managment/list_of_users.dart';
import 'package:company_manager_client/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final showListofUsersProvider=StateProvider<int>((ref) => -1);

class UserManagmentPage extends ConsumerWidget {
  const UserManagmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    final showListOfUsers=ref.watch(showListofUsersProvider);
    
    return Scaffold(

      appBar: const MyAppBar(),

      floatingActionButton: ResponsiveLayout.isMobile(context) ? 
        FloatingActionButton(
          onPressed: () => showDialog(
            context: context, 
            builder: (BuildContext context) => const AddUser(),
          ),
          tooltip: appLocalization.addUser,
          child: const Icon(Iconsax.add),
        ) 
        :
        FloatingActionButton.extended(
          onPressed: () => showDialog(
            context: context, 
            builder: (BuildContext context) => const AddUser(),
          ),
          icon: const Icon(Iconsax.add),
          label: Text(appLocalization.addUser!)
        ),

      body: SingleChildScrollView(
        padding: ResponsiveLayout.isMobile(context) ? const EdgeInsets.all(12.0) : const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            ChoiceChip(
              label: Text(appLocalization.showUsers!),
              avatar: showListOfUsers!=0 ? const Icon(Iconsax.profile_2user) : null,
              selected: showListOfUsers==0,
              onSelected: (value) {
                if(showListOfUsers==0){
                  ref.read(showListofUsersProvider.notifier).state=-1;
                }
                else {
                  ref.read(showListofUsersProvider.notifier).state=0;
                }
              }
            ),

            Visibility(
              visible: showListOfUsers==0,
              child: const SizedBox(height: 30.0),
            ),
            
            Visibility(
              visible: showListOfUsers==0,
              child: const ListOfUsers(),
            ),

          ],
        ),
      ),

    );
  }
}