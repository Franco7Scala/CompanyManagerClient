class Stuff {

  double quantity;
  double threshold;
  bool visible;
  int id;
  String name;
  String unitMeasure;
  String description;
  String barCodeSingle;
  String barCodePackage;
  //List<StuffTransition> stuffTransitionList;

  Stuff({
    required this.quantity,
    required this.threshold,
    this.visible=true,
    required this.id,
    required this.name,
    required this.unitMeasure,
    required this.description,
    required this.barCodeSingle,
    required this.barCodePackage,
  });

  factory Stuff.fromJson(Map<String, dynamic> json) {

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
    );
  }

  Map<String, dynamic> toJson() {        
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
    };
  }


}

