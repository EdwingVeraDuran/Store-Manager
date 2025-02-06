import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/layout_header.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/layout_table.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/table_widgets.dart';
import 'package:store_manager/features/clients/domain/constants/clients_costants.dart';
import 'package:store_manager/features/clients/domain/entities/client.dart';
import 'package:store_manager/features/clients/presentation/cubits/clients_cubit.dart';
import 'package:store_manager/features/clients/presentation/cubits/clients_state.dart';
import 'package:store_manager/features/clients/presentation/dialogs/create_client_dialog.dart';
import 'package:store_manager/features/clients/presentation/dialogs/edit_client_dialog.dart';
import 'package:store_manager/utilities/toast.dart';

class ClientsPage extends StatefulWidget {
  const ClientsPage({super.key});

  @override
  State<ClientsPage> createState() => _ClientsPageState();
}

class _ClientsPageState extends State<ClientsPage> {
  late final clientsCubit = context.read<ClientsCubit>();

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    clientsCubit.readClients();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientsCubit, ClientsState>(
      listener: (context, state) {
        if (state is ClientCreated) {
          Toast.succesToast("Cliente creado",
              "Se ha creado correctamente el cliente #${state.client.phone} - ${state.client.name}");
        }
        if (state is ClientUpdated) {
          Toast.succesToast("Cliente actualizado",
              "Se ha actualizado el cliente #${state.client.phone} - ${state.client.name}");
        }

        if (state is ClientDeleted) {
          Toast.succesToast("Cliente eliminado",
              "Se ha eliminado el cliente #${state.client.phone} - ${state.client.name}");
        }
      },
      builder: (context, state) {
        Widget content = SizedBox.shrink();

        if (state is ClientsLoading) {
          content = Center(child: CircularProgressIndicator());
        } else if (state is ClientsEmpty) {
          content = Center(child: Text("No existen clientes."));
        } else if (state is ClientsList) {
          content = LayoutTable(
              columns: ClientsCostants.columns, data: data(state.clients));
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              LayoutHeader(
                controller: searchController,
                onSearch: (p0) => clientsCubit.searchClients(p0),
                onClearSearch: () => searchController.clear(),
                onCreate: () => showDialog(
                    context: context,
                    builder: (context) => CreateClientDialog()),
              ),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }

  List<DataRow> data(List<Client> clients) =>
      clients.map((e) => row(e)).toList();

  DataRow row(Client client) {
    return DataRow(
      cells: [
        TableWidgets.tableCell(client.phone),
        TableWidgets.tableCell(client.name),
        TableWidgets.tableCell(client.address),
        TableWidgets.tableCell(client.hood),
        TableWidgets.tableActionsCell(
          () => showDialog(
              context: context,
              builder: (context) => EditClientDialog(client: client)),
          () => ElevarmConfirmAlertDialog(
            title: "Eliminar cliente",
            subtitle:
                "Desea eliminar el cliente #${client.phone} - ${client.name}",
            variant: ElevarmDialogVariant.danger,
            negativeText: "Cancelar",
            onNegativeButton: () => Navigator.of(context).pop(),
            positiveText: "Eliminar",
            onPositiveButton: () {
              context.read<ClientsCubit>().deleteClient(client.id!);
              Navigator.of(context).pop();
            },
          ).show(context),
        ),
      ],
    );
  }
}
