import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

class EditUserWorkShift extends ConsumerStatefulWidget {
  const EditUserWorkShift({super.key});

  @override
  EditUserWorkShiftState createState() => EditUserWorkShiftState();
}

class EditUserWorkShiftState extends ConsumerState<EditUserWorkShift> {
  final dateController=TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    Future<void> selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      cancelText: appLocalization.cancel,
      confirmText: appLocalization.addDay,
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        dateController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
  }

    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(appLocalization.editUser!, style: const TextStyle(fontSize: 30.0),),
      ),
      scrollable: true,
      content: SizedBox(
        width: ResponsiveLayout.isMobile(context) ? 300.0 : 400.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Text(appLocalization.summary!, style: const TextStyle(fontWeight: FontWeight.bold),),
            const SizedBox(height: 10.0,),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0)
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: <DataColumn> [
                    DataColumn(label: Text(appLocalization.month!)),
                    DataColumn(label: Text(appLocalization.days!)),
                    DataColumn(label: Text(appLocalization.salary!)),
                  ], 
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text(appLocalization.thisMonth!)),
                        DataCell(Text("-")),
                        DataCell(Text("-")),
                      ],
                    ),
                    DataRow(
                      cells: [
                        DataCell(Text(appLocalization.previousMonth!)),
                        DataCell(Text("-")),
                        DataCell(Text("-")),
                      ],
                    ),
                  ]
                ),
              ),
            ),
            const SizedBox(height: 30.0,),

            

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(appLocalization.days!, style: const TextStyle(fontWeight: FontWeight.bold),),
                IconButton(
                  onPressed: () => selectDate(),
                  tooltip: appLocalization.addDay,
                  icon: const Icon(Iconsax.add) 
                ),
              ],
            ),
            const SizedBox(height: 5.0,),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8.0)
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: <DataColumn> [
                    DataColumn(label: Text(appLocalization.date!)),
                  ], 
                  rows: [
                    DataRow(
                      cells: [
                        DataCell(Text(appLocalization.noResult!)),
                        
                      ],
                    ),
                    
                  ]
                ),
              ),
            ),

          ],
        ),
      ),
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocalization.cancel!),
        ),
        SizedBox(
          width: 5.0,
          height: MediaQuery.of(context).size.width <= 366.0 ? 10.0 : null, 
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocalization.editUser!),
        )
      ],
    );
  }
}

