import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/auth/presentation/cubits/auth_cubit.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    //TODO: Design Dashboard
    return Center(
      child: ElevarmPrimaryButton.text(
        text: "Cerrar Sesión",
        onPressed: () {
          final authCubit = context.read<AuthCubit>();
          authCubit.logout();
        },
      ),
    );
  }
}
