class Bill {
  final int? id;
  final DateTime? date;
  final String clientPhone;
  final int total;

  Bill({this.id, this.date, required this.clientPhone, required this.total});

  Map<String, dynamic> toMap() => {
        "client_phone": clientPhone,
        "total": total,
      };

  factory Bill.fromMap(Map<String, dynamic> json) => Bill(
        id: json["id"],
        date: DateTime.parse(json["date"]),
        clientPhone: json["client_phone"],
        total: json["total"],
      );
}
