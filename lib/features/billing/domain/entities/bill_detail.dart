class BillDetail {
  final int? id;
  final int billId;
  final int productId;
  int amount;
  final int price;

  BillDetail(
      {this.id,
      required this.billId,
      required this.productId,
      required this.amount,
      required this.price});

  Map<String, dynamic> toMap() => {
        "bill_id": billId,
        "product_id": productId,
        "amount": amount,
        "price": price,
      };

  factory BillDetail.fromMap(Map<String, dynamic> json) => BillDetail(
        id: json["id"],
        billId: json["bill_id"],
        productId: json["product_id"],
        amount: json["amount"],
        price: json["price"],
      );
}
