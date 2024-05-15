import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  bool _isAuthenticated = false;

  Future<bool> get isAuthenticated async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isAuthenticated') ?? false;
  }

  Future<bool> login(String code) async {
    _isAuthenticated = (code == 'azeaze');
    await _save();
    return _isAuthenticated;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    await _save();
  }

  Future<void> _save() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isAuthenticated', _isAuthenticated);
  }
}

final AuthService authService = AuthService();
