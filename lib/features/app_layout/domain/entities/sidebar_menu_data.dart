import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/dashboard/presentation/pages/dashboard.dart';
import 'package:store_manager/features/app_layout/domain/entities/view_model.dart';
import 'package:store_manager/features/products/presentation/pages/products_page.dart';

class SidebarMenuData {
  static final data = <ViewModel>[
    ViewModel(
      label: 'Inicio',
      icon: HugeIcons.strokeRoundedDashboardSquare01,
      view: Dashboard(),
    ),
    ViewModel(
      label: "Productos",
      icon: HugeIcons.strokeRoundedShoppingCart01,
      view: ProductsPage(),
    ),
  ];
}
