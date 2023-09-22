import 'package:company_manager_client/models/user.dart';

class StuffTransition {

  double? quantity;
  DateTime? transitionDate;
  int? id;
  String? type;
  //Stuff? idStuff;
  User? idUser;

  StuffTransition({
    this.quantity,
    this.transitionDate,
    this.id,
    this.type,
    //this.idStuff,
    this.idUser,
  });

  factory StuffTransition.fromJson(Map<String, dynamic> json) {
    return StuffTransition(
      quantity: json['quantity'],
      transitionDate: DateTime.parse(json['transitionDate']),
      id: json['id'],
      type: json['type'],
      //idStuff: json['idStuff'],
      idUser: User.fromJson(json['idUser']),
    );
  }

  Map<String, dynamic> toJson() {      
    return {
      'quantity': quantity,
      'transitionDate': transitionDate!.toIso8601String(),
      'id': id,
      'type': type,
      //'idStuff': idStuff,
      'idUser': idUser!.toJson(),
    };
  }

}