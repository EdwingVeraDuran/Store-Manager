class Client {
  final int? id;
  final String name;
  final String phone;
  final String address;
  final String hood;

  Client(
      {this.id,
      required this.name,
      required this.phone,
      required this.address,
      required this.hood});

  Map<String, dynamic> toMap() => {
        "name": name,
        "phone": phone,
        "address": address,
        "hood": hood,
      };

  factory Client.fromMap(Map<String, dynamic> json) => Client(
        id: json["id"],
        name: json["name"],
        phone: json["phone"],
        address: json["address"],
        hood: json["hood"],
      );
}
