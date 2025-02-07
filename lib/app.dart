import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/auth/data/supabase_auth_repo.dart';
import 'package:store_manager/features/auth/presentation/cubits/auth_cubit.dart';
import 'package:store_manager/features/auth/presentation/cubits/auth_states.dart';
import 'package:store_manager/features/auth/presentation/pages/auth_page.dart';
import 'package:store_manager/features/app_layout/presentation/pages/app_layout.dart';
import 'package:store_manager/features/billing/data/supabase_billing_repo.dart';
import 'package:store_manager/features/billing/presentation/cubits/billing_cubit.dart';
import 'package:store_manager/features/clients/data/supabase_clients_repo.dart';
import 'package:store_manager/features/clients/presentation/cubits/clients_cubit.dart';
import 'package:store_manager/features/products/data/supabase_products_repo.dart';
import 'package:store_manager/features/products/presentation/cubits/products_cubit.dart';
import 'package:store_manager/utilities/app_theme.dart';
import 'package:toastification/toastification.dart';

class MainApp extends StatelessWidget {
  final authRepo = SupabaseAuthRepo();
  final productsRepo = SupabaseProductsRepo();
  final clientsRepo = SupabaseClientsRepo();
  final billingRepo = SupabaseBillingRepo();

  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
            create: (context) => AuthCubit(authRepo: authRepo)..checkAuth()),
        BlocProvider<ProductsCubit>(
            create: (context) => ProductsCubit(productsRepo: productsRepo)),
        BlocProvider(
            create: (context) => ClientsCubit(clientsRepo: clientsRepo)),
        BlocProvider(
            create: (context) => BillingCubit(billingRepo: billingRepo)),
      ],
      child: ToastificationWrapper(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, authState) {
              if (authState is Unauthenticated) {
                return const AuthPage();
              }

              if (authState is Authenticated) {
                return const LayoutPage();
              } else {
                return const Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
