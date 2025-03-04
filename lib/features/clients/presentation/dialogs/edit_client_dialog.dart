import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/base_dialog.dart';
import 'package:store_manager/features/clients/domain/entities/client.dart';
import 'package:store_manager/features/clients/presentation/cubits/clients_cubit.dart';
import 'package:store_manager/utilities/toast.dart';

class EditClientDialog extends StatefulWidget {
  final Client client;
  const EditClientDialog({super.key, required this.client});

  @override
  State<EditClientDialog> createState() => _EditClientDialogState();
}

class _EditClientDialogState extends State<EditClientDialog> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final hoodController = TextEditingController();

  @override
  void initState() {
    super.initState();
    phoneController.text = widget.client.phone;
    nameController.text = widget.client.name;
    addressController.text = widget.client.address;
    hoodController.text = widget.client.hood;
  }

  void update() async {
    final phone = phoneController.text;
    final name = nameController.text;
    final address = addressController.text;
    final hood = hoodController.text;

    final bool fieldsNotEmpty = phone.isNotEmpty &&
        name.isNotEmpty &&
        address.isNotEmpty &&
        hood.isNotEmpty;

    final bool validPhoneField =
        phone.length == 10 && int.tryParse(phone) != null;

    if (!fieldsNotEmpty) {
      Toast.warningToast("Campos vacios", "Por favor llene todos los campos.");
      return;
    }

    if (!validPhoneField) {
      Toast.warningToast(
          "Teléfono no válido", "Introduzca un número de teléfono válido.");
      return;
    }

    if (phone != widget.client.phone) {
      final bool phoneExists =
          await context.read<ClientsCubit>().clientPhoneExists(phone);

      if (phoneExists) {
        Toast.warningToast(
            "Teléfono existente", "El teléfono ya está registrado.");
        return;
      }
    }

    if (!mounted) return;

    final Client client = Client(
      id: widget.client.id,
      phone: phone,
      name: name,
      address: address,
      hood: hood,
    );

    Navigator.of(context).pop();
    await context.read<ClientsCubit>().updateClient(client);
  }

  @override
  void dispose() {
    super.dispose();
    phoneController.dispose();
    nameController.dispose();
    addressController.dispose();
    hoodController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "",
      buttonText: "",
      width: 380,
      height: 480,
      onPressed: update,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevarmTextInputField(
            hintText: "Teléfono",
            prefixText: "+57",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: phoneController,
            onTapSuffix: () => phoneController.clear(),
          ),
          ElevarmTextInputField(
            hintText: "Nombre",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: nameController,
            onTapSuffix: () => nameController.clear(),
          ),
          ElevarmTextInputField(
            hintText: "Dirección",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: addressController,
            onTapSuffix: () => addressController.clear(),
          ),
          ElevarmTextInputField(
            hintText: "Barrio",
            suffixIconAssetName: HugeIcons.strokeRoundedCancel01,
            controller: hoodController,
            onTapSuffix: () => hoodController.clear(),
          ),
        ],
      ),
    );
  }
}
