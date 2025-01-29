import 'package:store_manager/features/auth/domain/entities/app_user.dart';
import 'package:store_manager/features/auth/domain/repos/auth_repo.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseAuthRepo implements AuthRepo {
  final supabaseAuth = Supabase.instance.client.auth;
  final supabaseClient = Supabase.instance.client;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    try {
      // Attempt SignIn
      final AuthResponse authResponse = await supabaseAuth.signInWithPassword(
          email: email, password: password);

      final clientResponse = await supabaseClient
          .from("users")
          .select("*")
          .eq("id", authResponse.user!.id)
          .single();

      AppUser user = AppUser(
        uid: authResponse.user!.id,
        email: authResponse.user!.email!,
        name: clientResponse["name"],
      );
      return user;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
      String name, String email, String password) async {
    try {
      // Attempt SignUp
      final AuthResponse authResponse =
          await supabaseAuth.signUp(email: email, password: password);
      final clientResponse = await supabaseClient.from("users").insert({
        "id": authResponse.user!.id,
        "name": name,
      }).select("*");
      AppUser user = AppUser(
        uid: authResponse.user!.id,
        email: authResponse.user!.email!,
        name: clientResponse[0]["name"],
      );
      return user;
    } catch (e) {
      throw Exception("Login failed: $e");
    }
  }

  @override
  Future<void> logOut() async {
    await supabaseAuth.signOut();
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    final supabaseUser = supabaseAuth.currentUser;

    if (supabaseUser == null) {
      return null;
    }

    final clientResponse = await supabaseClient
        .from("users")
        .select("*")
        .eq("id", supabaseUser.id)
        .single();

    return AppUser(
      uid: supabaseUser.id,
      email: supabaseUser.email!,
      name: clientResponse["name"],
    );
  }
}
