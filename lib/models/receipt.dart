class Receipt {

  final DateTime date;
  final int number;
  final String user; //metti poi User user
  final String termsOfPayment;
  final double price;
  final int discount;
  final double amount;

  Receipt(this.date, this.number, this.user, this.termsOfPayment, this.price, this.discount, this.amount);

}