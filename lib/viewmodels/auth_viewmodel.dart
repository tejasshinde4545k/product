import 'package:flutter/foundation.dart';
import 'package:todo/services/auth_service.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthService _authService;

  AuthViewModel({AuthService? authService})
    : _authService = authService ?? AuthService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool? _isLoggedIn;
  bool? get isLoggedIn => _isLoggedIn;

  Future<void> checkAuth() async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 1));

    final token = await _authService.getToken();
    _isLoggedIn = token != null && token.isNotEmpty;

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String mobile, String pin) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final data = await _authService.login(
        mobileNo: mobile,
        loginPin: int.parse(pin),
      );

      if (data["status"] == true) {
        final token = data["token"] as String;
        await _authService.saveToken(token);

        _isLoggedIn = true;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _errorMessage = data["message"] as String? ?? "Login failed";
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _errorMessage = "Error: $e";
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    await _authService.removeToken();
    _isLoggedIn = false;
    notifyListeners();
  }
}
