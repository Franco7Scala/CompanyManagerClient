
import 'package:company_manager_client/models/product_detail.dart';
import 'package:company_manager_client/models/state_model.dart';
import 'package:company_manager_client/models/user.dart';

class ProductTransition {

  int? id;
  DateTime? transitionDate;
  String? description;
  int? quantity;
  StateModel? fromState;
  StateModel? toState;
  User? idUser;
  ProductDetail? productDetail;
  int? quantityPackages;
  int? quantitySingle;
  int? newQuantityPackages;
  int? newQuantitySingle;

  ProductTransition({
    this.id,
    this.transitionDate,
    this.description,
    this.quantity,
    this.fromState,
    this.toState,
    this.idUser,
    this.productDetail,
    this.quantityPackages=0,
    this.quantitySingle=0,
    this.newQuantityPackages=0,
    this.newQuantitySingle=0
  });

  factory ProductTransition.fromJson(Map<String, dynamic> json) {
    return ProductTransition(
      id: json['id'],
      transitionDate: DateTime.parse(json['transitionDate']),
      description: json['description'],
      quantity: json['quantity'],
      fromState: StateModel.fromJson(json['fromState']),
      toState: StateModel.fromJson(json['toState']),
      idUser: User.fromJson(json['idUser']),
      productDetail: ProductDetail.fromJson(json['productDetail']),
      quantityPackages: json['quantityPackages'],
      quantitySingle: json['quantitySingle'],
      newQuantityPackages: json['newQuantityPackages'],
      newQuantitySingle: json['newQuantitySingle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transitionDate': transitionDate!.toIso8601String(),
      'description': description,
      'quantity': quantity,
      'fromState': fromState!.toJson(),
      'toState': toState!.toJson(),
      'idUser': idUser!.toJson(),
      'productDetail': productDetail!.toJson(),
      'quantityPackages': quantityPackages,
      'quantitySinglequantitySingle': quantitySingle,
      'newQuantityPackages': newQuantityPackages,
      'newQuantitySingle': newQuantitySingle,
    };
  }

}