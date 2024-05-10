import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';

import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:teslo_shop/features/shared/infrastructure/services/key_value_storage_service_impl.dart';


// 3- state notifier provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {

  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService
  );
});

enum AuthStatus { checking, authenticated, notAuthenticated }

// 1- create the state provider
class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = ''
  });

  AuthState copyWith({
    AuthStatus? authStatus,
    User? user,
    String? errorMessage,
  }) => AuthState(
    authStatus: authStatus ?? this.authStatus,
    user: user ?? this.user,
    errorMessage: errorMessage ?? this.errorMessage,
  );
  
}

// 2- State notifier
class AuthNotifier extends StateNotifier<AuthState> {

  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }): super(AuthState()) {
    // always verify auth status when app init
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {

      final user = await authRepository.login(email, password);
      _setLoggedUser(user);

    } on CustomError catch(e) {
      logout(e.message);
    } catch (e) {
      logout('Error not handled yet');
    }
  }

  void registerUser(String email, String password, String fullname) async {
    await Future.delayed(const Duration(milliseconds: 500));

    try {

      final user = await authRepository.register(email, password, fullname);
      _setLoggedUser(user);

    } on CustomError catch(e) {
      logout(e.message);
    } catch (e) {
      logout('Error not handled yet');
    }
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) return logout();

    try {

      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
      
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(User user) async {
    // save token
    await keyValueStorageService.setKeyValue('token', user.token);

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  Future<void> logout([String? errorMessage]) async{
    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
    );

    // clean token
    await keyValueStorageService.removeKey('token');
  }
}
