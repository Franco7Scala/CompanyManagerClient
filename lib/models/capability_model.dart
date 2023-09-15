class CapabilityModel {

  String name;
  String? value;
  //List<User> userList=[];

  CapabilityModel({
    required this.name,
    this.value,
    //userList,
  });

  factory CapabilityModel.fromJson(Map<String, dynamic> json) {
    return CapabilityModel(
      name: json['name'],
      value: json['value'],
      //userList: json['userList'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'value': value,
      //'userList': userList,
    };
  }

}