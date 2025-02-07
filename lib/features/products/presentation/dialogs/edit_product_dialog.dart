import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/base_dialog.dart';
import 'package:store_manager/features/products/domain/entities/product.dart';
import 'package:store_manager/features/products/presentation/cubits/products_cubit.dart';
import 'package:store_manager/utilities/toast.dart';

class EditProductDialog extends StatefulWidget {
  final Product product;
  const EditProductDialog({super.key, required this.product});

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final codeController = TextEditingController();
  final nameController = TextEditingController();
  final buyPriceController = TextEditingController();
  final sellPriceController = TextEditingController();
  final stockController = TextEditingController();

  void update() async {
    final code = codeController.text;
    final name = nameController.text;
    final buyPrice = buyPriceController.text;
    final sellPrice = sellPriceController.text;
    final stock = stockController.text;
    final bool fieldsNotEmpty = code.isNotEmpty &&
        name.isNotEmpty &&
        buyPrice.isNotEmpty &&
        sellPrice.isNotEmpty &&
        stock.isNotEmpty;

    final bool validNumberFields = int.tryParse(buyPrice) != null &&
        int.tryParse(sellPrice) != null &&
        int.tryParse(stock) != null;

    if (!fieldsNotEmpty) {
      Toast.warningToast("Campos vacios", "Por favor llene todos los campos.");
      return;
    }
    if (!validNumberFields) {
      Toast.warningToast(
          "Números no validos", "Introduzca valores numéricos válidos.");
      return;
    }

    if (int.parse(buyPrice) > int.parse(sellPrice)) {
      Toast.warningToast("Precio de compra mayor",
          "El precio de compra no puede ser mayor al precio de venta.");
      return;
    }

    if (code != widget.product.code) {
      final bool codeExists =
          await context.read<ProductsCubit>().productCodeExists(code);

      if (codeExists) {
        Toast.warningToast(
            "Código existente", "El producto con código #$code ya existe.");
        return;
      }
    }

    if (!mounted) return;

    final product = Product(
      id: widget.product.id,
      code: code,
      name: name,
      buyPrice: int.parse(buyPrice),
      sellPrice: int.parse(sellPrice),
      stock: int.parse(stock),
    );
    Navigator.of(context).pop();
    context.read<ProductsCubit>().updateProduct(product);
  }

  @override
  void initState() {
    super.initState();
    codeController.text = widget.product.code;
    nameController.text = widget.product.name;
    buyPriceController.text = widget.product.buyPrice.toString();
    sellPriceController.text = widget.product.sellPrice.toString();
    stockController.text = widget.product.stock.toString();
  }

  @override
  void dispose() {
    super.dispose();
    codeController.dispose();
    nameController.dispose();
    sellPriceController.dispose();
    buyPriceController.dispose();
    stockController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "Editar producto",
      buttonText: "Editar",
      width: 380,
      height: 480,
      onPressed: update,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevarmTextInputField(
            hintText: "Código",
            prefixText: "#",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: codeController,
            onTapSuffix: () => codeController.clear(),
          ),
          ElevarmTextInputField(
            hintText: "Nombre",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: nameController,
            onTapSuffix: () => nameController.clear(),
          ),
          ElevarmTextInputField(
            hintText: "Precio compra",
            prefixText: "\$",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: buyPriceController,
            onTapSuffix: () => buyPriceController.clear(),
          ),
          ElevarmTextInputField(
            hintText: "Precio venta",
            prefixText: "\$",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: sellPriceController,
            onTapSuffix: () => sellPriceController.clear(),
          ),
          ElevarmTextInputField(
            hintText: "Unidades",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: stockController,
            onTapSuffix: () => stockController.clear(),
          ),
        ],
      ),
    );
  }
}
