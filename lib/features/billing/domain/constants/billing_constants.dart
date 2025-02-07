import 'package:data_table_2/data_table_2.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/table_widgets.dart';

class BillingConstants {
  static List<DataColumn2> columns = [
    TableWidgets.tableColumn("Código"),
    TableWidgets.tableColumn("Fecha"),
    TableWidgets.tableColumn("Teléfono Cliente"),
    TableWidgets.tableColumn("Total"),
    TableWidgets.tableActionsColumn(),
  ];
}
