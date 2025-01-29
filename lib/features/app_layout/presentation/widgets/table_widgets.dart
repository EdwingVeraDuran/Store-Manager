import 'package:data_table_2/data_table_2.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class TableWidgets {
  static DataColumn2 tableCheckboxColumn(void Function() onSelectAll) {
    return DataColumn2(
      label: ElevarmCheckbox(
        checked: false,
        onPressed: onSelectAll,
      ),
      fixedWidth: 50,
    );
  }

  static DataCell tableCheckboxCell(bool isChecked, void Function() onclick) {
    return DataCell(
      ElevarmCheckbox(
        checked: isChecked,
        onPressed: () {},
      ),
    );
  }

  static DataColumn2 tableActionsColumn() {
    return DataColumn2(
      label: Text("Acciones"),
      fixedWidth: 110,
    );
  }

  static DataCell tableActionsCell(
      void Function() onEdit, void Function() onDelete) {
    return DataCell(
      Row(
        children: [
          ElevarmSecondaryButton.iconOnly(
            iconAssetName: HugeIcons.strokeRoundedEdit01,
            height: ElevarmButtonHeights.sm,
            onPressed: onEdit,
          ),
          SizedBox(width: 8),
          ElevarmSecondaryButton.iconOnly(
            iconAssetName: HugeIcons.strokeRoundedDelete01,
            height: ElevarmButtonHeights.sm,
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }

  static DataColumn2 tableColumn(String label, {bool? isLarge}) {
    return DataColumn2(
        label: Text(label),
        size: isLarge == true ? ColumnSize.L : ColumnSize.M);
  }

  static DataCell tableCell(String text) {
    return DataCell(
      Text(
        text,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
