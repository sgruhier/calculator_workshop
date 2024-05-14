class AuthService {
  bool isAuthenticated = false;

  void login(String code) {
    isAuthenticated = (code == 'azeaze');
  }

  void logout() {
    isAuthenticated = false;
  }
}

final AuthService authService = AuthService();
