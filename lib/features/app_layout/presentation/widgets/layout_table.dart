import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class LayoutTable extends StatelessWidget {
  final List<DataColumn2> columns;
  final List<DataRow> data;
  const LayoutTable({super.key, required this.columns, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: DataTable2(
        columns: columns,
        rows: data,
      ),
    );
  }
}
