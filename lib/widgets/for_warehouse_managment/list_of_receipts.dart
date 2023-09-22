
import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/receipt.dart';
import 'package:company_manager_client/models/user.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/widgets/for_users_managment/list_of_users.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

//get receipt from server
final listOfReceiptsProvider=FutureProvider<List<Receipt>>((ref) async {
  String endPoint="/receipts";
  final dio=ref.watch(dioProvider);
  final response=await dio.get("${Constants.baseUrl}$endPoint");
  final data=response.data;
  return List<Receipt>.from(data.map((receiptJson) => Receipt.fromJson(receiptJson)));
});

class ListOfReceipts extends ConsumerWidget {
  const ListOfReceipts({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    User? findUserByReceiptId(List<User> listOfusers, int receiptId) {
      for (final user in listOfusers) {
        final ricevutaTrovata = user.receiptList!.firstWhere(
          (ricevuta) => ricevuta.id == receiptId,
          orElse: () => Receipt(id: -1),
        );
        if (ricevutaTrovata.id != -1) {
          return user;
        }
      }
      return null; 
    }

    return ref.watch(listOfUsersProvider).when(
      data: (listOfUsers) {
        return listOfUsers.isNotEmpty ? 
          ref.watch(listOfReceiptsProvider).when(
            data: (listOfReceipts) {
              if(listOfReceipts.isNotEmpty) {
                return Card(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      columns: [
                        DataColumn(label: Text(appLocalization.date!)),
                        const DataColumn(label: Text("N")),
                        DataColumn(label: Text(appLocalization.user!)),
                        DataColumn(label: Text(appLocalization.termsOfPayment!)),
                        DataColumn(label: Text(appLocalization.price!)),
                        DataColumn(label: Text(appLocalization.discount!)),
                        DataColumn(label: Text(appLocalization.amount!)),
                        DataColumn(label: Text(appLocalization.print!)),
                      ],
                      rows: List<DataRow>.generate(
                        listOfReceipts.length, 
                        (index) {
                          final user=findUserByReceiptId(listOfUsers, listOfReceipts[index].id!);
                          return DataRow(
                            cells: <DataCell> [
                              DataCell(Text(listOfReceipts[index].receiptDate!.toIso8601String())),
                              DataCell(Text(listOfReceipts[index].dailyNumber.toString())),
                              DataCell(Text(user!.username!)),
                              DataCell(Text(listOfReceipts[index].termsOfPayment!)),
                              DataCell(Text(listOfReceipts[index].total.toString())),
                              DataCell(Text(listOfReceipts[index].discount.toString())),
                              DataCell(Text(listOfReceipts[index].totalDiscounted.toString())),
                              DataCell(
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Iconsax.printer),
                                )
                              ),
                            ],
                          );
                        }
                      ),
                    ),
                  ),
                );
              }
              else {
                return Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Text(
                    appLocalization.noReceipt!,
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontStyle: FontStyle.italic
                    ),
                  ),
                );
              }
            }, 
            error: (error, stackTrace) => Text(error.toString()), 
            loading: () => const LoadingWidget()
          )
          :
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              appLocalization.noUser!,
              style: const TextStyle(
                fontSize: 20.0,
                fontStyle: FontStyle.italic
              ),
            ),
          );
      },
      error: ((error, stackTrace) => Text(error.toString())), 
      loading: () => const LoadingWidget()
    );
  }
}

