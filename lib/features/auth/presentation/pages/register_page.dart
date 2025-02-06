import 'package:elevarm_ui/elevarm_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:store_manager/features/auth/presentation/cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? togglePages;
  const RegisterPage({super.key, required this.togglePages});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool isObscure = true;

  void register() {
    final String name = nameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String confirmPassword = confirmPasswordController.text;
    final bool validPassword = password == confirmPassword;

    if (name.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        confirmPassword.isNotEmpty &&
        validPassword) {
      // Implement password validation errors
      final authCubit = context.read<AuthCubit>();
      authCubit.register(name, email, password);
    } else {
      // Implement input erros
    }
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
                  hintText: "Nombre",
                  controller: nameController,
                ),
                const SizedBox(height: 12),
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
                  onFieldSubmitted: (p0) => register(),
                ),
                const SizedBox(height: 12),
                ElevarmTextInputField(
                  hintText: "Confirmar Contraseña",
                  controller: confirmPasswordController,
                  obscureText: isObscure,
                  suffixIconAssetName: isObscure
                      ? HugeIcons.strokeRoundedView
                      : HugeIcons.strokeRoundedViewOffSlash,
                  onTapSuffix: () => setState(() => isObscure = !isObscure),
                ),
                const SizedBox(height: 24),
                ElevarmPrimaryButton.text(
                  text: "Registrarse",
                  onPressed: register,
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Ya eres usuario? "),
                    GestureDetector(
                      onTap: widget.togglePages,
                      child: Text(
                        "Ingresa aquí",
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
