import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/capability_model.dart';
import 'package:company_manager_client/models/user.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_users_managment/list_of_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final selectedCapabilityProvider=StateProvider.autoDispose<int>((ref) => 0);

//post request using provider riverpod
final addUserProvider=FutureProvider.autoDispose.family<void, User>((ref, user) async {
  final dio=ref.watch(dioProvider);
  try{
    final response=await dio.post(
      "${Constants.baseUrl}/users",
      data: user.toJson(), 
    );
    if(response.statusCode == 200){
      debugPrint("OK");
    }
    else{
      debugPrint("BAD REQUEST");
    }
    ref.refresh(listOfUsersProvider);
  } 
  catch(e) {
    debugPrint("$e");
  }
});

class AddUser extends ConsumerStatefulWidget {
  const AddUser({super.key});

  @override
  AddUserState createState() => AddUserState();
}

class AddUserState extends ConsumerState<AddUser> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  //field controllers
  final firstNameController=TextEditingController();
  final lastNameController=TextEditingController();
  final usernameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final codeController=TextEditingController();
  final salaryPerDayController=TextEditingController();

  //var for show/hide password field
  bool _hidePassword = true;
  bool _isTyping = false;

  //user to create
  late User user;

  @override
  void initState() {
    super.initState();
    passwordController.addListener(_onTextChanged);
    user=User();
  }

  void _onTextChanged() {
    setState(() {
      _isTyping = passwordController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    passwordController.removeListener(_onTextChanged);
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    codeController.dispose();
    salaryPerDayController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //watch provider
    final appLocalization=ref.watch(AppLocalizations.providers);
    final selectedCapability=ref.watch(selectedCapabilityProvider);

    //enum??????
    final  listOfCapability = <String>[
      appLocalization.addProduct!,
      appLocalization.addStuffs!,
      appLocalization.products!,
      appLocalization.stuffs!,
      appLocalization.users!,
      appLocalization.workShift!,
    ];

    //pop up menu for choose capability
    PopupMenuButton addCapabilityPopupButton() => PopupMenuButton(
      icon: const Icon(Iconsax.add),
      initialValue: selectedCapability,
      //position: PopupMenuPosition.under,
      //offset: const Offset(0, 10.0),
      tooltip: appLocalization.addCapability,
      // Callback that sets the selected popup menu item.
      onSelected: (index) {
        ref.read(selectedCapabilityProvider.notifier).state=selectedCapability;
      },
      itemBuilder: (BuildContext context) => List<PopupMenuEntry>.generate(
        listOfCapability.length,
        (index) => PopupMenuItem(
          onTap: () {
            setState(() {
              user.capability.add(CapabilityModel(name: listOfCapability[index]));
            });
          },
          child: Text(listOfCapability[index]),
        ),
      ),
    );

    //widget to show capability and you can add and remove it
    Container myCapability() => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(appLocalization.capability!, style: const TextStyle(fontWeight: FontWeight.bold),),
                addCapabilityPopupButton(),
              ],
            ),
            const SizedBox(height: 10.0,),
            SingleChildScrollView(
              child: Column(
                children: List.generate(
                  user.capability.length, 
                  (index) {
                    return Column(
                      children: [
                        const Divider(),
                        Row(
                          children: <Widget>[
                            Expanded(child: Text(user.capability[index].name)),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  user.capability.removeAt(index);
                                });
                              },
                              icon: const Icon(Iconsax.trash),
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
          ],
        ),
      ),
    );

    //my text form field
    final myTextFormFields = [
      TextFormField(
        controller: firstNameController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: appLocalization.firstName,
        ),
        validator: (firstName) {
          if (firstName == null || firstName.isEmpty) {
            return appLocalization.fieldCannotEmpty;
          }
          return null;
        },
      ),
      const SizedBox(height: 20.0,),
      TextFormField(
        controller: lastNameController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: appLocalization.lastName,
        ),
        validator: (lastName) {
          if (lastName == null || lastName.isEmpty) {
            return appLocalization.fieldCannotEmpty;
          }
          return null;
        },
      ),
      const SizedBox(height: 20.0,),
      TextFormField(
        controller: usernameController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Username',
        ),
        validator: (username) {
          if (username == null || username.isEmpty) {
            return appLocalization.fieldCannotEmpty;
          }
          return null;
        },
      ),
      const SizedBox(height: 20.0,),
      TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      ),
      const SizedBox(height: 20.0,),
      TextFormField(
        controller: passwordController,
        obscureText: _hidePassword,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Password",
          suffixIcon: _isTyping
            ? IconButton(
              onPressed: () {
                setState(() {
                  _hidePassword = !_hidePassword;
                });
              },
              icon: Icon(
                  _hidePassword ? Iconsax.eye_slash : Iconsax.eye),
            )
            : 
            null,
        ),
        validator: (password) {
          if (password == null || password.isEmpty) {
            return appLocalization.fieldCannotEmpty;
          }
          return null;
        },
      ),
      const SizedBox(height: 20.0,),
      TextFormField(
        controller: codeController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: appLocalization.code,
        ),
      ),
      const SizedBox(height: 20.0,),
      TextFormField(
        controller: salaryPerDayController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: appLocalization.salaryPerDay,
        ),
      ),
      const SizedBox(height: 20.0,),
    ];

    //"container widget"
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            const Icon(Iconsax.user_add, size: 30.0,),
            const SizedBox(width: 10.0,),
            Expanded(child: Text(appLocalization.addUser!, style: const TextStyle(fontSize: 30.0),)),
          ],
        ),
      ),
      scrollable: true,
      content: SizedBox(
        width: !ResponsiveLayout.isMobile(context) ? 800.0 : 300.0,
        child: ResponsiveLayout.isMobile(context) ?
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(myTextFormFields.length, 
                (index) => myTextFormFields[index]
              )
            ),
          )
          : 
          //desktop layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //fisrt column contains Form
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: List.generate(
                      myTextFormFields.length, 
                      (index) => myTextFormFields[index]
                    )
                  ),
                ),
              ),
              const SizedBox(width: 20.0,),
              //second column contains capacities
              Expanded(
                child: Column(
                  children: <Widget>[
                    myCapability(),
                  ],
                ),
              )
            ],
          ),
        
      ),
      //action button alert dialog widget
      actions: <Widget>[
        //cancel button
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocalization.cancel!),
        ),
        //a little space
        SizedBox(
          height: MediaQuery.of(context).size.width <= 382.0 ? 10.0 : null, 
        ),
        //add user button
        TextButton(
          onPressed: () {
            //validate form first
            if (_formKey.currentState!.validate()) {
              //create user
              user.salaryPerDay= salaryPerDayController.text.isEmpty ? null : double.tryParse(salaryPerDayController.text);
              user.email= emailController.text.isEmpty ? null : emailController.text;
              user.username= usernameController.text;
              user.firstName= firstNameController.text; 
              user.lastName= lastNameController.text; 
              user.password= passwordController.text;
              user.code= codeController.text.isEmpty ? null : codeController.text;
              //call provider for add user request post with dio
              ref.watch(addUserProvider(user));
              //back to list of user
              Navigator.pop(context);
            }
          },
          child: Text(appLocalization.addUser!),
        )
      ],
    );
  }
}