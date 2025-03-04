import 'package:intl/intl.dart';

class FormatUtilities {
  static String formattedPrice(int price) =>
      NumberFormat.currency(locale: "es_CO", symbol: "\$COP", decimalDigits: 0)
          .format(price);

  static String formattedDate(DateTime date) =>
      DateFormat('dd/MM/yyyy - HH:mm').format(date);
}
