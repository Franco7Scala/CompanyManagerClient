import 'package:company_manager_client/models/stuff_transition.dart';

class Stuff {

  double? quantity;
  double? threshold;
  bool? visible;
  int? id;
  String? name;
  String? unitMeasure;
  String? description;
  String? barCodeSingle;
  String? barCodePackage;
  List<StuffTransition>? stuffTransitionList;

  Stuff({
    this.quantity,
    this.threshold,
    this.visible=true,
    this.id,
    this.name,
    this.unitMeasure,
    this.description,
    this.barCodeSingle,
    this.barCodePackage,
    this.stuffTransitionList,
  });

  factory Stuff.fromJson(Map<String, dynamic> json) {
    List<StuffTransition> stuffTransitionList = (json['stuffTransitionList'] as List)
      .map((stuffTransitionJson) => StuffTransition.fromJson(stuffTransitionJson))
      .toList();
    
    return Stuff(
      quantity: json['quantity'],
      threshold: json['threshold'],
      visible: json['visible'],
      id: json['id'],
      name: json['name'],
      unitMeasure: json['unitMeasure'],
      description: json['description'],
      barCodeSingle: json['barCodeSingle'],
      barCodePackage: json['barCodePackage'],
      stuffTransitionList: stuffTransitionList,
    );
  }

  Map<String, dynamic> toJson() {      
    List<Map<String, dynamic>> stuffTransitionListJson=[];  

    if(stuffTransitionList!=null){
      stuffTransitionListJson= stuffTransitionList!.map((stuffTransition) => stuffTransition.toJson()).toList();
    } 

    return {
      'quantity': quantity,
      'threshold': threshold,
      'visible': visible,
      'id': id,
      'name': name,
      'unitMeasure': unitMeasure,
      'description': description,
      'barCodeSingle': barCodeSingle,
      'barCodePackage': barCodePackage,
      'stuffTransitionList': stuffTransitionListJson,
    };
  }


}

