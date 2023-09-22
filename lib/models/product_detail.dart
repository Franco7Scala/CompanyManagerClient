
import 'package:company_manager_client/models/product.dart';
import 'package:company_manager_client/models/product_in_receipt.dart';/* 
import 'package:company_manager_client/models/product_in_receipt.dart';
import 'package:company_manager_client/models/product_state.dart';
import 'package:company_manager_client/models/product_transition.dart';
 */
class ProductDetail {
  
  int? idProduct;
  int? year;
  double? priceReseller;
  double? pricePrivate;
  int? quantity;
  //List<ProductState>? productStateList;
  List<ProductInReceipt>? productInReceiptList;
  //List<ProductTransition>? productTransitionList;
  Product? product;

  ProductDetail({
    this.idProduct,
    this.year,
    this.priceReseller,
    this.pricePrivate,
    this.quantity,
    this.product,
    //this.productStateList,
    //this.productTransitionList, 
    this.productInReceiptList,
  });

  factory ProductDetail.fromJson(Map<String, dynamic> json) {
    /* List<ProductState> productStateList = (json['productStateList'] as List)
      .map((productStateJson) => ProductState.fromJson(productStateJson))
      .toList();

    List<ProductTransition> productTransitionList = (json['productTransitionList'] as List)
      .map((productTransitionJson) => ProductTransition.fromJson(productTransitionJson))
      .toList();
*/
    List<ProductInReceipt> productInReceiptList = (json['productInReceiptList'] as List)
      .map((productInReceiptJson) => ProductInReceipt.fromJson(productInReceiptJson))
      .toList();
 
    return ProductDetail(
      idProduct: json['idProduct'],
      year: json['year'],
      priceReseller: json['priceReseller'],
      pricePrivate: json['pricePrivate'],
      quantity: json['quantity'],
      //product: Product.fromJson(json['product']),
      //productStateList: productStateList,
      //productTransitionList: productTransitionList,
      productInReceiptList: productInReceiptList,
    );
  }

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> productInReceiptListJson=[];
  /*   List<Map<String, dynamic>> productStateListJson=[];
    List<Map<String, dynamic>> productTransitionListJson=[];
    
    
    if(productStateList!=null){
      productStateListJson=productStateList!.map((productState) => productState.toJson()).toList();
    } 

    if(productTransitionList!=null){
      productTransitionListJson=productTransitionList!.map((productTransition) => productTransition.toJson()).toList();
    } 

     */
    if(productInReceiptList!=null){
      productInReceiptListJson=productInReceiptList!.map((productinreceipt) => productinreceipt.toJson()).toList();
    }

    return {
      'idProduct': idProduct,
      'year': year,
      'priceReseller': priceReseller,
      'pricePrivate': pricePrivate,
      'quantity': quantity,
      'product': product!.toJson(),
      //'productStateList': productStateListJson,
      //'productTransitionList': productTransitionListJson,
      'productInReceiptList': productInReceiptListJson,
    };
  }

}