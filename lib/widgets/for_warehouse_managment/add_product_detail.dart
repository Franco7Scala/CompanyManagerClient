import 'package:company_manager_client/main.dart';
import 'package:company_manager_client/models/product.dart';
import 'package:company_manager_client/models/product_detail.dart';
import 'package:company_manager_client/models/state_model.dart';
import 'package:company_manager_client/models/user.dart';
import 'package:company_manager_client/utils/app_localizations.dart';
import 'package:company_manager_client/utils/constants.dart';
import 'package:company_manager_client/utils/product_detail_state_model_user_wrapper.dart';
import 'package:company_manager_client/utils/responsive_layout.dart';
import 'package:company_manager_client/widgets/for_users_managment/list_of_users.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/list_of_product_transitions.dart';
import 'package:company_manager_client/widgets/for_warehouse_managment/list_of_state_model.dart';
import 'package:company_manager_client/widgets/loading_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';

final addProductDetailProvider=FutureProvider.family<void, ProductDetailStateModelUserWrapper>((ref, wrapper) async {
  final dio=ref.watch(dioProvider);
  await dio.put(
    "${Constants.baseUrl}/products/addProductDetail",
    data: wrapper.toJson(),
  );
  // ignore: unused_result
  ref.refresh(listOfProductTransiotionsProvider);
});

// ignore: must_be_immutable
class AddProductDetail extends ConsumerStatefulWidget {
  
  Product product;
  AddProductDetail({super.key, required this.product});

  @override
  AddProductDetailState createState() => AddProductDetailState();
}

class AddProductDetailState extends ConsumerState<AddProductDetail> {
  final _formKey = GlobalKey<FormState>(); //key for form validate

  //controllers for text fields
  final yearController=TextEditingController();
  final quantityController=TextEditingController();
  final priceForPrivateController=TextEditingController();
  final pricePerResellerController=TextEditingController();
  final stateController=TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    //watch providers
    final appLocalization=ref.watch(AppLocalizations.providers);

    late User user;
    int selectedStateModelIndex=0;
  
    ref.watch(listOfUsersProvider).when(
        data: (us){
          for(User u in us){
            if(u.id==48){
              user=u;
            }
          }
        },
        loading: () => null,
        error: (error, stackTrace) => null,
      );

    return AlertDialog(
      scrollable: true,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Text(appLocalization.addYear!)),
          const Icon(Iconsax.info_circle)
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
                controller: yearController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.year,
                ),
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext builContext) => AlertDialog(
                    content: SizedBox(
                      width: 300,
                      height: 300,
                      child: YearPicker(
                        firstDate: DateTime(DateTime.now().year - 100, 1),
                        lastDate: DateTime(DateTime.now().year + 100, 1),
                        initialDate: DateTime.now(),
                        selectedDate: DateTime.now(),
                        onChanged: (DateTime dateTime) {
                          yearController.text=dateTime.year.toString();
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ),
                ),
                validator: (quantity) {
                  if (quantity == null || quantity.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: quantityController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.quantity,
                ),
                validator: (quantity) {
                  if (quantity == null || quantity.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: priceForPrivateController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.priceForPrivate,
                ),
                validator: (price) {
                  if (price == null || price.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),
        
              TextFormField(
                controller: pricePerResellerController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: appLocalization.pricePerReseller,
                ),
                validator: (price) {
                  if (price == null || price.isEmpty) {
                    return appLocalization.fieldCannotEmpty;
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20.0,),

              ref.watch(listOfStateModelProvider).when(
                data: (listOfState) {
                  if(listOfState.isNotEmpty) {
                    return DropdownButtonFormField<StateModel>(
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: appLocalization.state,
                      ),
                      //value: listOfState[0],
                      items: List.generate(
                        listOfState.length, 
                        (index) { 
                          String nameState=listOfState[index].name!.substring(0, 1).toUpperCase()+listOfState[index].name!.substring(1);
                          return DropdownMenuItem(
                            value: listOfState[index],
                            child: Text(nameState),
                          );
                        }
                      ), 
                      onChanged: (StateModel? state) {
                        String name=state!.name!;
                        setState(() {
                          stateController.text=name;
                        });
                      },
                      isExpanded: true,
                      validator: (state) {
                        if (state == null) {
                          return appLocalization.fieldCannotEmpty;
                        }
                        return null;
                      },
                    );
                  }
                  else {
                    return TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: appLocalization.addStateFirst,
                      ),
                      enabled: false,
                      validator: (state) {
                        if (state == null || state.isEmpty) {
                          return appLocalization.fieldCannotEmpty;
                        }
                        return null;
                      },
                    );
                  }
                },
                loading: () => const LoadingWidget(),
                error: (error, stackTrace) => Text(error.toString()),
              ),
              const SizedBox(height: 20.0,),
        
            ],
          ),
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
          height: MediaQuery.of(context).size.width <= 382.0 ? 10.0 : null, 
        ),

        TextButton(
          onPressed: () {
            if (_formKey.currentState!.validate()){
              ProductDetail productDetail=ProductDetail(
                idProduct: widget.product.id, 
                year: yearController.text.isEmpty ? null : int.tryParse(yearController.text), 
                priceReseller: pricePerResellerController.text.isEmpty ? null : double.tryParse(pricePerResellerController.text),
                pricePrivate: priceForPrivateController.text.isEmpty ? null : double.tryParse(priceForPrivateController.text),
                quantity: quantityController.text.isEmpty ? null : int.tryParse(quantityController.text), 
                product: widget.product,
              );
              StateModel stateModel=StateModel(
                name: stateController.text,
              );
              ProductDetailStateModelUserWrapper wrapper=ProductDetailStateModelUserWrapper(
                productDetail: productDetail, 
                stateModel: stateModel,
                user: user,
              );
              ref.watch(addProductDetailProvider(wrapper));
              Navigator.pop(context);
            }
          }, 
          child: Text(appLocalization.addYear!),
        )


      ],
    );
  }
}


/* TextFormField(
  controller: yearController,
  decoration: InputDecoration(
    border: const OutlineInputBorder(),
    labelText: appLocalization.year,
  ),
  validator: (year) {
    if (year == null || year.isEmpty) {
      return appLocalization.fieldCannotEmpty;
    }
    else if(year.length != 4){
      return "4 caratteri";
    }
    return null;
  },
), */