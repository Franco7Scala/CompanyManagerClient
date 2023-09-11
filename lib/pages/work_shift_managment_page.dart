import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_work_shift_managent/calendar.dart';
import 'package:company_manager_client/widgets/for_work_shift_managent/list_work_shift_users.dart';
import 'package:company_manager_client/widgets/my_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final showSelectedChipProvider=StateProvider<int>((ref) => -1);

class WorkShiftManagmentPage extends ConsumerWidget {
  const WorkShiftManagmentPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showSelectedChip=ref.watch(showSelectedChipProvider);
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
              children: <Widget>[
                ChoiceChip(
                  label: Text(appLocalization.showUsers!),
                  avatar: showSelectedChip!=0 ? const Icon(Iconsax.people) : null,
                  selected: showSelectedChip==0,
                  onSelected: (value) {
                    if(showSelectedChip==0){
                      ref.read(showSelectedChipProvider.notifier).state=-1;
                    }
                    else {
                      ref.read(showSelectedChipProvider.notifier).state=0;
                    }
                  }
                ),
                ChoiceChip(
                  label: Text(appLocalization.showCalendar!),
                  avatar: showSelectedChip!=1 ? const Icon(Iconsax.calendar_1) : null,
                  selected: showSelectedChip==1,
                  onSelected: (value) {
                    if(showSelectedChip==1){
                      ref.read(showSelectedChipProvider.notifier).state=-1;
                    }
                    else {
                      ref.read(showSelectedChipProvider.notifier).state=1;
                    }
                  }
                ),
              ],
            ),

            Visibility(
              visible: showSelectedChip!=-1,
              child: const SizedBox(height: 30.0),
            ),
            
            Visibility(
              visible: showSelectedChip==0,
              child: const ListWorkShiftUsers(),
            ),
            
            Visibility(
              visible: showSelectedChip==1,
              child: const Calendar(),
            ),

          ]
        ),
      ),

    );
  }
}


/*

body: body: SingleChildScrollView(
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


*/