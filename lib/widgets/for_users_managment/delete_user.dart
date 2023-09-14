import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/user.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/widgets/for_users_managment/list_of_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final deleteUserProvider=FutureProvider.autoDispose.family<void, User>((ref, user) async {
  final dio=ref.watch(dioProvider);
  try {
    final response=await dio.delete(
      "${Constants.baseUrl}/users/delete",
      data: user.toJson(),
    );
    if(response.statusCode==200){
      debugPrint("OK");
    }
    else {
      debugPrint("BAD REQUEST");
    }
    ref.refresh(listOfUsersProvider);
  }
  catch(e){
    debugPrint("$e");
  }
});

class DeleteUser extends ConsumerWidget {
  final User user;
  
  const DeleteUser({
    required this.user,
    super.key
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appLocalization=ref.watch(AppLocalizations.providers);

    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Iconsax.user_remove, size: 30.0,),
            const SizedBox(width: 10.0,),
            Expanded(
              child: RichText(
                text: TextSpan(
                  text: "${appLocalization.doYouWantToRemove} ",
                  style: const TextStyle(fontSize: 25.0),
                  children: <TextSpan> [
                    TextSpan(text: user.firstName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0)),
                    TextSpan(text: " ${user.lastName}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23.0)),
                    const TextSpan(text: " ?", style: TextStyle(fontSize: 25.0)),
                  ]
                ),
              ),
            ),
            //Expanded(child: Text("${appLocalization.doYouWantToRemove!} ${user.firstName} ${user.lastName}?")),
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
          //width: 5.0,
          height: MediaQuery.of(context).size.width <= 382.0 ? 10.0 : null, 
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.black,
          ),
          onPressed: () {
            ref.watch(deleteUserProvider(user));
            Navigator.pop(context);
          }, 
          child: Text(appLocalization.delete!),
        ),
      ],
    );
  }
}