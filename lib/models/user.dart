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
  List<CapabilityModel>? capabilityList;
  //List<Recipt> reiceptList=[];
  //List<ProductTransition> productTransitionList;
  //List<StuffTransition> stuffTransitionList;
  //List<Capability> capabilityList;
  //List<WorkingDay> workingDayList;

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
    this.capabilityList,
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
     List<CapabilityModel> capabilities = (json['capabilityList'] as List)
        .map((capabilityJson) => CapabilityModel.fromJson(capabilityJson))
        .toList();

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
      capabilityList: capabilities,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> capabilityListJson=[];
        
    
    if(capabilityList!=null){
      capabilityListJson= capabilityList!.map((capability) => capability.toJson()).toList();
    }
        
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
      'capabilityList': capabilityListJson,
    };
  }

}