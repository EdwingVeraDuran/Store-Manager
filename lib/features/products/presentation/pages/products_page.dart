import 'package:data_table_2/data_table_2.dart';
import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/layout_header.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/layout_table.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/table_widgets.dart';
import 'package:store_manager/features/products/domain/entities/product.dart';
import 'package:store_manager/features/products/presentation/cubits/products_cubit.dart';
import 'package:store_manager/features/products/presentation/cubits/products_state.dart';
import 'package:store_manager/features/products/presentation/dialogs/create_product_dialog.dart';
import 'package:store_manager/features/products/presentation/dialogs/edit_product_dialog.dart';
import 'package:store_manager/utilities/format_utilities.dart';
import 'package:store_manager/utilities/toast.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final productsCubit = context.read<ProductsCubit>();

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productsCubit.readProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductsCubit, ProductsState>(
      listener: (context, state) {
        if (state is ProductCreated) {
          Toast.succesToast("Producto creado",
              "Se ha creado correctamente el producto #${state.product.code} - ${state.product.name}");
        }

        if (state is ProductUpdated) {
          Toast.succesToast("Producto actualizado",
              "Se ha actualizado el producto #${state.product.code} - ${state.product.name}");
        }
        if (state is ProductDeleted) {
          Toast.succesToast("Producto eliminado",
              "Se ha eliminado el producto #${state.product.code} - ${state.product.name}");
        }
      },
      builder: (context, state) {
        Widget content = SizedBox.shrink();

        if (state is ProductsLoading) {
          content = Center(child: CircularProgressIndicator());
        } else if (state is ProductsEmpty) {
          content = Center(child: Text("No existen productos."));
        } else if (state is ProductsList) {
          content = LayoutTable(columns: columns(), data: data(state.products));
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              LayoutHeader(
                controller: searchController,
                onSearch: (p0) => productsCubit.searchProducts(p0),
                onClearSearch: () {
                  searchController.clear();
                  productsCubit.readProducts();
                },
                onCreate: () => showDialog(
                    context: context,
                    builder: (BuildContext context) => CreateProductDialog()),
              ),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }

  List<DataColumn2> columns() {
    return [
      TableWidgets.tableColumn("Código"),
      TableWidgets.tableColumn("Nombre", isLarge: true),
      TableWidgets.tableColumn("\$ Compra"),
      TableWidgets.tableColumn("\$ Venta"),
      TableWidgets.tableColumn("Unidades"),
      TableWidgets.tableColumn("Acciones"),
    ];
  }

  List<DataRow> data(List<Product> products) {
    return products.map((e) => row(e)).toList();
  }

  DataRow row(Product product) {
    return DataRow(
      cells: [
        TableWidgets.tableCell("# ${product.code}"),
        TableWidgets.tableCell(product.name),
        TableWidgets.tableCell(
            FormatUtilities.formattedPrice(product.buyPrice)),
        TableWidgets.tableCell(
            FormatUtilities.formattedPrice(product.sellPrice)),
        TableWidgets.tableCell("${product.stock}"),
        TableWidgets.tableActionsCell(
          () => showDialog(
              context: context,
              builder: (context) => EditProductDialog(product: product)),
          () => ElevarmConfirmAlertDialog(
            title: "Eliminar producto",
            subtitle:
                "Desea eliminar el producto con código: # ${product.code}",
            variant: ElevarmDialogVariant.danger,
            negativeText: "Cancelar",
            onNegativeButton: () => Navigator.of(context).pop(),
            positiveText: "Eliminar",
            onPositiveButton: () {
              context.read<ProductsCubit>().deleteProduct(product.id!);
              Navigator.of(context).pop();
            },
          ).show(context),
        ),
      ],
    );
  }
}
