import 'package:company_manager_client/models/capability_model.dart';

class User {
 
  double? salaryPerDay;
  String? email; 
  int id;
  String? username;
  String? firstName;
  String? lastName;
  String? password;
  String? code;
  bool visible;
  List<CapabilityModel> capability=[];

  User({
    this.salaryPerDay,
    this.email,
    this.id=0,
    this.username,
    this.firstName,
    this.lastName,
    this.password,
    this.code,
    this.visible=true,
    capability,
  });

  /* double? get getsalaryPerDay => salaryPerDay;
  String? get getEmail => email;
  int get getId => id;
  String? get getUserName => username;
  String? get getFirstName => firstName;
  String? get getLastName => lastName;
  String? get getPassword => password;
  String? get getCode => code;
  bool get getVisible => visible; */

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      salaryPerDay: json['salaryPerDay'],
      email: json['email'],
      id: json['id'],
      username: json['username'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      password: json['password'],
      code: json['code'],
      visible: json['visible'],
      /* capability: (json['capability'] as List<dynamic>)
          .map((e) => CapabilityModel.fromJson(e))
          .toList(), */
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'salaryPerDay': salaryPerDay,
      'email': email,
      'id': id,
      'username': username,
      'firstName': firstName,
      'lastName': lastName,
      'password': password,
      'code': code,
      'visible': visible,
      /* 'capability': capability.map((c) => c.toJson()).toList(), */
    };
  }

}