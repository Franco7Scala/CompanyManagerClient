
import 'package:company_manager_client/models/product_detail.dart';
import 'package:company_manager_client/models/receipt.dart';

class ProductInReceipt {

  int? receiptId;
  int? productId;
  int? productYear;
  int? quantity;
  double? price;
  Receipt? receipt;
  ProductDetail? productDetail;

  ProductInReceipt({
    this.receiptId,
    this.productId,
    this.productYear,
    this.quantity,
    this.price,
    this.receipt,
    this.productDetail,
  });

  factory ProductInReceipt.fromJson(Map<String, dynamic> json) {
    return ProductInReceipt(
      receiptId: json['receiptId'],
      productId: json['productId'],
      productYear: json['productYear'],
      quantity: json['quantity'],
      price: json['price'],
      receipt: Receipt.fromJson(json['receipt']),
      productDetail: ProductDetail.fromJson(json['productDetail']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'receiptId': receiptId,
      'productId': productId,
      'productYear': productYear,
      'quantity': quantity,
      'price': price,
      'receipt': receipt!.toJson(),
      'productDetail': productDetail!.toJson(),
    };
  }

}