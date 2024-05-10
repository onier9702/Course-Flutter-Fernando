import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/presentation/providers/providers.dart';


final goRouterNotifierProvider = Provider((ref) {
  final authNotifier = ref.read(authProvider.notifier);

  return GoRouterNotifier(authNotifier);
});

class GoRouterNotifier extends ChangeNotifier {

  final AuthNotifier _authNotifier;

  AuthStatus _authStatus = AuthStatus.checking;

  // Constructor
  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  // Getter
  AuthStatus get authStatus => _authStatus;

  // Setter
  set authStatus(AuthStatus value) {
    _authStatus = value;
    notifyListeners();
  }

}
