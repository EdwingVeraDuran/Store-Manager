class Bill {
  final int? id;
  final DateTime date;
  final String clientPhone;
  final int total;

  Bill(
      {this.id,
      required this.date,
      required this.clientPhone,
      required this.total});

  Map<String, dynamic> toMap() => {
        "date": date,
        "clientPhone": clientPhone,
        "total": total,
      };

  factory Bill.fromMap(Map<String, dynamic> json) => Bill(
        id: json["id"],
        date: json["date"],
        clientPhone: json["client_phone"],
        total: json["total"],
      );
}
