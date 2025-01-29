import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/clients/domain/entities/client.dart';
import 'package:store_manager/features/clients/presentation/cubits/clients_cubit.dart';
import 'package:store_manager/utilities/toast.dart';

class CreateClientDialog extends StatefulWidget {
  const CreateClientDialog({super.key});

  @override
  State<CreateClientDialog> createState() => _CreateClientDialogState();
}

class _CreateClientDialogState extends State<CreateClientDialog> {
  final phoneController = TextEditingController();
  final nameController = TextEditingController();
  final addressController = TextEditingController();
  final hoodController = TextEditingController();

  void create() async {
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

    final bool phoneExists =
        await context.read<ClientsCubit>().clientPhoneExists(phone);

    if (phoneExists) {
      Toast.warningToast(
          "Teléfono existente", "El teléfono ya está registrado.");
      return;
    }

    if (!mounted) return;

    final Client client = Client(
      phone: phone,
      name: name,
      address: address,
      hood: hood,
    );

    Navigator.of(context).pop();
    await context.read<ClientsCubit>().createClient(client);
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
    return Dialog(
      backgroundColor: Colors.transparent,
      child: SizedBox(
        width: 380,
        height: 480,
        child: ElevarmElevatedCard(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Crear Cliente",
                    style: TextStyle(
                      fontSize: ElevarmFontSizes.xl,
                      fontWeight: ElevarmFontWeights.bold,
                    ),
                  ),
                  ElevarmTertiaryNeutralButton.iconOnly(
                    iconAssetName: HugeIcons.strokeRoundedCancel01,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Expanded(
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
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevarmPrimaryButton.text(
                    text: "Crear",
                    onPressed: create,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
