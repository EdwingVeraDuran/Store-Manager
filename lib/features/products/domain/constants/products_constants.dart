import 'package:data_table_2/data_table_2.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/table_widgets.dart';

class ProductsConstants {
  static List<DataColumn2> columns = [
    TableWidgets.tableColumn("Código"),
    TableWidgets.tableColumn("Nombre", isLarge: true),
    TableWidgets.tableColumn("\$ Compra"),
    TableWidgets.tableColumn("\$ Venta"),
    TableWidgets.tableColumn("Unidades"),
    TableWidgets.tableColumn("Acciones"),
  ];
}
