import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/base_dialog.dart';
import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/domain/entities/cart_item.dart';
import 'package:store_manager/features/billing/presentation/cubits/billing_cubit.dart';
import 'package:store_manager/features/billing/presentation/widgets/item_tile.dart';
import 'package:store_manager/features/clients/presentation/cubits/clients_cubit.dart';
import 'package:store_manager/features/clients/presentation/cubits/clients_state.dart';
import 'package:store_manager/features/products/presentation/cubits/products_cubit.dart';
import 'package:store_manager/utilities/format_utilities.dart';
import 'package:store_manager/utilities/toast.dart';

class CreateBillDialog extends StatefulWidget {
  const CreateBillDialog({super.key});

  @override
  State<CreateBillDialog> createState() => _CreateBillDialogState();
}

class _CreateBillDialogState extends State<CreateBillDialog> {
  final productCodeController = TextEditingController();
  String clientPhone = "";
  final int total = 0;
  final List<CartItem> items = [];

  @override
  void initState() {
    super.initState();
    context.read<ClientsCubit>().readClients();
  }

  @override
  void dispose() {
    super.dispose();
    productCodeController.dispose();
  }

  void addProduct() async {
    final code = productCodeController.text;

    if (code.isEmpty) {
      Toast.warningToast("Campo vacio", "Por favor llenar el campo de código.");
      return;
    }

    final product = await context.read<ProductsCubit>().getProductByCode(code);

    if (product != null) {
      Toast.succesToast("Producto agregado con éxito",
          "Se ha agregado el producto #${product.code} - ${product.name}");
      setState(() {
        items.add(CartItem(product: product, amount: 1));
      });
    }

    productCodeController.clear();
  }

  int calcTotal() => items.fold(
      0, (total, item) => total + (item.product.sellPrice * item.amount));

  void create() {
    if (clientPhone.isEmpty) {
      Toast.warningToast(
          "Cliente no seleccionado", "Por favor seleccione un cliente.");
      return;
    }

    if (items.isEmpty) {
      Toast.warningToast(
          "Sin productos agregados", "Agregue productos a la venta.");
      return;
    }

    Navigator.of(context).pop();
    context
        .read<BillingCubit>()
        .createBill(Bill(clientPhone: clientPhone, total: calcTotal()), items);
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "Crear factura",
      buttonText: "Crear",
      width: 700,
      height: 600,
      onPressed: create,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevarmTextInputField(
                  hintText: "Código producto",
                  controller: productCodeController,
                  suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
                  onTapSuffix: () => productCodeController.clear(),
                  onFieldSubmitted: (p0) => addProduct(),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemTile(
                    item: item,
                    onDecrement: () {
                      setState(() {
                        if (item.amount == 1) {
                          items.remove(item);
                          return;
                        }

                        item.decrement();
                      });
                    },
                    onIncrement: () => setState(() => item.increment()));
              },
            ),
          ),
          Row(
            children: [
              BlocBuilder<ClientsCubit, ClientsState>(
                builder: (context, state) {
                  if (state is ClientsList) {
                    return Expanded(
                      child: ElevarmAutocompleteInputField(
                        options: state.clients
                            .map(
                              (client) => ElevarmAutocompleteInputFieldOption(
                                  value: client.phone, title: client.phone),
                            )
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              clientPhone = value;
                            });
                          }
                        },
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              SizedBox(width: 24),
              Text(
                "Total: ${FormatUtilities.formattedPrice(calcTotal())}",
                style: TextStyle(
                  fontSize: ElevarmFontSizes.lg,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
