import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/auth/presentation/cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  final void Function()? togglePages;
  const LoginPage({super.key, required this.togglePages});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isObscure = true;

  void login() {
    final String email = emailController.text;
    final String password = passwordController.text;

    final authCubit = context.read<AuthCubit>();

    if (email.isNotEmpty && password.isNotEmpty) {
      authCubit.login(email, password);
    } else {
      //Implement input errors
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          height: 500,
          child: ElevarmElevatedCard(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevarmIcon(
                  HugeIcons.strokeRoundedSquareLock01,
                  size: 60,
                ),
                const SizedBox(height: 30),
                ElevarmTextInputField(
                  hintText: "Correo",
                  controller: emailController,
                ),
                const SizedBox(height: 12),
                ElevarmTextInputField(
                  hintText: "Contraseña",
                  controller: passwordController,
                  obscureText: isObscure,
                  suffixIconAssetName: isObscure
                      ? HugeIcons.strokeRoundedView
                      : HugeIcons.strokeRoundedViewOffSlash,
                  onTapSuffix: () => setState(() => isObscure = !isObscure),
                  onFieldSubmitted: (p0) => login(),
                ),
                const SizedBox(height: 24),
                ElevarmPrimaryButton.text(
                    text: "Iniciar Sesión", onPressed: login),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No eres usuario? "),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        "Registrate aquí",
                        style: TextStyle(
                          color: ElevarmColors.primary700,
                          fontWeight: ElevarmFontWeights.semibold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
