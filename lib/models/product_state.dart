
import 'package:company_manager_client/models/product.dart';
import 'package:company_manager_client/models/product_detail.dart';
import 'package:company_manager_client/models/state_model.dart';

class ProductState {

  int? id;
  ProductDetail? productDetail;
  StateModel? state;
  int? quantity;
  Product? product;

  ProductState({
    this.id,
    this.quantity,
    this.state,
    this.productDetail,
    this.product,
  });

  factory ProductState.fromJson(Map<String, dynamic> json) {
    return ProductState(
      id: json['id'],
      quantity: json['quantity'],
      state: StateModel.fromJson(json['state']),
      productDetail: ProductDetail.fromJson(json['productDetail']),
      product: Product.fromJson(json['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'quantity': quantity,
      'state': state!.toJson(),
      'productDetail': productDetail!.toJson(),
      'product': product!.toJson(),
    };
  }

}