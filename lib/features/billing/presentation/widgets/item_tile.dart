import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/billing/domain/entities/cart_item.dart';
import 'package:store_manager/utilities/format_utilities.dart';

class ItemTile extends StatelessWidget {
  final CartItem item;
  final void Function()? onIncrement;
  final void Function()? onDecrement;
  const ItemTile(
      {super.key,
      required this.item,
      required this.onIncrement,
      required this.onDecrement});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "${item.product.name} - #${item.product.code}",
            style: TextStyle(fontSize: ElevarmFontSizes.md),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevarmSecondaryButton.iconOnly(
                iconAssetName: HugeIcons.strokeRoundedMinusSign,
                onPressed: onDecrement,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  item.amount.toString(),
                  style: TextStyle(
                    fontSize: ElevarmFontSizes.md,
                  ),
                ),
              ),
              ElevarmSecondaryButton.iconOnly(
                iconAssetName: HugeIcons.strokeRoundedAdd01,
                onPressed: onIncrement,
              ),
              SizedBox(width: 12),
              Text(
                FormatUtilities.formattedPrice(item.product.sellPrice),
                style: TextStyle(fontSize: ElevarmFontSizes.md),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
