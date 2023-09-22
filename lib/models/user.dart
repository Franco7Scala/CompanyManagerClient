import 'package:company_manager_client/models/capability_model.dart';
import 'package:company_manager_client/models/receipt.dart';
import 'package:company_manager_client/models/working_day.dart';

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
  List<WorkingDay>? workingDayList;
  List<Receipt>? receiptList=[];
  //List<ProductTransition> productTransitionList;
  //List<StuffTransition> stuffTransitionList;
  
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
    this.workingDayList,
    this.receiptList,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    List<CapabilityModel> capabilities = (json['capabilityList'] as List)
      .map((capabilityJson) => CapabilityModel.fromJson(capabilityJson))
      .toList();

    List<WorkingDay> workingDays = (json['workingDayList'] as List)
      .map((workingDayJson) => WorkingDay.fromJson(workingDayJson))
      .toList();
    
    List<Receipt> receiptList= (json['receiptList'] as List)
      .map((receiptJson) => Receipt.fromJson(receiptJson))
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
      workingDayList: workingDays,
      receiptList: receiptList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> capabilityListJson=[];
    List<Map<String, dynamic>> workingDayListJson=[];
    List<Map<String, dynamic>> receiptListJson=[];
    
    if(capabilityList!=null){
      capabilityListJson= capabilityList!.map((capability) => capability.toJson()).toList();
    }

    if(workingDayList != null){
      workingDayListJson=workingDayList!.map((workingDay) => workingDay.toJson()).toList();
    }

    if(receiptList != null){
      receiptListJson=receiptList!.map((receipt) => receipt.toJson()).toList();
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
      'workingDayList': workingDayListJson,
      'receiptList': receiptListJson,
    };
  }

}