//import 'package:company_manager_client/models/user.dart';

class WorkingDay {

  final int idUser;
  final DateTime workDate;
  bool visible;
  final DateTime? inTime;
  final DateTime? outTime;
  final String? description;
  //final User? user;

  WorkingDay({
    required this.idUser,
    required this.workDate,
    this.visible=true,
    this.inTime,
    this.outTime,
    this.description,
    //this.user,
  });

  factory WorkingDay.fromJson(Map<String, dynamic> json) {
    return WorkingDay(
      idUser: json['idUser'],
      workDate: DateTime.parse(json['workDate']),
      visible: json['visible'],
      inTime: DateTime.parse(json['inTime']),
      outTime: DateTime.parse(json['outTime']),
      description: json['description'],
      //user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'visible': visible,
      'idUser': idUser,
      'workDate': workDate.toIso8601String(),
      'inTime': inTime!.toIso8601String(),
      'outTime': outTime!.toIso8601String(),
      'description': description,
      //'user': user!.toJson(),
    };
  }

}