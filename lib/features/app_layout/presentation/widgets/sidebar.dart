import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/features/app_layout/domain/entities/sidebar_menu_data.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/sidebar_entry.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/user_logout.dart';

class Sidebar extends StatelessWidget {
  final Function(int) selectIndex;
  final int selectedIndex;
  Sidebar({
    super.key,
    required this.selectIndex,
    required this.selectedIndex,
  });

  final data = SidebarMenuData.data;

  @override
  Widget build(BuildContext context) {
    return ElevarmElevatedCard(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) => SidebarEntry(
                viewModel: data[index],
                isSelected: selectedIndex == index,
                onPressed: () => selectIndex(index),
              ),
            ),
          ),
          UserLogout(),
        ],
      ),
    );
  }
}
