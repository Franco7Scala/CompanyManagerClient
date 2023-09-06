import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final selectedCapacityProvider=StateProvider.autoDispose<int>((ref) => 0);

final addedCapacities=[
  "mocpamlc",
  "aacsacasc",
];

class AddUser extends ConsumerStatefulWidget {
  const AddUser({super.key});

  @override
  AddUserState createState() => AddUserState();
}

class AddUserState extends ConsumerState<AddUser> {
  final firstNameController=TextEditingController();
  final lastNameController=TextEditingController();
  final usernameController=TextEditingController();
  final emailController=TextEditingController();
  final passwordController=TextEditingController();
  final codeController=TextEditingController();
  final dailyWageController=TextEditingController();
  bool _hidePassword = true;
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
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
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLocalization=ref.watch(AppLocalizations.providers);
    final selectedCapacity=ref.watch(selectedCapacityProvider);

    final  listOfCapacity = <String>[
      appLocalization.addProduct!,
      appLocalization.addStuffs!,
      appLocalization.products!,
      appLocalization.stuffs!,
      appLocalization.users!,
      appLocalization.workShift!,
    ];

    TextField myTextField(TextEditingController controller, String label){
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: label,
        ),
      );  
    }

    TextField myPasswordTextField(){
      return TextField(
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
      );
    }

    PopupMenuButton addCapacitiesButton() => PopupMenuButton(
      icon: const Icon(Iconsax.add),
      initialValue: selectedCapacity,
      //position: PopupMenuPosition.under,
      //offset: const Offset(0, 10.0),
      tooltip: appLocalization.addCapacity,
      // Callback that sets the selected popup menu item.
      onSelected: (index) {
        ref.read(selectedCapacityProvider.notifier).state=selectedCapacity;
      },
      itemBuilder: (BuildContext context) => List<PopupMenuEntry>.generate(
        listOfCapacity.length,
        (index) => PopupMenuItem(
          onTap: () {},
          child: Text(listOfCapacity[index]),
        ),
      ),
    );

    Container myCapacity() => Container(
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
                Text(appLocalization.capacity!, style: const TextStyle(fontWeight: FontWeight.bold),),
                addCapacitiesButton(),
              ],
            ),
            const SizedBox(height: 10.0,),
            
            SingleChildScrollView(
              child: Column(
                children: List.generate(
                  addedCapacities.length, 
                  (index) {
                    return Column(
                      children: [
                        const Divider(),
                        Row(
                          children: <Widget>[
                            Expanded(child: Text(addedCapacities[index])),
                            IconButton(
                              onPressed: () {},
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

    return AlertDialog(
      title: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Text(appLocalization.addUser!, style: const TextStyle(fontSize: 30.0),),
      ),
      scrollable: true,
      content: SizedBox(
        width: !ResponsiveLayout.isMobile(context) ? 800.0 : 300.0,
        child: ResponsiveLayout.isMobile(context) ?
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              
              myTextField(firstNameController, appLocalization.firstName!),
              const SizedBox(height: 20.0,),
          
              myTextField(lastNameController, appLocalization.lastName!),
              const SizedBox(height: 20.0,),
          
              myTextField(usernameController, "Username"),
              const SizedBox(height: 20.0,),
          
              myTextField(emailController, "Email"),
              const SizedBox(height: 20.0,),
          
              myPasswordTextField(),
              const SizedBox(height: 20.0,),
    
              myTextField(codeController, appLocalization.code!),
              const SizedBox(height: 20.0,),
          
              myTextField(dailyWageController, appLocalization.dailyWage!),
              const SizedBox(height: 20.0,),
  
              myCapacity(),
            ],
          )
          : 
          //desktop layout
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //fisrt column
              Expanded(
                child: Column(
                  children: <Widget>[
        
                    myTextField(firstNameController, appLocalization.firstName!),
                    const SizedBox(height: 20.0,),
                
                    myTextField(lastNameController, appLocalization.lastName!),
                    const SizedBox(height: 20.0,),
                
                    myTextField(usernameController, "Username"),
                    const SizedBox(height: 20.0,),
                
                    myTextField(emailController, "Email"),
                    const SizedBox(height: 20.0,),
                
                    myPasswordTextField(),
                    const SizedBox(height: 20.0,),
        
                    myTextField(codeController, appLocalization.code!),
                    const SizedBox(height: 20.0,),
                
                    myTextField(dailyWageController, appLocalization.dailyWage!),
                    const SizedBox(height: 20.0,),
                    
                  ],
                ),
              ),
              const SizedBox(width: 20.0,),
              //second column
              Expanded(
                child: Column(
                  children: <Widget>[
        
                    myCapacity(),
        
                  ],
                ),
              )
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
          child: Text(appLocalization.addUser!),
        )
      ],
    );
  }
}