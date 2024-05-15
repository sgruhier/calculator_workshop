class AuthService {
  bool isAuthenticated = false;

  bool login(String code) {
    isAuthenticated = (code == 'azeaze');
    return isAuthenticated;
  }

  void logout() {
    isAuthenticated = false;
  }
}

final AuthService authService = AuthService();
