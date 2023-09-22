
/* import 'package:company_manager_client/models/product_state.dart';
import 'package:company_manager_client/models/product_transition.dart'; */

class StateModel {

  bool? downloadable;
  //List<ProductTransition>? productTransitionList;
  //List<ProductTransition>? productTransitionList1;
  //List<ProductState>? productStateList;
  bool? visible;
  bool? favourite;
  String? name; //id

  StateModel({
    this.name,
    this.downloadable=true,
    this.visible=true,
    this.favourite=false,
    /* this.productTransitionList,
    this.productTransitionList1,
    this.productStateList, */
  });

  factory StateModel.fromJson(Map<String, dynamic> json) {
    /* List<ProductTransition> productTransitionList = (json['productTransitionList'] as List)
      .map((productTransitionJson) => ProductTransition.fromJson(productTransitionJson))
      .toList();

    List<ProductTransition> productTransitionList1 = (json['productTransitionList1'] as List)
      .map((productTransition1Json) => ProductTransition.fromJson(productTransition1Json))
      .toList();

     List<ProductState> productStateList = (json['productStateList'] as List)
      .map((productStateJson) => ProductState.fromJson(productStateJson))
      .toList(); */

    return StateModel(
      name: json['name'],
      downloadable: json['downloadable'],
      visible: json['visible'],
      favourite: json['favourite'],
      /* productTransitionList: productTransitionList,
      productTransitionList1: productTransitionList1,
      productStateList: productStateList, */
    );
  }

  Map<String, dynamic> toJson() {
    /* List<Map<String, dynamic>> productStateListJson=[];
    List<Map<String, dynamic>> productTransitionListJson=[];
    List<Map<String, dynamic>> productTransitionList1Json=[];
    
    if(productStateList!=null){
      productStateListJson=productStateList!.map((productState) => productState.toJson()).toList();
    } 

    if(productTransitionList!=null){
      productTransitionListJson=productTransitionList!.map((productTransition) => productTransition.toJson()).toList();
    } 

    if(productTransitionList1!=null){
      productTransitionList1Json=productTransitionList1!.map((productTransition) => productTransition.toJson()).toList();
    }  */

    return {
      'name': name,
      'downloadable': downloadable,
      'visible': visible,
      'favourite': favourite,
      /* 'productStateList': productStateListJson,
      'productTransitionList' :productTransitionListJson,
      'productTransitionList1' :productTransitionList1Json, */
    };
  }

}