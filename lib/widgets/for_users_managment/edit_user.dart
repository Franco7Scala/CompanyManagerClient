import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/capability_model.dart';
import 'package:company_manager_client/models/user.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_users_managment/add_user.dart';
import 'package:company_manager_client/widgets/for_users_managment/list_of_users.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

//final selectedCapacityProvider=StateProvider<int>((ref) => 0);

////put request using provider riverpod
final editUserProvider=FutureProvider.autoDispose.family<void, User>((ref, user) async {
  final dio=ref.watch(dioProvider);
  try {
    final response=await dio.put(
      "${Constants.baseUrl}/users/editUser", 
      data: user.toJson(),
    );
    if(response.statusCode==200){
      debugPrint("OK");
    }
    else{
      debugPrint("BAD REQUEST");
    }
    // ignore: unused_result
    ref.refresh(listOfUsersProvider);
  }
  catch(e) {
    debugPrint("$e");
  }
});

// ignore: must_be_immutable
class EditUser extends ConsumerStatefulWidget {
  User user;

  EditUser({
    required this.user,
    super.key
  });

  @override
  EditUserState createState() => EditUserState();
}

class EditUserState extends ConsumerState<EditUser> {
  //key for validate form
  final _formKey = GlobalKey<FormState>();

  //field's controller
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController usernameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController codeController;
  late TextEditingController salaryPerDayController;

  //default value for salary per day
  late double? valueSalaryPerDay;

  //var for show/hide password
  bool _hidePassword = true;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    
    valueSalaryPerDay=widget.user.salaryPerDay;

    firstNameController=TextEditingController(text: widget.user.firstName);
    lastNameController=TextEditingController(text: widget.user.lastName);
    usernameController=TextEditingController(text: widget.user.username);
    emailController=TextEditingController(text: widget.user.email);
    passwordController=TextEditingController(text: widget.user.password);
    codeController=TextEditingController(text: widget.user.code);
    salaryPerDayController=TextEditingController(text: valueSalaryPerDay!=null ? valueSalaryPerDay.toString() : null);

    passwordController.addListener(_onTextChanged);

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
    //provider
    final appLocalization=ref.watch(AppLocalizations.providers);
    final selectedCapacity=ref.watch(selectedCapabilityProvider);
    final listOfUsers=ref.watch(listOfUsersProvider);

    //username to match for form validate
    List<String> usernameAlreadyUsed=[];
    
    listOfUsers.maybeWhen(
      data: (users) {
        for(User user in users) {
          usernameAlreadyUsed.add(user.username!);
        }
        for(String username in usernameAlreadyUsed){
          if(username==widget.user.username){
            usernameAlreadyUsed.remove(username);
          }
        }
      },
      orElse: () => null,
    );

    //enum capability??????
    final  listOfCapability = <String>[
      appLocalization.addProduct!,
      appLocalization.addStuffs!,
      appLocalization.products!,
      appLocalization.stuffs!,
      appLocalization.users!,
      appLocalization.workShift!,
    ];

    final  nameOfCapability = <String>[
      "add product",
      "add stuffs",
      "products",
      "stuffs",
      "users",
      "work shift",
    ];

    //pop up menu for choose capability
    PopupMenuButton addCapabilityPopupButton() => PopupMenuButton(
      icon: const Icon(Iconsax.add),
      initialValue: selectedCapacity,
      //position: PopupMenuPosition.under,
      //offset: const Offset(0, 10.0),
      tooltip: appLocalization.addCapability,
      // Callback that sets the selected popup menu item.
      onSelected: (index) {
        ref.read(selectedCapabilityProvider.notifier).state=selectedCapacity;
      },
      itemBuilder: (BuildContext context) => List<PopupMenuEntry>.generate(
        listOfCapability.length,
        (index) => PopupMenuItem(
          onTap: () {
            setState(() {
              widget.user.capabilityList!.add(CapabilityModel(name: nameOfCapability[index], value: nameOfCapability[index]));
            });
          },
          child: Text(listOfCapability[index]),
        ),
      ),
    );

    //widget to show user capability and you can add and remove it
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
                  widget.user.capabilityList!.length,
                  (index) {
                    return Column(
                      children: [
                        const Divider(),
                        Row(
                          children: <Widget>[
                            Expanded(child: Text(
                              widget.user.capabilityList![index].name=="add product" ? appLocalization.addProduct! :
                              widget.user.capabilityList![index].name=="add stuffs" ? appLocalization.addStuffs! :
                              widget.user.capabilityList![index].name=="products" ? appLocalization.products! :
                              widget.user.capabilityList![index].name=="stuffs" ? appLocalization.stuffs! :
                              widget.user.capabilityList![index].name=="users" ? appLocalization.users! :
                              widget.user.capabilityList![index].name=="work shift" ? appLocalization.workShift! :
                              ""
                            )),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  widget.user.capabilityList!.removeAt(index);
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

    //field's controller
    final myTextFormFields = [
      //text field for first name
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
      //text field for last name
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
      //text field for username
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
          for(String u in usernameAlreadyUsed){
            if(username==u){
              return appLocalization.usernameAlreadyUsed!;
            }
          }
          return null;
        },
      ),
      const SizedBox(height: 20.0,),
      //text field for email
      TextFormField(
        controller: emailController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Email',
        ),
      ),
      const SizedBox(height: 20.0,),
      //text field for password
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
          if(password.length < 8){
            return appLocalization.passwordMustContain8Caracter;
          }
          return null;
        },
      ),
      const SizedBox(height: 20.0,),
      //text field for code
      TextFormField(
        controller: codeController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: appLocalization.code,
        ),
      ),
      const SizedBox(height: 20.0,),
      //text field for salary per day
      TextFormField(
        controller: salaryPerDayController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: appLocalization.salaryPerDay,
        ),
      ),
      const SizedBox(height: 20.0,),
    ];

    //"container widget" -> Alert dialog widget
    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Row(
          children: [
            const Icon(Iconsax.user_edit, size: 30.0,),
            const SizedBox(width: 10.0,),
            Text(appLocalization.editUser!, style: const TextStyle(fontSize: 30.0),),
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
              children: List.generate(myTextFormFields.length, (index) => myTextFormFields[index])
            ),
          )
          : 
          //desktop layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //fisrt column
              Expanded(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: List.generate(myTextFormFields.length, (index) => myTextFormFields[index]),
                  ),
                ),
              ),
              const SizedBox(width: 20.0,),
              //second column
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
      //action button
      actions: <Widget>[
        OutlinedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(appLocalization.cancel!),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width <= 382.0 ? 10.0 : null, 
        ),
        TextButton(
          onPressed: () {
            //validate form first
            if (_formKey.currentState!.validate()) {
              //edit user
              widget.user.firstName=firstNameController.text;
              widget.user.lastName=lastNameController.text;
              widget.user.username=usernameController.text;
              widget.user.password=passwordController.text;
              widget.user.code=codeController.text;
              widget.user.salaryPerDay=double.tryParse(salaryPerDayController.text);
              //call provider for add user request post with dio
              ref.watch(editUserProvider(widget.user));
              //back to list of user
              Navigator.pop(context);
            }
          },
          child: Text(appLocalization.editUser!),
        )
      ],
    );
  }
}