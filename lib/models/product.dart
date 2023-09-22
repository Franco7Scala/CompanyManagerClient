import 'package:company_manager_client/models/product_detail.dart';

class Product {

  String? code;
  String? name;
  int? id;
  String? barCodeSingle;
  String? barCodePackage;
  String? description;
  List<ProductDetail>? productDetailList;
  //List<ProductState>? productStateList;

  Product({
    this.code,
    this.name,
    this.id=0,
    this.barCodeSingle,
    this.barCodePackage,
    this.description,
    this.productDetailList,
    //this.productStateList,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    List<ProductDetail> productDetailList = (json['productDetailList'] as List)
      .map((productDetailJson) => ProductDetail.fromJson(productDetailJson))
      .toList();
    /*
    List<ProductState> productStateList = (json['productStateList'] as List)
      .map((productStateJson) => ProductState.fromJson(productStateJson))
      .toList(); */

    return Product(
      code: json['code'],
      name: json['name'],
      id: json['id'],
      barCodeSingle: json['barCodeSingle'],
      barCodePackage: json['barCodePackage'],
      description: json['description'],
      productDetailList: productDetailList,
      //productStateList: productStateList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productDetailListJson=[];
    //List<Map<String, dynamic>> productStateListJson=[];

    if(productDetailList!=null){
      productDetailListJson=productDetailList!.map((productDetail) => productDetail.toJson()).toList();
    } 

    /* if(productStateList!=null){
      productStateListJson=productStateList!.map((productState) => productState.toJson()).toList();
    }  */
    
    return {
      'code': code,
      'name': name,
      'id': id,
      'barCodeSingle': barCodeSingle,
      'barCodePackage': barCodePackage,
      'description': description,
      'productDetailList': productDetailListJson,
      //'productStateList': productStateListJson,
    };
  }

}
