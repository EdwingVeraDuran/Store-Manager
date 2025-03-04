import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/billing/presentation/pages/billing_page.dart';
import 'package:store_manager/features/clients/presentation/pages/clients_page.dart';
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
    ViewModel(
      label: "Clientes",
      icon: HugeIcons.strokeRoundedUser,
      view: ClientsPage(),
    ),
    ViewModel(
      label: "Facturas",
      icon: HugeIcons.strokeRoundedInvoice03,
      view: BillingPage(),
    ),
  ];
}
