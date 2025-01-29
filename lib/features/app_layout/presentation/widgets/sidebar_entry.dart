import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/features/app_layout/domain/entities/view_model.dart';

class SidebarEntry extends StatelessWidget {
  final ViewModel viewModel;
  final bool isSelected;
  final VoidCallback onPressed;
  const SidebarEntry(
      {super.key,
      required this.viewModel,
      required this.isSelected,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? ElevarmColors.primary : Colors.transparent,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevarmIcon(
              viewModel.icon,
              size: 24,
              color: isSelected ? ElevarmColors.white : ElevarmColors.neutral,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Text(
                viewModel.label,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: ElevarmFontSizes.md,
                  fontWeight: ElevarmFontWeights.medium,
                  color:
                      isSelected ? ElevarmColors.white : ElevarmColors.neutral,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
