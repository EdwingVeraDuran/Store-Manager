class Product {
  final int? id;
  final String code;
  final String name;
  final int buyPrice;
  final int sellPrice;
  final int stock;

  Product(
      {this.id,
      required this.code,
      required this.name,
      required this.buyPrice,
      required this.sellPrice,
      required this.stock});

  Map<String, dynamic> toMap() => {
        "code": code,
        "name": name,
        "buy_price": buyPrice,
        "sell_price": sellPrice,
        "stock": stock,
      };

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        buyPrice: json["buy_price"],
        sellPrice: json["sell_price"],
        stock: json["stock"],
      );
}
