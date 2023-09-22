import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:just_the_tooltip/just_the_tooltip.dart';

final listReadyForUnloading=[

];

class AddTransition extends ConsumerStatefulWidget {
  const AddTransition({super.key});

  @override
  AddTransitionState createState() => AddTransitionState();
}

class AddTransitionState extends ConsumerState<AddTransition> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  final transitionController=TextEditingController();
  final searchController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    Widget infoTransitionButton() => JustTheTooltip(
      content: SizedBox(
        width: 400,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(appLocalization.infoMovementButton!, textAlign: TextAlign.justify,)
        ),
      ),
      isModal: true, 
      offset: 5.0,
      child: const Icon(Iconsax.info_circle),
    );

    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Icon(Iconsax.refresh),
              Text(appLocalization.addMovement!),
            ],
          ),
          infoTransitionButton(),
        ],
      ),
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 15.0,),
        
              TextFormField(
                controller: transitionController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.enterReasonForUnloading, 
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30.0,),

              /* TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.searchByProductName,
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),

              OutlinedButton(
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                onPressed: () {}, 
                child: const Icon(Iconsax.search_normal_1),
              ), */
              
               Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                 child: Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                       TextFormField(
                         controller: searchController,
                         decoration: InputDecoration(
                           border: const OutlineInputBorder(),
                           labelText: appLocalization.searchByProductName,
                         ),
                         validator: (text) {
                           if (text == null || text.isEmpty) {
                             return appLocalization.fieldCannotEmpty;
                           }
                           return null;
                         },
                       ),
                       const SizedBox(height: 15.0,),
                       OutlinedButton(
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                        ),
                         onPressed: () {}, 
                         child: const Icon(Iconsax.search_normal_1),
                       ),
                     ],
                   ),
                 ),
               ), 
              const SizedBox(height: 30.0,),
        
              TextButton(
                onPressed: (){},
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                ),
                child: Text(appLocalization.confirm!),
              ),
              const SizedBox(height: 25.0,),
        
              Center(
                child: InkWell(
                  onTap: () => showDialog(
                    context: context, 
                    builder: (BuildContext buildContext) => AlertDialog(
                      title: Wrap(
                        spacing: 10.0,
                        runSpacing: 10.0,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          const Icon(Iconsax.arrow_down),
                          Text(appLocalization.readyForUnloading!),
                        ],
                      ),
                      content: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            DataTable(
                              columns: [
                                DataColumn(label: Text(appLocalization.name!)),
                                DataColumn(label: Text(appLocalization.year!)),
                                DataColumn(label: Text(appLocalization.boxes!)),
                                DataColumn(label: Text(appLocalization.bottles!)),
                                DataColumn(label: Text(appLocalization.from!)),
                                DataColumn(label: Text(appLocalization.to!)),
                              ],
                              rows: List<DataRow>.generate(
                                listReadyForUnloading.length, 
                                (index)  => DataRow(
                                  cells: <DataCell> [
                                    DataCell(Text(listReadyForUnloading[index].toString())),
                                    DataCell(Text(listReadyForUnloading[index].toString())),
                                    DataCell(Text(listReadyForUnloading[index].toString())),
                                    DataCell(Text(listReadyForUnloading[index].toString())),
                                    DataCell(Text(listReadyForUnloading[index].toString())),
                                    DataCell(Text(listReadyForUnloading[index].toString())),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20.0,),
                            Text(appLocalization.priceForPrivate!),
                            const SizedBox(height: 5.0,),
                            Text(appLocalization.pricePerReseller!)
                          ],
                        ),
                      ),
                    )
                  ),
                  child: Text(appLocalization.readyForUnloading!),
                ),
              )
        
        
        
        
            ],
          ),
        ),
      ),
    );
  }
}