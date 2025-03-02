import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/billing/domain/entities/bill.dart';
import 'package:store_manager/features/billing/presentation/cubits/billing_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Design Dashboard
    return Center(
      child: ElevarmPrimaryButton.text(
        text: "Prueba",
        onPressed: () {
          final billingCubit = context.read<BillingCubit>();
          billingCubit.createBill(
            Bill(date: DateTime.now(), clientPhone: "3228906590", total: 10000),
            [],
          );
        },
      ),
    );
  }
}
