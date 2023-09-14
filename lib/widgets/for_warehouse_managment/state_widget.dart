import 'package:company_manager_client/models/stato.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final listOfStates= [
  Stato("disponibile", "-"),

];

class StateWidget extends ConsumerWidget {
  const StateWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
          child: InkWell(
            onTap: () => showDialog(
              context: context, 
              builder: (BuildContext buildContext) => AlertDialog(
                title: Text(
                  appLocalization.info!, 
                  style: const TextStyle(
                    fontSize: 15.0, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                content: SizedBox(
                  width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
                  child: Text(appLocalization.infoStateButton!),
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Iconsax.info_circle),
                const SizedBox(width: 5.0,),
                Text(appLocalization.info!),
                
              ],
            ),
          ),
        ),
        
        const SizedBox(height: 15.0,),
        Card(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
              columns: [
                DataColumn(label: Text(appLocalization.name!)),
                DataColumn(label: Text(appLocalization.favourite!)),
                const DataColumn(label: Text("")),
              ],
              rows: List<DataRow>.generate(
                listOfStates.length, 
                (index)  => DataRow(
                  cells: <DataCell> [
                    DataCell(Text(listOfStates[index].name.toString())),
                    DataCell(Text(listOfStates[index].favourite.toString())),
                    DataCell(
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.trash),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.star),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Iconsax.arrow_down),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/*
final snackBar = SnackBar(
                  content: Text(appLocalization.infoStateButton!),
                );
                ScaffoldMessenger.of(context).showSnackBar(snackBar);
*/