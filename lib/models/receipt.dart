import 'package:company_manager_client/models/product_in_receipt.dart';
import 'package:company_manager_client/models/user.dart';

class Receipt {

  double? total;
  double? totalDiscounted;
  int? user; //id user
  int? discount;
  int? id;
  int? cashRegisterNumber;
  String? cashRegisterFresher;
  DateTime? receiptDate;
  int? dailyNumber;
  String? termsOfPayment;
  List<ProductInReceipt>? productInReceiptList;

  Receipt({
    this.total,
    this.totalDiscounted,
    this.user,
    this.discount=0,
    this.id,
    this.cashRegisterNumber,
    this.cashRegisterFresher,
    this.receiptDate,
    this.dailyNumber,
    this.termsOfPayment,
    this.productInReceiptList,
  });

  factory Receipt.fromJson(Map<String, dynamic> json) {
    List<ProductInReceipt> productInReceiptList = (json['productInReceiptList'] as List)
      .map((productInReceiptJson) => ProductInReceipt.fromJson(productInReceiptJson))
      .toList();

    return Receipt(
      total: json['total'],
      totalDiscounted: json['totalDiscounted'],
      user: json['user'], //User.fromJson(json['user']),
      discount: json['discount'],
      id: json['id'],
      cashRegisterNumber: json['cashRegisterNumber'],
      cashRegisterFresher: json['cashRegisterFresher'],
      receiptDate: DateTime.parse(json['receiptDate']),
      dailyNumber: json['dailyNumber'],
      termsOfPayment: json['termsOfPayment'],
      productInReceiptList: productInReceiptList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productInReceiptListJson=[];

     if(productInReceiptList!=null){
      productInReceiptListJson=productInReceiptList!.map((productInReceipt) => productInReceipt.toJson()).toList();
    }

    return {
      'total': total,
      'totalDiscounted': totalDiscounted,
      'user': user,
      'discount': discount,
      'id': id,
      'cashRegisterNumber': cashRegisterNumber,
      'cashRegisterFresher': cashRegisterFresher,
      'receiptDate': receiptDate!.toIso8601String(),
      'dailyNumber': dailyNumber,
      'termsOfPayment': termsOfPayment,
      'productInReceiptList': productInReceiptListJson,
    };
  }

}

