import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:store_manager/features/auth/domain/entities/app_user.dart';
import 'package:store_manager/features/auth/domain/repos/auth_repo.dart';
import 'package:store_manager/features/auth/presentation/cubits/auth_states.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  // Check user authenticated
  void checkAuth() async {
    final AppUser? user = await authRepo.getCurrentUser();

    if (user != null) {
      _currentUser = user;
      emit(Authenticated(user: user));
    } else {
      emit(Unauthenticated());
    }
  }

  // Get current user
  AppUser? get currentUser => _currentUser;

  // Login with email & password
  Future<void> login(String email, String password) async {
    try {
      emit(AuthLoading());
      final user = await authRepo.loginWithEmailPassword(email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }

  // register with emain & password
  Future<void> register(String name, String email, String password) async {
    try {
      emit(AuthLoading());
      final user =
          await authRepo.registerWithEmailPassword(name, email, password);

      if (user != null) {
        _currentUser = user;
        emit(Authenticated(user: user));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
      emit(Unauthenticated());
    }
  }

  // Logout
  Future<void> logout() async {
    authRepo.logOut();
    emit(Unauthenticated());
  }
}
