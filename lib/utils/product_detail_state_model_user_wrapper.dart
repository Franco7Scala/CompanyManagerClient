
import 'package:company_manager_client/models/product_detail.dart';
import 'package:company_manager_client/models/state_model.dart';
import 'package:company_manager_client/models/user.dart';

class ProductDetailStateModelUserWrapper {

  ProductDetail productDetail;
  StateModel stateModel;
  User user;

  ProductDetailStateModelUserWrapper({
    required this.productDetail,
    required this.stateModel,
    required this.user,
  });

  factory ProductDetailStateModelUserWrapper.fromJson(Map<String, dynamic> json) {
    return ProductDetailStateModelUserWrapper(
      productDetail: ProductDetail.fromJson(json['productDetail']),
      stateModel: StateModel.fromJson(json['state']),
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productDetail': productDetail.toJson(),
      'state': stateModel.toJson(),
      'user': user.toJson(),
    };
  }

}