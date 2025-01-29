import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:store_manager/features/app_layout/domain/entities/sidebar_menu_data.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/sidebar.dart';

class LayoutPage extends StatefulWidget {
  const LayoutPage({super.key});

  @override
  State<LayoutPage> createState() => _LayoutPageState();
}

class _LayoutPageState extends State<LayoutPage> {
  int _selectedIndex = 0;

  void selectIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Sidebar(
                selectIndex: selectIndex,
                selectedIndex: _selectedIndex,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 8,
              child: ElevarmElevatedCard(
                child: SidebarMenuData.data[_selectedIndex].view,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
