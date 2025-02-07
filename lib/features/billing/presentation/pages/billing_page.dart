import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/layout_header.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/layout_table.dart';
import 'package:store_manager/features/app_layout/presentation/widgets/table_widgets.dart';
import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/domain/constants/billing_constants.dart';
import 'package:store_manager/features/billing/presentation/cubits/billing_cubit.dart';
import 'package:store_manager/features/billing/presentation/cubits/billing_state.dart';
import 'package:store_manager/features/billing/presentation/dialogs/create_bill_dialog.dart';
import 'package:store_manager/utilities/format_utilities.dart';

class BillingPage extends StatefulWidget {
  const BillingPage({super.key});

  @override
  State<BillingPage> createState() => _BillingPageState();
}

class _BillingPageState extends State<BillingPage> {
  late final billingCubit = context.read<BillingCubit>();

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    billingCubit.readBills();
  }

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BillingCubit, BillingState>(
      listener: (context, state) {},
      builder: (context, state) {
        Widget content = SizedBox.shrink();

        if (state is BillsLoading) {
          content = Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is BillsEmpty) {
          content = Center(child: Text("No existen facturas."));
        } else if (state is BillsList) {
          content = LayoutTable(
              columns: BillingConstants.columns, data: data(state.bills));
        }

        return Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              LayoutHeader(
                  onSearch: (p0) => billingCubit.searchBills(p0),
                  onClearSearch: () => searchController.clear(),
                  onCreate: () => showDialog(
                        context: context,
                        builder: (context) => CreateBillDialog(),
                      ),
                  controller: searchController),
              Expanded(child: content),
            ],
          ),
        );
      },
    );
  }

  List<DataRow> data(List<Bill> bills) => bills.map((e) => row(e)).toList();

  DataRow row(Bill bill) {
    return DataRow(
      cells: [
        TableWidgets.tableCell(bill.id.toString()),
        TableWidgets.tableCell(FormatUtilities.formattedDate(bill.date)),
        TableWidgets.tableCell(bill.clientPhone),
        TableWidgets.tableCell(FormatUtilities.formattedPrice(bill.total)),
        TableWidgets.tableActionsCell(
          () {},
          () {},
        ),
      ],
    );
  }
}
