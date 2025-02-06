import 'package:data_table_2/data_table_2.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/table_widgets.dart';

class ClientsCostants {
  static List<DataColumn2> columns = [
    TableWidgets.tableColumn("Telefono"),
    TableWidgets.tableColumn("Nombre"),
    TableWidgets.tableColumn("Dirección", isLarge: true),
    TableWidgets.tableColumn("Barrio"),
    TableWidgets.tableColumn("Acciones"),
  ];
}
